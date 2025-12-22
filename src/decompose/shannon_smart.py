from __future__ import annotations

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


def _decompose(bits: int, vars_order: Tuple[Signal, ...], builder: NetlistBuilder) -> Signal:
    # Recursive Shannon expansion
    n_vars = len(vars_order)
    if n_vars <= 6:
        init = compute_lut_init(bits, n_vars)
        return builder.add_lut(vars_order, init=init, tag=f"leaf_{n_vars}")

    sel = vars_order[-2:] 
    f00_bits, f01_bits, f10_bits, f11_bits = cofactor(bits, n_vars, [n_vars - 1, n_vars - 2])
    f00_sig = _decompose(f00_bits, vars_order[:-2], builder)
    f01_sig = _decompose(f01_bits, vars_order[:-2], builder)
    f10_sig = _decompose(f10_bits, vars_order[:-2], builder)
    f11_sig = _decompose(f11_bits, vars_order[:-2], builder)
    return builder.add_lut(
        inputs=(f00_sig, f01_sig, f10_sig, f11_sig, sel[0], sel[1]),
        init=mux4_init(),
        tag=f"mux_sel_{sel[0].idx}_{sel[1].idx}",
    )


def build_netlist(tt: TruthTable, share: bool = False, smart: bool = False) -> Netlist:
    # Top-level builder function
    builder = NetlistBuilder(num_inputs=tt.n_inputs, share=share, smart=smart)
    inputs = tuple(Signal("x", i) for i in range(tt.n_inputs))
    if (tt.bits == 0) :
        return builder.build(Signal("b", 0))
    elif (tt.bits == (1 << (1<<tt.n_inputs)) - 1):
        return builder.build(Signal("b", 1))
    
    output = _decompose(tt.bits, inputs, builder)
    return builder.build(output)
