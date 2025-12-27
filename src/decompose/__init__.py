from __future__ import annotations

from typing import Callable, Tuple

from .shannon_single import build_signal as build_shannon_single
from .shannon_multi import build_signal as build_shannon_multi
from .shannon_smart import build_signal as build_shannon_smart
from ..tt_io import TruthTable
from ..netlist import Netlist, NetlistBuilder, Signal


def _select_builder(method: str) -> Tuple[Callable[[int, Tuple[Signal, ...], NetlistBuilder], Signal], bool, bool]:
    if method == "shannon_single":
        return build_shannon_single, False, False
    if method == "shannon_single_share":
        return build_shannon_single, True, False
    if method == "shannon_multi":
        return build_shannon_multi, True, False
    if method == "shannon_smart":
        return build_shannon_smart, True, True
    raise ValueError(f"Unknown method '{method}'")


def build_netlist(tt: TruthTable, method: str = "shannon_single") -> Netlist:
    # Build a shared netlist covering all output bits
    build_fn, share, smart = _select_builder(method)
    builder = NetlistBuilder(
        total_input_bits=tt.total_input_bits,
        fanin=tt.fanin,
        in_width=tt.in_width,
        out_width=tt.out_width,
        share=share,
        smart=smart,
    )
    inputs = tuple(Signal("x", i) for i in range(tt.total_input_bits))

    outputs = []
    for out_idx in range(tt.out_width):
        bits = tt.output_bits(out_idx)
        outputs.append(build_fn(bits, inputs, builder))

    return builder.build(tuple(outputs))
