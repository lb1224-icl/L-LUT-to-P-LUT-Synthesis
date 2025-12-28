`timescale 1ns/1ps
module top (input wire [9:0] x, output wire [23:0] f);
    (* KEEP = "TRUE" *) wire n0;
    (* KEEP = "TRUE" *) wire n1;
    (* KEEP = "TRUE" *) wire n2;
    (* KEEP = "TRUE" *) wire n3;
    (* KEEP = "TRUE" *) wire n4;
    (* KEEP = "TRUE" *) wire n5;
    (* KEEP = "TRUE" *) wire n6;
    (* KEEP = "TRUE" *) wire n7;
    (* KEEP = "TRUE" *) wire n8;
    (* KEEP = "TRUE" *) wire n9;

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n0_lut (
        .I0(1'b1), .I1(1'b1), .I2(1'b1), .I3(1'b1), .I4(x[8]), .I5(x[9]), .O(n0)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n1_lut (
        .I0(1'b0), .I1(1'b0), .I2(1'b0), .I3(1'b0), .I4(x[8]), .I5(x[9]), .O(n1)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n2_lut (
        .I0(n0), .I1(n1), .I2(n1), .I3(n1), .I4(x[1]), .I5(x[2]), .O(n2)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n3_lut (
        .I0(1'b0), .I1(1'b1), .I2(1'b0), .I3(1'b1), .I4(x[1]), .I5(x[3]), .O(n3)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n4_lut (
        .I0(n3), .I1(n0), .I2(n1), .I3(n1), .I4(x[0]), .I5(x[2]), .O(n4)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n5_lut (
        .I0(1'b0), .I1(1'b1), .I2(1'b0), .I3(1'b1), .I4(x[0]), .I5(x[3]), .O(n5)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n6_lut (
        .I0(n1), .I1(n5), .I2(n0), .I3(n1), .I4(x[1]), .I5(x[2]), .O(n6)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n7_lut (
        .I0(n1), .I1(n1), .I2(n3), .I3(n0), .I4(x[0]), .I5(x[2]), .O(n7)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n8_lut (
        .I0(1'b0), .I1(1'b1), .I2(1'b0), .I3(1'b1), .I4(x[2]), .I5(x[3]), .O(n8)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n9_lut (
        .I0(n1), .I1(n1), .I2(n1), .I3(n8), .I4(x[0]), .I5(x[1]), .O(n9)
    );

    assign f[0] = n2;
    assign f[1] = n4;
    assign f[2] = n6;
    assign f[3] = n7;
    assign f[4] = n9;
    assign f[5] = 1'b0;
    assign f[6] = 1'b0;
    assign f[7] = 1'b0;
    assign f[8] = 1'b0;
    assign f[9] = 1'b0;
    assign f[10] = 1'b0;
    assign f[11] = 1'b0;
    assign f[12] = 1'b0;
    assign f[13] = 1'b0;
    assign f[14] = 1'b0;
    assign f[15] = 1'b0;
    assign f[16] = 1'b0;
    assign f[17] = 1'b0;
    assign f[18] = 1'b0;
    assign f[19] = 1'b0;
    assign f[20] = 1'b0;
    assign f[21] = 1'b0;
    assign f[22] = 1'b0;
    assign f[23] = 1'b0;
endmodule
