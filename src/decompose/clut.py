from __future__ import annotations

from typing import List, Tuple

from ..netlist import NetlistBuilder, Signal
from .shannon_smart import build_signal as build_shannon_smart


def unpack_values(tt_bits: int, out_width: int, total_input_bits: int) -> List[int]:
    
    # Expand a packed truth table into per-entry output words using known entry count

    n_entries = 1 << total_input_bits
    vals = []
    for entry in range(n_entries):
        v = 0
        for b in range(out_width):
            v |= ((tt_bits >> (entry * out_width + b)) & 1) << b
        vals.append(v)
    return vals

def split_tss_td(tt_bits: int, total_input_bits: int, out_width: int) -> Tuple[int, int, int, int, int, int]:

    # We search over sub-sampling factors s, low-part width wL, and a small overlap v (extra bits
    # parked in Tss) to find a valid (Tss, Td) decomposition with minimum bit cost.

    # Returns (tss_bits, td_bits, tss_out_width, td_out_width, shift_bits=wL).

    values = unpack_values(tt_bits, out_width, total_input_bits)
    best = None  # (cost, s, wL, wH, tss_entries, td_entries, shift)

    for s in range(0, total_input_bits + 1):
        block_size = 1 << s
        num_blocks = 1 << (total_input_bits - s)
        blocks = [values[i * block_size : (i + 1) * block_size] for i in range(num_blocks)]

        for wL in range(1, out_width + 1):
            wH = max(1, out_width - wL)
            shift_bits = out_width - wH  # per Algorithm 2, H holds upper bits of min
            max_delta = (1 << wL) - 1

            tss_entries: List[int] = []
            td_entries: List[int] = []
            valid = True

            # Validity per Algorithm 2: for each block ensure max-min fits in wL after removing upper bits of min
            for blk in blocks:
                M = max(blk)
                m = min(blk)
                mask = (1 << (out_width - wH)) - 1  # low bits mask
                H = m - (m & mask)  # upper bits of min
                Mlow = M - H  # max delta on this slice
                if Mlow >= (1 << wL):
                    valid = False
                    break
                # Store base and all deltas for reconstruction
                base = H >> shift_bits
                tss_entries.append(base & ((1 << wH) - 1))
                for val in blk:
                    delta = val - (base << shift_bits)
                    td_entries.append(delta)

            if not valid:
                continue

            # Final reconstruction check
            for entry_idx, orig_val in enumerate(values):
                blk_idx = entry_idx >> s if s > 0 else entry_idx
                base_val = tss_entries[blk_idx]
                delta_val = td_entries[entry_idx]
                recon = (base_val << shift_bits) + delta_val
                if recon != orig_val:
                    valid = False
                    break

            if not valid:
                continue

            cost = num_blocks * wH + (1 << total_input_bits) * wL
            if best is None or cost < best[0]:
                best = (cost, s, wL, wH, tss_entries, td_entries, shift_bits)

    if best is None:
        raise ValueError("LDTC: no valid (s, wL, overlap) found.")

    _, s, wL, wH, tss_entries, td_entries, shift_bits = best
    num_blocks = 1 << (total_input_bits - s)

    # Pack Tss entries (wH bits each)
    tss_bits = 0
    for idx, val in enumerate(tss_entries):
        tss_bits |= (val & ((1 << wH) - 1)) << (idx * wH)

    # Pack Td entries (wL bits each), full size
    td_bits = 0
    for idx, val in enumerate(td_entries):
        td_bits |= (val & ((1 << wL) - 1)) << (idx * wL)

    tss_out_width = wH
    td_out_width = wL
    return tss_bits, td_bits, tss_out_width, td_out_width, shift_bits, s


def _extract_output_bits(bits: int, out_width: int, out_idx: int, n_entries: int) -> int:
    # Extract a single output bit slice from a packed multi-output table 
    acc = 0
    for i in range(n_entries):
        bit = (bits >> (i * out_width + out_idx)) & 1
        acc |= bit << i
    return acc

def _similarity_matrix(subtables: List[List[int]], out_width: int, max_shift: int) -> List[List[int]]:
    # sm[i][j] = smallest t such that ST_i >> t == ST_j, else -1
    n = len(subtables)
    sm = [[-1] * n for _ in range(n)]
    for i in range(n):
        for j in range(n):
            for t in range(max_shift + 1):
                if all((subtables[i][k] >> t) == subtables[j][k] for k in range(len(subtables[i]))):
                    sm[i][j] = t
                    break
    return sm


def _cluster_subtables(values: List[int], out_width: int, ws: int, max_shift: int):
    # Partition Td into sub-tables of size 2^ws and cluster by right-shift similarity
    group = 1 << ws
    num_sub = len(values) // group
    subtables = [values[i * group : (i + 1) * group] for i in range(num_sub)]

    remaining_ids = list(range(num_sub))
    ust: List[List[int]] = []
    tidx = [0] * num_sub
    trsh = [0] * num_sub

    while remaining_ids:
        subset = [subtables[i] for i in remaining_ids]
        sm = _similarity_matrix(subset, out_width, max_shift)

        best_local = None
        best_cnt = -1
        for i in range(len(remaining_ids)):
            cnt = sum(1 for j in range(len(remaining_ids)) if sm[i][j] != -1)
            if cnt > best_cnt:
                best_cnt = cnt
                best_local = i

        gen_global = remaining_ids[best_local]
        ust_idx = len(ust)
        ust.append(subtables[gen_global])

        to_remove: List[int] = []
        for j_local, j_global in enumerate(remaining_ids):
            if sm[best_local][j_local] != -1:
                tidx[j_global] = ust_idx
                trsh[j_global] = sm[best_local][j_local]
                to_remove.append(j_global)

        remaining_ids = [g for g in remaining_ids if g not in to_remove]

    return ust, tidx, trsh, group


def split_tust_trsh_tidx(td_bits: int, out_width: int, total_input_bits: int, max_ws: int | None = None, max_shift: int = 3) -> Tuple[int, int, int, int, int, int, int, int, int, int]:
    # Cluster Td into unique sub-tables (UST) plus Tidx/Trsh per sub-table
    values = unpack_values(td_bits, out_width, total_input_bits)
    best = None  # (bit_cost, ws, ust, tidx, trsh, group, widx, wrsh)
    ws_limit = total_input_bits if max_ws is None else min(max_ws, total_input_bits)
    for ws in range(1, ws_limit + 1):
        ust, tidx, trsh, group = _cluster_subtables(values, out_width, ws, max_shift)
        widx = max(1, len(ust).bit_length())
        wrsh = max(1, (max(trsh) if trsh else 0).bit_length())
        bit_cost = len(ust) * group * out_width + len(tidx) * (widx + wrsh)
        if best is None or bit_cost < best[0]:
            best = (bit_cost, ws, ust, tidx, trsh, group, widx, wrsh)
    if best is None:
        raise ValueError("CLUT: clustering failed")
    _, ws, ust, tidx, trsh, group, widx, wrsh = best

    # Pack UST (concatenate all unique sub-tables)
    tust_bits = 0
    for sub_idx, sub in enumerate(ust):
        for off, val in enumerate(sub):
            idx = sub_idx * group + off
            tust_bits |= (val & ((1 << out_width) - 1)) << (idx * out_width)

    # Pack per-sub-table Tidx/Trsh (one entry per sub-table)
    tidx_bits = 0
    for idx, val in enumerate(tidx):
        tidx_bits |= (val & ((1 << widx) - 1)) << (idx * widx)
    trsh_bits = 0
    for idx, val in enumerate(trsh):
        trsh_bits |= (val & ((1 << wrsh) - 1)) << (idx * wrsh)

    return (
        tust_bits,
        tidx_bits,
        trsh_bits,
        out_width,
        widx,
        wrsh,
        len(ust),
        len(tidx),
        group,
        ws,
    )


def build_clut(
    tt_bits: int,
    total_input_bits: int,
    out_width: int,
    builder: NetlistBuilder,
) -> Tuple[Tuple[Signal, ...], Tuple[Signal, ...], dict]:
    # LDTC split first
    tss_bits, td_bits, tss_out_width, td_out_width, shift_bits, s = split_tss_td(tt_bits, total_input_bits, out_width)

    # Cluster Td into UST/Tidx/Trsh
    (
        tust_bits,
        tidx_bits,
        trsh_bits,
        tust_out_width,
        tidx_width,
        trsh_width,
        ust_count,
        num_subtables,
        group_size,
        ws,
    ) = split_tust_trsh_tidx(td_bits, td_out_width, total_input_bits)

    inputs = tuple(Signal("x", i) for i in range(total_input_bits))
    tss_inputs = inputs[s:] if s > 0 else inputs
    tss_entries = 1 << (total_input_bits - s)

    tss_outputs = []
    for idx in range(tss_out_width):
        bit_slice = _extract_output_bits(tss_bits, tss_out_width, idx, tss_entries)
        tss_outputs.append(build_shannon_smart(bit_slice, tss_inputs, builder))

    # Split address into upper (sub-table index) and lower (offset within sub-table)
    lower_inputs = inputs[:ws] if ws > 0 else ()
    upper_inputs = inputs[ws:] if ws > 0 else inputs

    sub_entries = num_subtables
    tidx_outputs = []
    for idx in range(tidx_width):
        bit_slice = _extract_output_bits(tidx_bits, tidx_width, idx, sub_entries)
        tidx_outputs.append(build_shannon_smart(bit_slice, upper_inputs, builder))

    trsh_outputs = []
    for idx in range(trsh_width):
        bit_slice = _extract_output_bits(trsh_bits, trsh_width, idx, sub_entries)
        trsh_outputs.append(build_shannon_smart(bit_slice, upper_inputs, builder))

    # TUST indexed by (lower bits, tidx)
    tust_entries = ust_count * group_size
    tust_inputs = tuple(lower_inputs) + tuple(tidx_outputs)
    tust_outputs = []
    for idx in range(tust_out_width):
        bit_slice = _extract_output_bits(tust_bits, tust_out_width, idx, tust_entries)
        tust_outputs.append(build_shannon_smart(bit_slice, tust_inputs, builder))

    combine_meta = {
        "tss_width": tss_out_width,
        "tust_width": tust_out_width,
        "tidx_width": tidx_width,
        "trsh_width": trsh_width,
        "orig_out_width": out_width,
        "shift_bits": shift_bits,
        "subsample_s": s,
        "ws": ws,
    }
    return tuple(tss_outputs), tuple(tust_outputs), tuple(trsh_outputs), tuple(tidx_outputs), combine_meta
