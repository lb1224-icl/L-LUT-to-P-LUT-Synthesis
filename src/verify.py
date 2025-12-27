from __future__ import annotations

from typing import Dict, Tuple

from .netlist import Netlist, Signal


def _node_output(node_init: int, inputs: tuple[int, ...]) -> int:
    # Evaluate a LUT node given concrete input bits
    idx = 0
    for shift, val in enumerate(inputs):
        idx |= (val & 1) << shift
    return (node_init >> idx) & 1


def evaluate_netlist(netlist: Netlist, vector: int) -> Tuple[int, ...]:
    # Evaluate netlist outputs for a single input vector
    values: Dict[Signal, int] = {}
    for i in range(netlist.total_input_bits):
        values[Signal("x", i)] = (vector >> i) & 1

    def _val(sig: Signal) -> int:
        if sig.kind == "b":
            base_val = sig.idx & 1
        else:
            base = Signal(sig.kind, sig.idx)
            base_val = values[base]
        return base_val ^ int(sig.inv)

    for node in netlist.nodes:  # evaluate in topological order (adding all n<val> nodes in order)
        in_bits = tuple(_val(sig) for sig in node.inputs)
        values[Signal("n", node.node_id)] = _node_output(node.init, in_bits)

    return tuple(_val(out_sig) for out_sig in netlist.outputs)


def exhaustive_verify(netlist: Netlist, truth_bits: int, out_width: int) -> bool:
    # Check every possible input pattern against expected truth table (multi-output)
    n_inputs = netlist.total_input_bits
    for vec in range(1 << n_inputs):
        got = evaluate_netlist(netlist, vec)
        for out_idx in range(out_width):
            expected = (truth_bits >> (vec * out_width + out_idx)) & 1
            if expected != got[out_idx]:
                raise AssertionError(f"Mismatch at vector {vec} bit {out_idx}: expected {expected}, got {got[out_idx]}")
    print("Verification passed.")
    return True
