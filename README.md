# L-LUT-to-P-LUT-Synthesis
(WIP) Python + SystemVerilog toolflow that maps large Boolean truth tables (L-LUTs) into FPGA-ready 6-input LUT (P-LUT) networks. It reports LUT count, unique LUTs, and depth, and can emit a structural SV netlist plus an exhaustive SV testbench.

## What it does
- Loads a `HEX = <bits>` truth table (bit i = f(x0..xN-1) with x0 as LSB)
- Decomposes into LUT6 instances using the selected strategy
- Optionally shares identical LUT6s (same INIT and ordered inputs)
- Optionally exhaustively verifies in Python and/or emits a SystemVerilog testbench

## Methods
- `shannon_single` (`build_signal` in `shannon_single.py`): Classic Shannon expansion with one variable per mux level, fixed input order (x0..xN-1). Baseline for comparison.
- `shannon_single_share` (`build_signal` in `shannon_single.py` with sharing): Same as above, but caches and reuses identical LUT6 nodes keyed by `(INIT, ordered_inputs)`. Reduces unique LUTs when cofactors repeat.
- `shannon_multi` (`build_signal` in `shannon_multi.py`): Multi-variable-per-level split (4:1 mux stages). Aims to reduce depth versus single-variable splitting.
- `shannon_smart` (`build_signal` in `shannon_smart.py`): Two-variable splits chosen by an entropy + Hamming-distance heuristic:
  - For every variable pair, build the four cofactors (00, 01, 10, 11).
  - Compute a score = sum of cofactor entropies (bias toward cofactors near-constant), with total pairwise normalized Hamming distance as a tie-breaker (bias toward similar cofactors for sharing).
  - Pick the best pair at each level and recurse. This tends to preserve structure (e.g., paired bits, balanced halves) and can lower depth/unique LUTs compared to fixed-order splits.
- `ldtc` (`split_tss_td` and `build_ldtc` in `ldtc.py`): Lossless Differential Truth Table Compression, inspired by [IEEE paper](https://ieeexplore.ieee.org/stamp/stamp.jsp?tp=&arnumber=9628172). It searches sub-sampling/width parameters `(s, wL, wH)` to produce:
  - `Tss`: a subsampled base table (high bits).
  - `Td`: a full-size delta table (low bits).
  - Reconstruction is `(Tss << shift_bits) + Td`, where `shift_bits = out_width - wH`. Tss is indexed by the upper `total_input_bits - s` address bits, Td by the full address. Both tables are mapped with the smart Shannon flow, and SV emits the sum to recover the original outputs.
- `clut` (`split_tust_trsh_tidx` and `build_clut` in `clut.py`): Experimental CompressedLUT-style flow. Steps:
  - First apply the LDTC split to get `Tss` (bases) and `Td` (deltas).
  - Partition `Td` into sub-tables of size `2^ws`, build a similarity matrix to see when one sub-table can generate another via right shifts, and iteratively pick the generator that covers the most remaining sub-tables.
  - Emit `UST` (unique sub-tables), `Tidx` (which UST to use per sub-table), and `Trsh` (shift per sub-table). `Tidx/Trsh` are indexed by the upper address bits; `UST` is indexed by the lower address bits plus `Tidx`.
  - Reconstruction is `(Tss << shift_bits) + (UST[Tidx][offset] >> Trsh)`, where `offset` comes from the lower address bits. Works best when many sub-tables are identical up to small right shifts (e.g., `data/clut_bases_shifts.hex` shows good reduction because `UST` stays tiny and `Tidx/Trsh` are narrow).
## CLI reference
| Flag | Description | Values / Default |
| --- | --- | --- |
| `--tt` | Input HEX file (`HEX = ...`), e.g. `data/truth_table_16.hex`. | Required |
| `--out_dir` | Directory for generated SV (`plut_prims.sv`, `top.sv`, optional `tb.sv`). | `build` |
| `--method` | Decomposition choice. | `shannon_single` (default) \| `shannon_single_share` \| `shannon_multi` \| `shannon_smart` \| `ldtc` |
| `--gen_tb` | Emit SV testbench that exhaustively checks all inputs. | `0` (default) or `1` |
| `--skip_py_verify` | Skip Python exhaustive verification (speeds up large N). | Off by default |

Outputs land in `--out_dir` and the CLI prints `inputs`, `nodes`, `unique`, and `depth`.

## Quick start
Run the provided 16-input table with sharing and a generated testbench:
```
python -m src.main --tt data/truth_table_16.hex --out_dir build --method shannon_single_share --gen_tb 1
```

## Generate random truth tables
### DNN-like neuron sampler (with reachable-mask)
Use `src.gen_random_tt` to create a pseudo neuron truth table plus a reachable input mask (used for compressedLUT and reducedLUT):
```
python -m src.gen_random_tt --inputs <N> --out data/<name>.hex --seed <0..2**32-1> \
  --max_weight 3 --active_prob 0.3 --reachable_samples -1
```
Options:
- `--inputs`: number of input signals (fanin). All inputs share the same bit-width.
- `--in_width`: bit-width per input signal (default 1).
- `--out_width`: bit-width per output word (default 1; the neuron output is replicated across bits).
- `--max_weight`: integer weights are sampled uniformly from `[-max_weight, max_weight]`.
- `--seed`: RNG seed for reproducibility.
- `--active_prob`: probability an input bit is 1 during reachable-mask sampling.
- `--reachable_samples`: number of samples for the reachable mask; `-1` covers all inputs.

What it does:
- Samples integer weights and a bias per output bit (guaranteeing not all zero per output).
- Builds the truth table for each output bit: `sum(weights[out] * inputs) + bias[out] >= 0` (inputs treated as unsigned chunks of `in_width` bits).
- Generates a `REACHABLE = ...` hex mask by Monte Carlo sampling likely inference patterns (each bit set with probability `active_prob`, for `reachable_samples` draws. Use `-1` to cover all inputs). This approximates which input vectors are observed in practice. (Will be used in future methods)

Then map it:
```
python -m src.main --tt data/<name>.hex --out_dir build --method shannon_single_share --gen_tb 0 --skip_py_verify
```

## Future evaluation in Vivado (Not yet completed)
- Synthesize each emitted netlist (`top.sv` + `plut_prims.sv`) in Vivado targeting an Artix-7
- Collect post-synthesis reports: LUT count, registers (should be zero), critical path/f_max, and power.

## Verify correctness of solution
Main focus of this project is to evaluate different methods and so the verification is not optimised. If you wish to skip this stage (recommended for larger inputs) then add `--skip_py_verify` to the command.
