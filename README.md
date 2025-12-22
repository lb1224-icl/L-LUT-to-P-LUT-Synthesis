# L-LUT-to-P-LUT-Synthesis
(WIP) Python + SystemVerilog toolflow that maps large Boolean truth tables (L-LUTs) into FPGA-ready 6-input LUT (P-LUT) networks. It reports LUT count, unique LUTs, and depth, and can emit a structural SV netlist plus an exhaustive SV testbench.

## What it does
- Loads a `HEX = <bits>` truth table (bit i = f(x0..xN-1) with x0 as LSB)
- Decomposes into LUT6 instances using the selected strategy
- Optionally shares identical LUT6s (same INIT and ordered inputs)
- Optionally exhaustively verifies in Python and/or emits a SystemVerilog testbench

## Methods
- `shannon_single`: Classic Shannon expansion with one variable per mux level, fixed input order (x0..xN-1). Baseline for comparison.
- `shannon_single_share`: Same as `shannon_single`, but caches and reuses identical LUT6 nodes keyed by `(INIT, ordered_inputs)`. Reduces unique LUTs when cofactors repeat.
- `shannon_multi`: Multi-variable-per-level split (4:1 mux stages). Aims to reduce depth versus single-variable splitting.
- `shannon_smart`: Two-variable splits chosen by an entropy + Hamming-distance heuristic:
  - For every variable pair, build the four cofactors (00, 01, 10, 11).
  - Compute a score = sum of cofactor entropies (bias toward cofactors near-constant `images/entropy_graph.png` ), with total pairwise normalized Hamming distance as a tie-breaker (bias toward similar cofactors for sharing).
  - Pick the best pair at each level and recurse. This tends to preserve structure (e.g., paired bits, balanced halves) and can lower depth/unique LUTs compared to fixed-order splits. 
## CLI reference
| Flag | Description | Values / Default |
| --- | --- | --- |
| `--tt` | Input HEX file (`HEX = ...`), e.g. `data/truth_table_16.hex`. | Required |
| `--out_dir` | Directory for generated SV (`plut_prims.sv`, `top.sv`, optional `tb.sv`). | `build` |
| `--method` | Decomposition choice. | `shannon_single` (default) \| `shannon_single_share` \| `shannon_multi` \| `shannon_smart` |
| `--gen_tb` | Emit SV testbench that exhaustively checks all inputs. | `0` (default) or `1` |
| `--skip_py_verify` | Skip Python exhaustive verification (speeds up large N). | Off by default |

Outputs land in `--out_dir` and the CLI prints `inputs`, `nodes`, `unique`, and `depth`.

## Quick start
Run the provided 16-input table with sharing and a generated testbench:
```
python -m src.main --tt data/truth_table_16.hex --out_dir build --method shannon_single_share --gen_tb 1
```

## Generate random truth tables
Create a fresh HEX file:
```
python -m src.gen_random_tt.py --inputs <N> --out data/<name>.hex --seed <0..2**32-1>
```
Then map it:
```
python -m src.main --tt data/<name>.hex --out_dir build --method shannon_single_share --gen_tb 0 --skip_py_verify
```

## Future evaluation in Vivado (Not yet completed)
- Synthesize each emitted netlist (`top.sv` + `plut_prims.sv`) in Vivado targeting an Artix-7
- Collect post-synthesis reports: LUT count, registers (should be zero), critical path/f_max, and power.

## Verify correctness of solution
Main focus of this project is to evaluate different methods and so the verification is not optimised. If you wish to skip this stage (recommended for larger inputs) then add `--skip_py_verify` to the command.
