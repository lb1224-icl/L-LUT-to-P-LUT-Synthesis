import argparse, random
from math import log2

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--inputs", type=int, required=True, help="Number of Boolean inputs N.")
    ap.add_argument("--out", required=True, help="Output .hex file path.")
    ap.add_argument("--seed", type=int, default=None, help="Optional RNG seed.")
    args = ap.parse_args()

    if args.inputs < 1:
        raise SystemExit("inputs must be >=1")
    if args.seed is not None:
        random.seed(args.seed)

    width = 1 << args.inputs  # number of truth-table bits
    hex_len = width // 4
    # Generate random bits as int
    bits = random.getrandbits(width)
    hex_body = f"{bits:0{hex_len}X}"

    with open(args.out, "w") as f:
        f.write("# Random truth table\n")
        f.write(f"# N_INPUTS = {args.inputs}\n")
        f.write("# BIT_ORDER = x(N-1) ... x0 (x0 = LSB)\n")
        f.write(f"HEX = {hex_body}\n")
    print(f"Wrote {args.out} with {width} bits (len={len(hex_body)} hex chars).")

if __name__ == "__main__":
    main()
