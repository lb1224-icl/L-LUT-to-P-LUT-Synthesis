`timescale 1ns/1ps
module top (input wire [9:0] x, output wire [10:0] f);
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
    (* KEEP = "TRUE" *) wire n10;
    (* KEEP = "TRUE" *) wire n11;
    (* KEEP = "TRUE" *) wire n12;
    (* KEEP = "TRUE" *) wire n13;
    (* KEEP = "TRUE" *) wire n14;
    (* KEEP = "TRUE" *) wire n15;
    (* KEEP = "TRUE" *) wire n16;
    (* KEEP = "TRUE" *) wire n17;
    (* KEEP = "TRUE" *) wire n18;
    (* KEEP = "TRUE" *) wire n19;
    (* KEEP = "TRUE" *) wire n20;
    (* KEEP = "TRUE" *) wire n21;
    (* KEEP = "TRUE" *) wire n22;
    (* KEEP = "TRUE" *) wire n23;
    (* KEEP = "TRUE" *) wire n24;
    (* KEEP = "TRUE" *) wire n25;
    (* KEEP = "TRUE" *) wire n26;
    (* KEEP = "TRUE" *) wire n27;
    (* KEEP = "TRUE" *) wire n28;
    (* KEEP = "TRUE" *) wire n29;
    (* KEEP = "TRUE" *) wire n30;
    (* KEEP = "TRUE" *) wire n31;
    (* KEEP = "TRUE" *) wire n32;
    (* KEEP = "TRUE" *) wire n33;
    (* KEEP = "TRUE" *) wire n34;
    (* KEEP = "TRUE" *) wire n35;
    (* KEEP = "TRUE" *) wire n36;
    (* KEEP = "TRUE" *) wire n37;
    (* KEEP = "TRUE" *) wire n38;
    (* KEEP = "TRUE" *) wire n39;
    (* KEEP = "TRUE" *) wire n40;
    (* KEEP = "TRUE" *) wire n41;
    (* KEEP = "TRUE" *) wire n42;
    (* KEEP = "TRUE" *) wire n43;
    (* KEEP = "TRUE" *) wire n44;
    (* KEEP = "TRUE" *) wire n45;
    (* KEEP = "TRUE" *) wire n46;
    (* KEEP = "TRUE" *) wire n47;
    (* KEEP = "TRUE" *) wire n48;
    (* KEEP = "TRUE" *) wire n49;
    (* KEEP = "TRUE" *) wire n50;
    (* KEEP = "TRUE" *) wire n51;
    (* KEEP = "TRUE" *) wire n52;
    (* KEEP = "TRUE" *) wire n53;
    (* KEEP = "TRUE" *) wire n54;
    (* KEEP = "TRUE" *) wire n55;
    (* KEEP = "TRUE" *) wire n56;
    (* KEEP = "TRUE" *) wire n57;
    (* KEEP = "TRUE" *) wire n58;
    (* KEEP = "TRUE" *) wire n59;
    (* KEEP = "TRUE" *) wire n60;
    (* KEEP = "TRUE" *) wire n61;
    (* KEEP = "TRUE" *) wire n62;
    (* KEEP = "TRUE" *) wire n63;
    (* KEEP = "TRUE" *) wire n64;
    (* KEEP = "TRUE" *) wire n65;
    (* KEEP = "TRUE" *) wire n66;
    (* KEEP = "TRUE" *) wire n67;
    (* KEEP = "TRUE" *) wire n68;
    (* KEEP = "TRUE" *) wire n69;
    (* KEEP = "TRUE" *) wire n70;
    (* KEEP = "TRUE" *) wire n71;
    (* KEEP = "TRUE" *) wire n72;
    (* KEEP = "TRUE" *) wire n73;
    (* KEEP = "TRUE" *) wire n74;
    (* KEEP = "TRUE" *) wire n75;
    (* KEEP = "TRUE" *) wire n76;
    (* KEEP = "TRUE" *) wire n77;
    (* KEEP = "TRUE" *) wire n78;
    (* KEEP = "TRUE" *) wire n79;
    (* KEEP = "TRUE" *) wire n80;

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFFFF55555555)) n0_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[5]), .I5(x[6]), .O(n0)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h5555555500000000)) n1_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[5]), .I5(x[6]), .O(n1)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n2_lut (
        .I0(1'b1), .I1(n0), .I2(n1), .I3(1'b0), .I4(x[8]), .I5(x[9]), .O(n2)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n3_lut (
        .I0(n1), .I1(1'b0), .I2(1'b0), .I3(1'b0), .I4(x[8]), .I5(x[9]), .O(n3)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n4_lut (
        .I0(1'b1), .I1(1'b1), .I2(1'b1), .I3(1'b1), .I4(x[8]), .I5(x[9]), .O(n4)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n5_lut (
        .I0(1'b1), .I1(1'b1), .I2(n0), .I3(n1), .I4(x[8]), .I5(x[9]), .O(n5)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n6_lut (
        .I0(n2), .I1(n3), .I2(n4), .I3(n5), .I4(x[1]), .I5(x[7]), .O(n6)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h005454FD004040D5)) n7_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n7)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hD5FFFFFF50F5F5FF)) n8_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n8)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h004040D500000050)) n9_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n9)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n10_lut (
        .I0(n7), .I1(1'b0), .I2(n8), .I3(n9), .I4(x[7]), .I5(x[9]), .O(n10)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n11_lut (
        .I0(1'b0), .I1(1'b0), .I2(n9), .I3(1'b0), .I4(x[7]), .I5(x[9]), .O(n11)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n12_lut (
        .I0(1'b0), .I1(1'b0), .I2(1'b0), .I3(1'b0), .I4(x[8]), .I5(x[9]), .O(n12)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n13_lut (
        .I0(n10), .I1(n11), .I2(n11), .I3(n12), .I4(x[1]), .I5(x[5]), .O(n13)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h030000001F030300)) n14_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n14)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h7F1F1F03FF7F7F1F)) n15_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n15)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n16_lut (
        .I0(n14), .I1(n15), .I2(1'b0), .I3(n14), .I4(x[7]), .I5(x[9]), .O(n16)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0300000000000000)) n17_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[7]), .O(n17)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n18_lut (
        .I0(n17), .I1(1'b0), .I2(1'b0), .I3(1'b0), .I4(x[8]), .I5(x[9]), .O(n18)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFF7FFFFFFFFF)) n19_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n19)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n20_lut (
        .I0(n15), .I1(n19), .I2(n14), .I3(n15), .I4(x[7]), .I5(x[9]), .O(n20)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000003000000)) n21_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n21)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h1F0303007F1F1F03)) n22_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n22)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n23_lut (
        .I0(n21), .I1(n22), .I2(1'b0), .I3(n21), .I4(x[7]), .I5(x[9]), .O(n23)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n24_lut (
        .I0(n16), .I1(n18), .I2(n20), .I3(n23), .I4(x[3]), .I5(x[5]), .O(n24)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h170000007F050500)) n25_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n25)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000001000000)) n26_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n26)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n27_lut (
        .I0(n25), .I1(n26), .I2(n26), .I3(1'b0), .I4(x[1]), .I5(x[9]), .O(n27)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFF17FFFFFF7F)) n28_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n28)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h7F050500FF5F5F01)) n29_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n29)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0100000017000000)) n30_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n30)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n31_lut (
        .I0(n28), .I1(n29), .I2(n29), .I3(n30), .I4(x[1]), .I5(x[9]), .O(n31)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFF7FFFFFFFFF)) n32_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n32)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF5F5F01FFFFFF17)) n33_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n33)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n34_lut (
        .I0(1'b1), .I1(n32), .I2(n32), .I3(n33), .I4(x[1]), .I5(x[9]), .O(n34)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n35_lut (
        .I0(n27), .I1(n31), .I2(n31), .I3(n34), .I4(x[5]), .I5(x[7]), .O(n35)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000000000001)) n36_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[7]), .O(n36)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000100110117)) n37_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[7]), .O(n37)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h001101171177177F)) n38_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[7]), .O(n38)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h1177177F77FF7FFF)) n39_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[7]), .O(n39)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n40_lut (
        .I0(n36), .I1(n37), .I2(n38), .I3(n39), .I4(x[8]), .I5(x[9]), .O(n40)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n41_lut (
        .I0(1'b0), .I1(1'b0), .I2(n36), .I3(n37), .I4(x[8]), .I5(x[9]), .O(n41)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n42_lut (
        .I0(n40), .I1(n41), .I2(n41), .I3(n12), .I4(x[1]), .I5(x[3]), .O(n42)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFFFFFFFF0000)) n43_lut (
        .I0(x[4]), .I1(x[5]), .I2(x[6]), .I3(x[7]), .I4(x[8]), .I5(x[9]), .O(n43)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFF000000000000)) n44_lut (
        .I0(x[4]), .I1(x[5]), .I2(x[6]), .I3(x[7]), .I4(x[8]), .I5(x[9]), .O(n44)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n45_lut (
        .I0(n43), .I1(1'b1), .I2(n44), .I3(1'b1), .I4(x[0]), .I5(x[2]), .O(n45)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFFFF00000000)) n46_lut (
        .I0(x[4]), .I1(x[5]), .I2(x[6]), .I3(x[7]), .I4(x[8]), .I5(x[9]), .O(n46)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n47_lut (
        .I0(1'b0), .I1(n46), .I2(1'b0), .I3(1'b0), .I4(x[0]), .I5(x[2]), .O(n47)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hBBBBBBBBBBBBBBBB)) n48_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[7]), .O(n48)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n49_lut (
        .I0(n48), .I1(1'b1), .I2(1'b1), .I3(1'b1), .I4(x[8]), .I5(x[9]), .O(n49)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n50_lut (
        .I0(n45), .I1(n4), .I2(n47), .I3(n49), .I4(x[1]), .I5(x[3]), .O(n50)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hEEEEFFFF8888EEEE)) n51_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[8]), .O(n51)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n52_lut (
        .I0(1'b1), .I1(n51), .I2(1'b1), .I3(1'b1), .I4(x[7]), .I5(x[9]), .O(n52)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n53_lut (
        .I0(n52), .I1(n4), .I2(n4), .I3(n4), .I4(x[1]), .I5(x[3]), .O(n53)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h23BF023B022B0023)) n54_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n54)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hBFFFBFFF3BFF2BBF)) n55_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n55)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0002000200000000)) n56_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n56)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n57_lut (
        .I0(n54), .I1(n55), .I2(n56), .I3(n54), .I4(x[1]), .I5(x[5]), .O(n57)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h022B002300020002)) n58_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n58)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n59_lut (
        .I0(1'b0), .I1(n58), .I2(1'b0), .I3(1'b0), .I4(x[1]), .I5(x[5]), .O(n59)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n60_lut (
        .I0(n57), .I1(n59), .I2(n59), .I3(n12), .I4(x[3]), .I5(x[7]), .O(n60)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFCD4D4C0FDFDFCD4)) n61_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[7]), .I5(x[8]), .O(n61)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h40400000D4C04040)) n62_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[7]), .I5(x[8]), .O(n62)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n63_lut (
        .I0(n61), .I1(n62), .I2(n62), .I3(1'b0), .I4(x[1]), .I5(x[9]), .O(n63)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFDFDFCD4FFFFFDFD)) n64_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[7]), .I5(x[8]), .O(n64)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hD4C04040FCD4D4C0)) n65_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[7]), .I5(x[8]), .O(n65)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n66_lut (
        .I0(1'b1), .I1(n64), .I2(n64), .I3(n65), .I4(x[1]), .I5(x[9]), .O(n66)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFFFFFFF7FFF7)) n67_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[7]), .O(n67)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n68_lut (
        .I0(1'b1), .I1(1'b1), .I2(1'b1), .I3(n67), .I4(x[8]), .I5(x[9]), .O(n68)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n69_lut (
        .I0(n63), .I1(n66), .I2(n66), .I3(n68), .I4(x[3]), .I5(x[5]), .O(n69)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h000004004D04CF4D)) n70_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n70)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000000000400)) n71_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n71)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h4D04CF4DDFCFFFDF)) n72_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n72)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n73_lut (
        .I0(n70), .I1(n71), .I2(n72), .I3(n70), .I4(x[1]), .I5(x[7]), .O(n73)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hCF4DDFCFFFDFFFFF)) n74_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n74)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h04004D04CF4DDFCF)) n75_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n75)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFDFFFFFFFFFFFFF)) n76_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n76)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n77_lut (
        .I0(n74), .I1(n75), .I2(n76), .I3(n74), .I4(x[1]), .I5(x[7]), .O(n77)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000004004D04)) n78_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n78)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n79_lut (
        .I0(1'b0), .I1(1'b0), .I2(n78), .I3(1'b0), .I4(x[1]), .I5(x[7]), .O(n79)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n80_lut (
        .I0(n73), .I1(n77), .I2(n79), .I3(n73), .I4(x[3]), .I5(x[5]), .O(n80)
    );

    assign f[0] = n6;
    assign f[1] = 1'b1;
    assign f[2] = n13;
    assign f[3] = n24;
    assign f[4] = n35;
    assign f[5] = n42;
    assign f[6] = n50;
    assign f[7] = n53;
    assign f[8] = n60;
    assign f[9] = n69;
    assign f[10] = n80;
endmodule
