from __future__ import annotations

import argparse
from pathlib import Path

from .decompose import build_netlist
from .sv_emit import emit_sv_files
from .tt_io import load_truth_table
from .verify import exhaustive_verify


def _parse_args():
    parser = argparse.ArgumentParser(description="L-LUT to LUT6 mapper (Shannon).")
    parser.add_argument("--tt", required=True, help="Path to HEX truth table file.")
    parser.add_argument("--out_dir", default="build", help="Output directory for SV files.")
    parser.add_argument(
        "--method",
        choices=["shannon_single", "shannon_single_share", "shannon_multi", "shannon_smart"],
        default="shannon_single",
        help="Decomposition strategy.",
    )
    parser.add_argument("--gen_tb", type=int, default=0, help="Also emit SystemVerilog testbench (0/1).")
    parser.add_argument("--skip_py_verify", action="store_true", help="Skip Python exhaustive verification.")
    return parser.parse_args()


def main() -> None:
    args = _parse_args()
    tt = load_truth_table(args.tt)
    netlist = build_netlist(tt, method=args.method) 

    if not args.skip_py_verify:
        exhaustive_verify(netlist, tt.bits)

    stats = netlist.stats()
    print(f"inputs={stats['inputs']} nodes={stats['nodes']} unique={stats['unique']} depth={stats['depth']}")

    out_dir = Path(args.out_dir)
    emit_sv_files(netlist, out_dir, tt_hex=tt.hex_str, gen_testbench=bool(args.gen_tb))
    print(f"Wrote SystemVerilog to {out_dir}")


if __name__ == "__main__":
    main()
