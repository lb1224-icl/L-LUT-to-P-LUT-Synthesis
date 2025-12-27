from __future__ import annotations

import math
import string
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable, Optional


@dataclass(frozen=True)
class TruthTable:
    hex_str: str
    bits: int
    fanin: int
    in_width: int
    out_width: int
    total_input_bits: int
    n_entries: int

    def output_bits(self, out_idx: int) -> int:
        # Return packed bits for a specific output bit across all entries
        if not (0 <= out_idx < self.out_width):
            raise ValueError("Output index out of range.")
        acc = 0
        for i in range(self.n_entries):
            bit = (self.bits >> (i * self.out_width + out_idx)) & 1
            acc |= bit << i
        return acc


def extract_hex(lines: Iterable[str]) -> str:
    for raw in lines:
        line = raw.strip()
        if not line or line.startswith("#"):
            continue
        if line.upper().startswith("HEX"):
            payload = line.split("=", 1)[1].strip()
            return payload
    raise ValueError("No HEX = <value> line found.")


def extract_meta(lines: Iterable[str]) -> dict[str, int]:
    meta: dict[str, int] = {}
    for raw in lines:
        line = raw.strip()
        if not line.startswith("#"):
            continue
        if "=" in line:
            key, val = line[1:].split("=", 1)
            key = key.strip().upper()
            val = val.strip()
            if key in {"FANIN", "IN_WIDTH", "OUT_WIDTH"} and val.isdigit():
                meta[key] = int(val)
    return meta


def load_truth_table(
    path: str | Path,
    fanin: Optional[int] = None,
    in_width: int = 1,
    out_width: int = 1,
) -> TruthTable:
    
    # Load a packed truth table from file.

    text = Path(path).read_text()
    lines = text.splitlines()
    meta = extract_meta(lines)
    hex_clean = extract_hex(lines)
    if hex_clean.lower().startswith("0x"):
        hex_clean = hex_clean[2:]
    if not hex_clean or any(c not in string.hexdigits for c in hex_clean):
        raise ValueError(f"Invalid hex payload: {hex_clean!r}")

    in_width_eff = meta.get("IN_WIDTH", in_width)
    out_width_eff = meta.get("OUT_WIDTH", out_width)

    total_bits = 4 * len(hex_clean)
    if total_bits % out_width_eff != 0:
        raise ValueError("Total bits not divisible by out_width.")
    n_entries = total_bits // out_width_eff
    total_input_bits = int(math.log2(n_entries))
    if (1 << total_input_bits) != n_entries:
        raise ValueError("Table length is not a power of two.")
    if total_input_bits % in_width_eff != 0:
        raise ValueError("Total input bits not divisible by in_width.")

    if fanin is None:
        fanin = meta.get("FANIN", total_input_bits // in_width_eff)
    else:
        if fanin * in_width_eff != total_input_bits:
            raise ValueError("Provided fanin/in_width do not match table size.")

    bits = int(hex_clean, 16)
    return TruthTable(
        hex_str=hex_clean.upper(),
        bits=bits,
        fanin=fanin,
        in_width=in_width_eff,
        out_width=out_width_eff,
        total_input_bits=total_input_bits,
        n_entries=n_entries,
    )


def bit_at(bits: int, idx: int) -> int:
    # Return bit value at position idx 
    return (bits >> idx) & 1
