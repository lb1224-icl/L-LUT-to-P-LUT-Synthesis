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
