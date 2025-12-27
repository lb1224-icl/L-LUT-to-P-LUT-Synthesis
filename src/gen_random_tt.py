import argparse
import random
from typing import List


def _format_hex(bits: int, width: int) -> str:
    # Return zero-padded uppercase hex string for `width` bits
    hex_len = width // 4
    return f"{bits:0{hex_len}X}"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--inputs", type=int, required=True, help="Number of Boolean inputs N.")
    ap.add_argument("--out", required=True, help="Output .hex file path.")
    ap.add_argument("--seed", type=int, default=None, help="Optional RNG seed.")
    ap.add_argument(
        "--max_weight",
        type=int,
        default=3,
        help="Max absolute weight for a pseudo-neuron (weights are sampled in [-max_weight, max_weight]).",
    )
    ap.add_argument(
        "--active_prob",
        type=float,
        default=0.3,
        help="Probability an input bit is 1 during reachable-mask sampling.",
    )
    ap.add_argument(
        "--reachable_samples",
        type=int,
        default=-1,
        help="Number of Monte Carlo samples to approximate reachable input space; -1 uses all inputs.",
    )
    ap.add_argument("--in_width", type=int, default=1, help="Bit-width per input signal.")
    ap.add_argument("--out_width", type=int, default=1, help="Bit-width per output word (scalar repeats the same logic).")
    args = ap.parse_args()

    if args.inputs < 1:
        raise SystemExit("inputs must be >=1")
    if args.seed is not None:
        random.seed(args.seed)

    total_input_bits = args.inputs * args.in_width
    width = 1 << total_input_bits  # number of input combinations

    # Sample DNN-like weights/bias per output bit; ensure not all zero per output
    weights: List[List[int]] = []
    biases: List[int] = []
    for _ in range(args.out_width):
        w_vec: List[int] = []
        for _ in range(args.inputs):
            w_vec.append(random.randint(-args.max_weight, args.max_weight))
        if all(w == 0 for w in w_vec):
            w_vec[random.randrange(args.inputs)] = random.choice([-1, 1])
        weights.append(w_vec)
        biases.append(random.randint(-args.max_weight, args.max_weight))

    # Build truth table: dot(weights[out], x) + bias[out] >= 0 per output bit
    bits = 0
    for entry in range(width):
        for out_bit in range(args.out_width):
            acc = biases[out_bit]
            for inp_idx, w in enumerate(weights[out_bit]):
                bit_val = (entry >> (inp_idx * args.in_width)) & ((1 << args.in_width) - 1)
                acc += w * bit_val
            if acc >= 0:
                bits |= 1 << (entry * args.out_width + out_bit)

    # Reachable mask: sample likely input patterns during inference
    reachable = 0
    samples = width if args.reachable_samples == -1 else min(width, args.reachable_samples)
    for _ in range(samples):
        vec = 0
        for inp_idx in range(args.inputs):
            chunk = 0
            for b in range(args.in_width):
                if random.random() < args.active_prob:
                    chunk |= 1 << b
            vec |= chunk << (inp_idx * args.in_width)
        reachable |= 1 << vec

    total_bits = width * args.out_width
    hex_body = _format_hex(bits, total_bits)
    reachable_hex = _format_hex(reachable, width)

    with open(args.out, "w") as f:
        f.write("# Pseudo DNN-neuron truth table (sum(weights*inputs) + bias >= 0)\n")
        f.write(f"# FANIN = {args.inputs}\n")
        f.write(f"# IN_WIDTH = {args.in_width}\n")
        f.write(f"# OUT_WIDTH = {args.out_width}\n")
        f.write(f"# WEIGHTS_PER_OUT = {weights}\n")
        f.write(f"# BIAS_PER_OUT = {biases}\n")
        f.write(f"# REACHABLE_SAMPLES = {samples}, ACTIVE_PROB = {args.active_prob}\n")
        f.write("# BIT_ORDER = x(N-1) ... x0 (x0 = LSB)\n")
        f.write(f"HEX = {hex_body}\n")
        f.write(f"REACHABLE = {reachable_hex}\n")
    print(f"Wrote {args.out} with {total_bits} bits (len={len(hex_body)} hex chars).")


if __name__ == "__main__":
    main()
