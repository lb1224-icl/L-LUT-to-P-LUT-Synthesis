from __future__ import annotations

from dataclasses import dataclass
from typing import Dict, Iterable, List, Tuple


@dataclass(frozen=True)
class Signal:
    kind: str # 'x' for primary input, 'n' for LUT output
    idx: int

    def __post_init__(self) -> None:
        if self.kind not in {"x", "n"}:
            raise ValueError(f"Unsupported signal kind: {self.kind}")
        if self.idx < 0:
            raise ValueError("Signal index must be non-negative.")

    def __str__(self) -> str:
        return f"{self.kind}{self.idx}"


@dataclass(frozen=True)
class LUTNode:
    # LUT6 instance

    node_id: int
    inputs: Tuple[Signal, ...]
    init: int
    tag: str


@dataclass
class Netlist:
    # Combinational netlist of LUT nodes (Output)

    num_inputs: int
    nodes: List[LUTNode]
    output: Signal

    def depth(self) -> int:
        # Return maximum logic level (PIs at level 0)
        levels: Dict[Signal, int] = {Signal("x", i): 0 for i in range(self.num_inputs)}
        max_level = 0
        for node in self.nodes:
            node_level = 1 + max(levels[inp] for inp in node.inputs)
            levels[Signal("n", node.node_id)] = node_level
            max_level = max(max_level, node_level)
        return max_level

    def unique_luts(self) -> int:
        signatures = {(n.init, n.inputs) for n in self.nodes} # unique (init, inputs) pairs by nature of a dict key
        return len(signatures)

    def stats(self) -> Dict[str, int]:
        return {
            "inputs": self.num_inputs,
            "nodes": len(self.nodes),
            "unique": self.unique_luts(),
            "depth": self.depth(),
        }


class NetlistBuilder:
    def __init__(self, num_inputs: int, share: bool = False) -> None:
        self.num_inputs = num_inputs
        self.share = share
        self.nodes: List[LUTNode] = []
        self._cache: Dict[Tuple[int, Tuple[Signal, ...]], Signal] = {}
        self._next_id = 0

    def add_lut(self, inputs: Iterable[Signal], init: int, tag: str) -> Signal:
        ordered_inputs = tuple(inputs)
        if len(ordered_inputs) > 6:
            raise ValueError("LUT6 supports at most 6 inputs.")

        key = (init, ordered_inputs)
        if self.share and key in self._cache:
            return self._cache[key]

        node_id = self._next_id
        self._next_id += 1
        node = LUTNode(node_id=node_id, inputs=ordered_inputs, init=init, tag=tag)
        self.nodes.append(node)

        out_sig = Signal("n", node_id)
        if self.share:
            self._cache[key] = out_sig
        return out_sig

    def build(self, output: Signal) -> Netlist:
        # Finalize and return the netlist
        return Netlist(num_inputs=self.num_inputs, nodes=self.nodes, output=output)

