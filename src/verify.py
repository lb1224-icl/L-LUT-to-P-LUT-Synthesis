from __future__ import annotations

from typing import Dict

from .netlist import Netlist, Signal
from .tt_io import bit_at


def _node_output(node_init: int, inputs: tuple[int, ...]) -> int:
    # Evaluate a LUT node given concrete input bits
    idx = 0
    for shift, val in enumerate(inputs):
        idx |= (val & 1) << shift
    return (node_init >> idx) & 1


def evaluate_netlist(netlist: Netlist, vector: int) -> int:
    # Evaluate netlist output for a single input vector
    values: Dict[Signal, int] = {}
    for i in range(netlist.num_inputs):
        values[Signal("x", i)] = (vector >> i) & 1

    for node in netlist.nodes:
        in_bits = tuple(values[sig] for sig in node.inputs) # get already evaluated input bits
        values[Signal("n", node.node_id)] = _node_output(node.init, in_bits) # evaluate node and store its output

    return values[netlist.output] # return final output value


def exhaustive_verify(netlist: Netlist, truth_bits: int) -> bool:
    # Check every possible input pattern against expected truth table
    n_inputs = netlist.num_inputs
    for vec in range(1 << n_inputs):
        expected = bit_at(truth_bits, vec)
        got = evaluate_netlist(netlist, vec)
        if expected != got:
            raise AssertionError(f"Mismatch at vector {vec}: expected {expected}, got {got}")
    return True

