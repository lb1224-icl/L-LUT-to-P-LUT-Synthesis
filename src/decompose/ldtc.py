from __future__ import annotations

from typing import List, Tuple

from ..netlist import NetlistBuilder, Signal
from .shannon_smart import build_signal as build_shannon_smart


def split_tss_td(tt_bits: int, total_input_bits: int, out_width: int) -> Tuple[int, int, int, int, int, int]:

    # We search over sub-sampling factors s, low-part width wL, and a small overlap v (extra bits
    # parked in Tss) to find a valid (Tss, Td) decomposition with minimum bit cost.

    # Returns (tss_bits, td_bits, tss_out_width, td_out_width, shift_bits=wL).

    def unpack_values() -> List[int]:
        vals = []
        for entry in range(1 << total_input_bits):
            v = 0
            for b in range(out_width):
                v |= ((tt_bits >> (entry * out_width + b)) & 1) << b
            vals.append(v)
        return vals

    values = unpack_values()
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


def build_ldtc(
    tt_bits: int,
    total_input_bits: int,
    out_width: int,
    builder: NetlistBuilder,
) -> Tuple[Tuple[Signal, ...], Tuple[Signal, ...], dict]:
    # Build LUT cones for Tss and Td using the smart Shannon mapper.
    tss_bits, td_bits, tss_out_width, td_out_width, shift_bits, s = split_tss_td(tt_bits, total_input_bits, out_width)
    inputs = tuple(Signal("x", i) for i in range(total_input_bits))
    # Tss is indexed by the upper (total_input_bits - s) bits; Td uses all bits.
    tss_inputs = inputs[s:] if s > 0 else inputs
    tss_entries = 1 << (total_input_bits - s)
    td_entries = 1 << total_input_bits

    tss_outputs = []
    for idx in range(tss_out_width):
        bit_slice = _extract_output_bits(tss_bits, tss_out_width, idx, tss_entries)
        tss_outputs.append(build_shannon_smart(bit_slice, tss_inputs, builder))

    td_outputs = []
    for idx in range(td_out_width):
        bit_slice = _extract_output_bits(td_bits, td_out_width, idx, td_entries)
        td_outputs.append(build_shannon_smart(bit_slice, inputs, builder))

    combine_meta = {
        "tss_width": tss_out_width,
        "td_width": td_out_width,
        "orig_out_width": out_width,
        "shift_bits": shift_bits,
        "subsample_s": s,
    }
    return tuple(tss_outputs), tuple(td_outputs), combine_meta
