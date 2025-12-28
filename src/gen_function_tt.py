import argparse
import math
from typing import Callable


def _format_hex(bits: int, width: int) -> str:
    # Return zero-padded uppercase hex string for `width` bits
    hex_len = (width + 3) // 4
    return f"{bits:0{hex_len}X}"


def _make_fn(kind: str) -> Callable[[int, int], float]:
    # Returns a function mapping (entry, max_entry) -> normalized float in [0,1]
    if kind == "sin":
        return lambda idx, max_idx: (math.sin(2 * math.pi * idx / max_idx) + 1.0) * 0.5
    if kind == "sqrt":
        return lambda idx, max_idx: math.sqrt(idx) / math.sqrt(max_idx - 1) if max_idx > 1 else 0.0
    if kind == "square":
        return lambda idx, max_idx: (idx / (max_idx - 1)) ** 2 if max_idx > 1 else 0.0
    if kind == "saw":
        return lambda idx, max_idx: idx / (max_idx - 1) if max_idx > 1 else 0.0
    if kind == "triangle":
        return lambda idx, max_idx: (2 * (idx / (max_idx - 1))) if idx <= (max_idx - 1) / 2 else (2 - 2 * (idx / (max_idx - 1))) if max_idx > 1 else 0.0
    if kind == "exp":
        # Normalized e^{x} on [0,1], scaled to [0,1]
        return lambda idx, max_idx: (math.exp(idx / (max_idx - 1)) - 1.0) / (math.e - 1.0) if max_idx > 1 else 0.0
    if kind == "log":
        # Normalized log(1 + kx) with k=1, avoids -inf at 0
        return lambda idx, max_idx: math.log(1.0 + (idx / (max_idx - 1))) / math.log(2.0) if max_idx > 1 else 0.0
    raise ValueError(f"Unknown function kind '{kind}'")


def main() -> None:
    ap = argparse.ArgumentParser(description="Generate structured function LUTs (e.g., sin, sqrt).")
    ap.add_argument("--inputs", type=int, required=True, help="Number of Boolean address bits N.")
    ap.add_argument("--out_width", type=int, required=True, help="Bit-width per output word.")
    ap.add_argument("--func", choices=["sin", "sqrt", "square", "saw", "triangle", "exp", "log"], default="sin", help="Function to sample.")
    ap.add_argument("--out", required=True, help="Output .hex file path.")
    args = ap.parse_args()

    if args.inputs < 1:
        raise SystemExit("inputs must be >=1")
    if args.out_width < 1:
        raise SystemExit("out_width must be >=1")

    entries = 1 << args.inputs
    fn = _make_fn(args.func)

    bits = 0
    for entry in range(entries):
        # Normalize over the full address space
        y = fn(entry, entries)
        y_clamped = max(0.0, min(1.0, y))
        val = int(round(y_clamped * ((1 << args.out_width) - 1)))
        for b in range(args.out_width):
            bits |= ((val >> b) & 1) << (entry * args.out_width + b)

    total_bits = entries * args.out_width
    hex_body = _format_hex(bits, total_bits)

    with open(args.out, "w") as f:
        f.write("# Structured function LUT\n")
        f.write(f"# FUNCTION = {args.func}\n")
        f.write(f"# FANIN = {args.inputs}\n")
        f.write("# IN_WIDTH = 1\n")
        f.write(f"# OUT_WIDTH = {args.out_width}\n")
        f.write("# BIT_ORDER = x(N-1) ... x0 (x0 = LSB)\n")
        f.write(f"HEX = {hex_body}\n")

    print(f"Wrote {args.out} ({total_bits} bits) for {args.func} sampled over {entries} points.")


if __name__ == "__main__":
    main()
