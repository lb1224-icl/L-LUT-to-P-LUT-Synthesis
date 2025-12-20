# L-LUT-to-P-LUT-Synthesis
(WIP) A Python + SystemVerilog toolflow that converts large Boolean truth tables (L-LUTs) into FPGA-ready 6-input LUT (P-LUT) networks using different decomposition methods. Compares methods using metrics such as LUT count, unique LUTs, depth and Vivado-based area/timing evaluation.

## Quick start
```
python -m src.main --tt data/truth_table_16.hex --out_dir build --share 1 --gen_tb 1
```

- `--tt`: input file containing `HEX = <truth_table_bits>` (see `data/truth_table_4_parity.hex` for a small example).
- `--share`: set to `1` to enable LUT node sharing by INIT+input signature.
- `--gen_tb`: set to `1` to emit an exhaustive SystemVerilog testbench.
- `--skip_py_verify`: skip the Python-based exhaustive check (enabled by default).

Outputs land in `--out_dir` (`plut_prims.sv`, `top.sv`, optional `tb.sv`) plus console metrics: LUT count, unique nodes, and logic depth.

## Generate random truth tables
Use `src/gen_random_tt.py` to create a fresh HEX file:
```
python -m src.gen_random_tt.py --inputs <N> --out data/<name>.hex --seed <integer in range: [0, 2**32 - 1]>
```
Then feed it to the mapper:
```
--tt data/<name>.hex 
```
