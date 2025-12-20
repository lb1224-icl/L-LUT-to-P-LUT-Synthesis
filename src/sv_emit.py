from __future__ import annotations

from pathlib import Path
from typing import Iterable, List, Optional

from .netlist import LUTNode, Netlist, Signal


def _sig_name(sig: Signal) -> str:
    return f"x[{sig.idx}]" if sig.kind == "x" else f"n{sig.idx}"


def _pad_inputs(inputs: Iterable[Signal]) -> List[str]:
    names = [_sig_name(s) for s in inputs]
    while len(names) < 6:
        names.append("1'b0")
    return names[:6]


def emit_primitives(path: Path) -> None:
    content = """\
`timescale 1ns/1ps

module plut_lut6 #(
    parameter [63:0] INIT = 64'h0
) (
    input  wire I0,
    input  wire I1,
    input  wire I2,
    input  wire I3,
    input  wire I4,
    input  wire I5,
    output wire O
);
    (* DONT_TOUCH = "TRUE" *)
    LUT6 #(.INIT(INIT)) lut6_i (
        .I0(I0), .I1(I1), .I2(I2), .I3(I3), .I4(I4), .I5(I5), .O(O)
    );
endmodule
"""
    path.write_text(content)


def emit_top(netlist: Netlist, path: Path, module_name: str = "top") -> None:
    # Emit structural netlist using plut_lut6 primitives
    lines: List[str] = []
    lines.append("`timescale 1ns/1ps\n")
    lines.append(f"module {module_name} (input wire [{netlist.num_inputs - 1}:0] x, output wire f);\n")

    if netlist.nodes:
        for node in netlist.nodes:
            lines.append(f"    (* KEEP = \"TRUE\" *) wire n{node.node_id};\n")
        lines.append("\n")

    for node in netlist.nodes:
        inputs = _pad_inputs(node.inputs)
        init_hex = f"{node.init:016X}"
        lines.append(f"    (* DONT_TOUCH = \"TRUE\" *) plut_lut6 #(.INIT(64'h{init_hex})) n{node.node_id}_lut (\n")
        lines.append(
            "        .I0(" + inputs[0] + "), .I1(" + inputs[1] + "), .I2(" + inputs[2]
            + "), .I3(" + inputs[3] + "), .I4(" + inputs[4] + "), .I5(" + inputs[5] + "), .O(n"
            + str(node.node_id) + ")\n"
        )
        lines.append("    );\n\n")

    lines.append(f"    assign f = {_sig_name(netlist.output)};\n")
    lines.append("endmodule\n")

    path.write_text("".join(lines))


def emit_testbench(
    netlist: Netlist,
    tt_hex: str,
    path: Path,
    top_module: str = "top",
) -> None:
    # Emit exhaustive testbench that checks the truth table
    n_inputs = netlist.num_inputs
    width = 1 << n_inputs
    hex_len = width // 4
    hex_body = tt_hex.rjust(hex_len, "0")

    lines: List[str] = []
    lines.append("`timescale 1ns/1ps\n")
    lines.append("module tb;\n")
    lines.append(f"    localparam int N_INPUTS = {n_inputs};\n")
    lines.append(f"    localparam logic [({width})-1:0] TT = {width}'h{hex_body};\n")
    lines.append("    reg  [N_INPUTS-1:0] x;\n")
    lines.append("    wire f;\n\n")
    lines.append(f"    {top_module} dut (.x(x), .f(f));\n\n")
    lines.append("    integer i;\n")
    lines.append("    initial begin\n")
    lines.append("        for (i = 0; i < (1<<N_INPUTS); i = i + 1) begin\n")
    lines.append("            x = i[N_INPUTS-1:0];\n")
    lines.append("            #1;\n")
    lines.append("            if (f !== TT[i]) begin\n")
    lines.append('                $error("Mismatch at %0d: expected %0b got %0b", i, TT[i], f);\n')
    lines.append("                $finish;\n")
    lines.append("            end\n")
    lines.append("        end\n")
    lines.append('        $display("PASS: all patterns matched.");\n')
    lines.append("        $finish;\n")
    lines.append("    end\n")
    lines.append("endmodule\n")

    path.write_text("".join(lines))


def emit_sv_files(
    netlist: Netlist,
    out_dir: Path,
    tt_hex: Optional[str] = None,
    gen_testbench: bool = False,
) -> None:
    # Write prims + top (and optional tb) into `out_dir`.
    out_dir.mkdir(parents=True, exist_ok=True)
    emit_primitives(out_dir / "plut_prims.sv")
    emit_top(netlist, out_dir / "top.sv")
    if gen_testbench and tt_hex is not None:
        emit_testbench(netlist, tt_hex, out_dir / "tb.sv")

