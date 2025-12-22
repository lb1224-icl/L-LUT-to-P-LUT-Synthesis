from __future__ import annotations

import math
from typing import List, Tuple

from ..netlist import Netlist, NetlistBuilder, Signal
from ..tt_io import TruthTable


def cofactor(bits: int, n_vars: int, var_idxs: List[int]) -> Tuple[int, int, int, int]:
    # Return (f[var=00], f[var=01], f[var=10], f[var=11]) dropping variables `var_idxs`

    if len(var_idxs) != 2:
        raise ValueError("var_idxs must contain exactly two indices.")
    idx0, idx1 = sorted(var_idxs)
    if not (0 <= idx0 < n_vars and 0 <= idx1 < n_vars and idx0 < idx1):
        raise ValueError("var_idxs out of range or not ordered.")

    stride0 = 1 << idx0  # 2 to the power of idx0
    stride1 = 1 << idx1  # 2 to the power of idx1
    block0 = stride0 << 1
    block1 = stride1 << 1
    out_mask = 0
    cofactors = [0, 0, 0, 0]
    for base1 in range(0, 1 << n_vars, block1):  # spans where idx1 toggles
        for base0 in range(base1, base1 + stride1, block0):  # idx0 toggles inside the idx1=0/1 half
            for offset0 in range(stride0):
                addr00 = base0 + offset0
                addr01 = addr00 + stride0
                addr10 = addr00 + stride1
                addr11 = addr01 + stride1
                cofactors[0] |= ((bits >> addr00) & 1) << out_mask
                cofactors[1] |= ((bits >> addr01) & 1) << out_mask
                cofactors[2] |= ((bits >> addr10) & 1) << out_mask
                cofactors[3] |= ((bits >> addr11) & 1) << out_mask
                out_mask += 1

    return tuple(cofactors)  # type: ignore[return-value]


def compute_lut_init(bits: int, n_vars: int) -> int:
    # Expand an n-var truth table (n<=6) into a 64-bit LUT INIT
    if n_vars > 6:
        raise ValueError("LUT6 INIT requires at most 6 inputs.")
    mask = (1 << n_vars) - 1
    init = 0
    for i in range(64):
        idx = i & mask
        init |= ((bits >> idx) & 1) << i
    return init

def mux4_init() -> int:
    # INIT for a 6-input mux (I5=sel[1], I4=sel[0], I3=d, I2=c, I1=b, I0=a)
    truth = 0
    for i in range(64):
        a = (i >> 0) & 1
        b = (i >> 1) & 1
        c = (i >> 2) & 1
        d = (i >> 3) & 1
        s0 = (i >> 4) & 1
        s1 = (i >> 5) & 1
        out = d if (s1 and s0) else c if (s1 and not s0) else b if (not s1 and s0) else a
        truth |= out << i
    return compute_lut_init(truth, 6)


def _entropy(p: float) -> float:
    if p <= 0.0 or p >= 1.0:
        return 0.0
    return -p * math.log2(p) - (1 - p) * math.log2(1 - p) 

def _hamming_norm(a: int, b: int, n_bits: int) -> float:
    # Normalized Hamming distance between two cofactors
    return (a ^ b).bit_count() / float(1 << n_bits)


def _score_cofactors(cofactors: Tuple[int, int, int, int], n_bits: int) -> Tuple[float, float]:
    # Return (entropy_sum, hamming_sum) for the four cofactors
    # Lower is better: use lexicographic compare so entropy dominates, then hamming
    norm = 1 << n_bits
    ent = sum(_entropy(bin(c).count("1") / norm) for c in cofactors)
    # Six pairwise distances among four cofactors
    hd = (
        _hamming_norm(cofactors[0], cofactors[1], n_bits)
        + _hamming_norm(cofactors[0], cofactors[2], n_bits)
        + _hamming_norm(cofactors[0], cofactors[3], n_bits)
        + _hamming_norm(cofactors[1], cofactors[2], n_bits)
        + _hamming_norm(cofactors[1], cofactors[3], n_bits)
        + _hamming_norm(cofactors[2], cofactors[3], n_bits)
    )
    return ent, hd

def _choose_pair(bits: int, vars_order: Tuple[Signal, ...]) -> Tuple[int, int, Tuple[int, int, int, int]]:
    # Try all variable pairs, pick the one with lowest (entropy, hamming) score
    n_vars = len(vars_order)
    best_pair = (n_vars - 2, n_vars - 1)
    best_cofs = cofactor(bits, n_vars, [n_vars - 2, n_vars - 1])
    best_score = _score_cofactors(best_cofs, n_vars - 2)
    for i in range(n_vars - 1):
        for j in range(i + 1, n_vars):
            cofs = cofactor(bits, n_vars, [i, j])
            score = _score_cofactors(cofs, n_vars - 2)
            if score < best_score: # lexicographic so comapres entropy first then hamming
                best_score = score
                best_pair = (i, j)
                best_cofs = cofs
    return best_pair, best_cofs

def _decompose(bits: int, vars_order: Tuple[Signal, ...], builder: NetlistBuilder) -> Signal:
    # Recursive Shannon expansion with entropy-based pair selection
    n_vars = len(vars_order)
    if n_vars <= 6:
        init = compute_lut_init(bits, n_vars)
        return builder.add_lut(vars_order, init=init, tag=f"leaf_{n_vars}")

    (p0, p1), (f00_bits, f01_bits, f10_bits, f11_bits) = _choose_pair(bits, vars_order)
    # Build next variable order without the chosen pair
    remaining = tuple(sig for k, sig in enumerate(vars_order) if k not in (p0, p1))
    sel0 = vars_order[p0]
    sel1 = vars_order[p1]

    f00_sig = _decompose(f00_bits, remaining, builder)
    f01_sig = _decompose(f01_bits, remaining, builder)
    f10_sig = _decompose(f10_bits, remaining, builder)
    f11_sig = _decompose(f11_bits, remaining, builder)
    return builder.add_lut(
        inputs=(f00_sig, f01_sig, f10_sig, f11_sig, sel0, sel1),
        init=mux4_init(),
        tag=f"mux_sel_{sel0.idx}_{sel1.idx}",
    )


def build_netlist(tt: TruthTable, share: bool = False, smart: bool = False) -> Netlist:
    # Top-level builder function
    builder = NetlistBuilder(num_inputs=tt.n_inputs, share=share, smart=smart)
    inputs = tuple(Signal("x", i) for i in range(tt.n_inputs))
    if tt.bits == 0:
        return builder.build(Signal("c", 0))
    elif tt.bits == (1 << (1 << tt.n_inputs)) - 1:
        return builder.build(Signal("c", 1))

    output = _decompose(tt.bits, inputs, builder)
    return builder.build(output)
