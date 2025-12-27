from __future__ import annotations

from dataclasses import dataclass
from typing import Dict, Iterable, List, Tuple


@dataclass(frozen=True)
class Signal:
    kind: str  # 'x' for primary input, 'n' for LUT output, 'b' for constant
    idx: int
    inv: bool = False

    def __post_init__(self) -> None:
        if self.kind not in {"x", "n", "b"}:
            raise ValueError(f"Unsupported signal kind: {self.kind}")
        if self.idx < 0:
            raise ValueError("Signal index must be non-negative.")

    def __str__(self) -> str:
        prefix = "~" if self.inv else ""
        return f"{prefix}{self.kind}{self.idx}"


@dataclass(frozen=True)
class LUTNode:
    # LUT6 instance

    node_id: int
    inputs: Tuple[Signal, ...]
    init: int
    tag: str


@dataclass
class Netlist:
    # Combinational netlist of LUT nodes (multi-output)

    total_input_bits: int
    fanin: int
    in_width: int
    out_width: int
    nodes: List[LUTNode]
    outputs: Tuple[Signal, ...]
    combine_mode: str | None = None  # e.g., "ldtc"
    combine_meta: dict | None = None  # e.g., widths/shift for ldtc

    def depth(self) -> int:
        # Return maximum logic level (PIs and consts at level 0)
        levels: Dict[Signal, int] = {Signal("x", i): 0 for i in range(self.total_input_bits)}
        levels[Signal("b", 0)] = 0
        levels[Signal("b", 1)] = 0
        max_level = 0
        for node in self.nodes:
            node_level = 1 + max(levels[Signal(inp.kind, inp.idx)] for inp in node.inputs)  # inversions are free edges
            levels[Signal("n", node.node_id)] = node_level
            max_level = max(max_level, node_level)
        return max_level

    def unique_luts(self) -> int:
        signatures = {(n.init, n.inputs) for n in self.nodes} # unique (init, inputs) pairs by nature of a dict key
        return len(signatures)

    def stats(self) -> Dict[str, int]:
        return {
            "inputs": self.fanin,
            "nodes": len(self.nodes),
            "unique": self.unique_luts(),
            "depth": self.depth(),
        }


class NetlistBuilder:
    def __init__(
        self,
        total_input_bits: int,
        fanin: int,
        in_width: int,
        out_width: int,
        share: bool = False,
        smart: bool = False,
    ) -> None:
        self.total_input_bits = total_input_bits
        self.fanin = fanin
        self.in_width = in_width
        self.out_width = out_width
        self.share = share
        self.smart = smart
        self.nodes: List[LUTNode] = []
        self._cache: Dict[Tuple[int, Tuple[Signal, ...]], Signal] = {}
        self._next_id = 0

    def add_lut(self, inputs: Iterable[Signal], init: int, tag: str) -> Signal:
        ordered_inputs = tuple(inputs)
        if len(ordered_inputs) > 6:
            raise ValueError("LUT6 supports at most 6 inputs.")

        # Collapse constant INIT patterns early.
        if init == 0:
            return Signal("b", 0)
        if init == (1 << 64) - 1:
            return Signal("b", 1)

        key = (init, ordered_inputs)
        inv_init = (~init) & ((1 << 64) - 1)
        inv_key = (inv_init, ordered_inputs)

        if (self.share or self.smart) and key in self._cache:
            return self._cache[key]

        if self.smart and inv_key in self._cache:
            base_sig = self._cache[inv_key]
            return Signal(base_sig.kind, base_sig.idx, inv=not base_sig.inv)

        node_id = self._next_id
        self._next_id += 1
        node = LUTNode(node_id=node_id, inputs=ordered_inputs, init=init, tag=tag)
        self.nodes.append(node)

        out_sig = Signal("n", node_id)
        if self.share or self.smart:
            self._cache[key] = out_sig
        return out_sig

    def build(self, outputs: Tuple[Signal, ...], combine_mode: str | None = None, combine_meta: dict | None = None) -> Netlist:
        # Finalize and return the netlist
        return Netlist(
            total_input_bits=self.total_input_bits,
            fanin=self.fanin,
            in_width=self.in_width,
            out_width=self.out_width,
            nodes=self.nodes,
            outputs=outputs,
            combine_mode=combine_mode,
            combine_meta=combine_meta or {},
        )
