from __future__ import annotations

from .shannon_single import build_netlist as build_shannon_single
from .shannon_multi import build_netlist as build_shannon_multi
from ..tt_io import TruthTable
from ..netlist import Netlist


def build_netlist(tt: TruthTable, method: str = "shannon_single") -> Netlist:
    # Dispatch to a specific decomposition strategy
    if method == "shannon_single":
        return build_shannon_single(tt, share=False)
    if method == "shannon_single_share":
        return build_shannon_single(tt, share=True)
    if method == "shannon_multi":
        return build_shannon_multi(tt, share=True)
    raise ValueError(f"Unknown method '{method}'")

