from __future__ import annotations

from typing import Tuple

from ..netlist import Netlist, NetlistBuilder, Signal
from ..tt_io import TruthTable


def cofactor(bits: int, n_vars: int, var_idx: int) -> Tuple[int, int]:
    # Return (f[var=0], f[var=1]) dropping variable `var_idx`

    if not (0 <= var_idx < n_vars):
        raise ValueError("var_idx out of range.")
    stride = 1 << var_idx # 2 to the power of var_idx
    block = stride << 1 # times by 2 (LSL 1)
    out_mask = 0
    f0 = 0
    f1 = 0
    for base in range(0, 1 << n_vars, block):
        for offset in range(stride):
            bit0 = (bits >> (base + offset)) & 1
            bit1 = (bits >> (base + offset + stride)) & 1
            f0 |= bit0 << out_mask
            f1 |= bit1 << out_mask
            out_mask += 1
    return f0, f1


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


def mux2_init() -> int:
    # INIT for a 3-input mux (I2=sel, I1=b, I0=a)
    truth = 0
    for i in range(8):
        a = (i >> 0) & 1
        b = (i >> 1) & 1
        s = (i >> 2) & 1
        out = b if s else a
        truth |= out << i
    return compute_lut_init(truth, 3)


def _decompose(bits: int, vars_order: Tuple[Signal, ...], builder: NetlistBuilder) -> Signal:
    # Recursive Shannon expansion
    n_vars = len(vars_order)
    if n_vars <= 6:
        init = compute_lut_init(bits, n_vars)
        return builder.add_lut(vars_order, init=init, tag=f"leaf_{n_vars}")

    sel = vars_order[-1]
    f0_bits, f1_bits = cofactor(bits, n_vars, n_vars - 1)
    f0_sig = _decompose(f0_bits, vars_order[:-1], builder)
    f1_sig = _decompose(f1_bits, vars_order[:-1], builder)

    return builder.add_lut(
        inputs=(f0_sig, f1_sig, sel),
        init=mux2_init(),
        tag=f"mux_sel_{sel.idx}",
    )


def build_netlist(tt: TruthTable, share: bool = False) -> Netlist:
    # Top-level builder function
    builder = NetlistBuilder(num_inputs=tt.n_inputs, share=share)
    inputs = tuple(Signal("x", i) for i in range(tt.n_inputs))
    output = _decompose(tt.bits, inputs, builder)
    return builder.build(output)

