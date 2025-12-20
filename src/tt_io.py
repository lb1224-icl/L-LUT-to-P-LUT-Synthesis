from __future__ import annotations

import math
import string
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable


@dataclass(frozen=True)
class TruthTable:
    hex_str: str
    bits: int
    n_inputs: int

    @property
    def n_entries(self) -> int:
        # Number of rows in the table (2**n_inputs)
        return 1 << self.n_inputs


def extract_hex(lines: Iterable[str]) -> str:
    for raw in lines:
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if line.startswith("HEX"):
            payload = line.split("=", 1)[1].strip()
            return payload
    raise ValueError("No HEX = <value> line found.")


def load_truth_table(path: str | Path) -> TruthTable:
    # Load a packed truth table from file

    text = Path(path).read_text()
    hex_clean = extract_hex(text.splitlines())
    if not hex_clean or any(c not in string.hexdigits for c in hex_clean):
        raise ValueError(f"Invalid hex payload: {hex_clean!r}")

    n_bits = 4 * len(hex_clean)
    n_inputs = int(math.log2(n_bits))
    if (1 << n_inputs) != n_bits:
        raise ValueError(
            f"Hex length {len(hex_clean)} does not encode a 2^N table (bits={n_bits})."
        )

    bits = int(hex_clean, 16)
    return TruthTable(hex_str=hex_clean.upper(), bits=bits, n_inputs=n_inputs)


def bit_at(bits: int, idx: int) -> int:
    # Return bit value at position idx 
    return (bits >> idx) & 1

