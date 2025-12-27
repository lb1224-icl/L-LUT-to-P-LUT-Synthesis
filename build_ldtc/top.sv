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

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h005454FD004040D5)) n0_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n0)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hD5FFFFFF50F5F5FF)) n1_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n1)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h004040D500000050)) n2_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n2)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n3_lut (
        .I0(n0), .I1(1'b0), .I2(n1), .I3(n2), .I4(x[7]), .I5(x[9]), .O(n3)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n4_lut (
        .I0(1'b0), .I1(1'b0), .I2(n2), .I3(1'b0), .I4(x[7]), .I5(x[9]), .O(n4)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n5_lut (
        .I0(1'b0), .I1(1'b0), .I2(1'b0), .I3(1'b0), .I4(x[8]), .I5(x[9]), .O(n5)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n6_lut (
        .I0(n3), .I1(n4), .I2(n4), .I3(n5), .I4(x[1]), .I5(x[5]), .O(n6)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h030000001F030300)) n7_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n7)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h7F1F1F03FF7F7F1F)) n8_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n8)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n9_lut (
        .I0(n7), .I1(n8), .I2(1'b0), .I3(n7), .I4(x[7]), .I5(x[9]), .O(n9)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0300000000000000)) n10_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[7]), .O(n10)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n11_lut (
        .I0(n10), .I1(1'b0), .I2(1'b0), .I3(1'b0), .I4(x[8]), .I5(x[9]), .O(n11)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFF7FFFFFFFFF)) n12_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n12)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n13_lut (
        .I0(n8), .I1(n12), .I2(n7), .I3(n8), .I4(x[7]), .I5(x[9]), .O(n13)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000003000000)) n14_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n14)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h1F0303007F1F1F03)) n15_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n15)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n16_lut (
        .I0(n14), .I1(n15), .I2(1'b0), .I3(n14), .I4(x[7]), .I5(x[9]), .O(n16)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n17_lut (
        .I0(n9), .I1(n11), .I2(n13), .I3(n16), .I4(x[3]), .I5(x[5]), .O(n17)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h170000007F050500)) n18_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n18)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000001000000)) n19_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n19)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n20_lut (
        .I0(n18), .I1(n19), .I2(n19), .I3(1'b0), .I4(x[1]), .I5(x[9]), .O(n20)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFF17FFFFFF7F)) n21_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n21)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h7F050500FF5F5F01)) n22_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n22)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0100000017000000)) n23_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n23)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n24_lut (
        .I0(n21), .I1(n22), .I2(n22), .I3(n23), .I4(x[1]), .I5(x[9]), .O(n24)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFF7FFFFFFFFF)) n25_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n25)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF5F5F01FFFFFF17)) n26_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[6]), .I5(x[8]), .O(n26)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n27_lut (
        .I0(1'b1), .I1(n25), .I2(n25), .I3(n26), .I4(x[1]), .I5(x[9]), .O(n27)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n28_lut (
        .I0(n20), .I1(n24), .I2(n24), .I3(n27), .I4(x[5]), .I5(x[7]), .O(n28)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000000000001)) n29_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[7]), .O(n29)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000100110117)) n30_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[7]), .O(n30)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h001101171177177F)) n31_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[7]), .O(n31)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h1177177F77FF7FFF)) n32_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[7]), .O(n32)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n33_lut (
        .I0(n29), .I1(n30), .I2(n31), .I3(n32), .I4(x[8]), .I5(x[9]), .O(n33)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n34_lut (
        .I0(1'b0), .I1(1'b0), .I2(n29), .I3(n30), .I4(x[8]), .I5(x[9]), .O(n34)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n35_lut (
        .I0(n33), .I1(n34), .I2(n34), .I3(n5), .I4(x[1]), .I5(x[3]), .O(n35)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFFFFFFFF0000)) n36_lut (
        .I0(x[4]), .I1(x[5]), .I2(x[6]), .I3(x[7]), .I4(x[8]), .I5(x[9]), .O(n36)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFF000000000000)) n37_lut (
        .I0(x[4]), .I1(x[5]), .I2(x[6]), .I3(x[7]), .I4(x[8]), .I5(x[9]), .O(n37)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n38_lut (
        .I0(n36), .I1(1'b1), .I2(n37), .I3(1'b1), .I4(x[0]), .I5(x[2]), .O(n38)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n39_lut (
        .I0(1'b1), .I1(1'b1), .I2(1'b1), .I3(1'b1), .I4(x[8]), .I5(x[9]), .O(n39)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFFFF00000000)) n40_lut (
        .I0(x[4]), .I1(x[5]), .I2(x[6]), .I3(x[7]), .I4(x[8]), .I5(x[9]), .O(n40)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n41_lut (
        .I0(1'b0), .I1(n40), .I2(1'b0), .I3(1'b0), .I4(x[0]), .I5(x[2]), .O(n41)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hBBBBBBBBBBBBBBBB)) n42_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[7]), .O(n42)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n43_lut (
        .I0(n42), .I1(1'b1), .I2(1'b1), .I3(1'b1), .I4(x[8]), .I5(x[9]), .O(n43)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n44_lut (
        .I0(n38), .I1(n39), .I2(n41), .I3(n43), .I4(x[1]), .I5(x[3]), .O(n44)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hEEEEFFFF8888EEEE)) n45_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[5]), .I4(x[6]), .I5(x[8]), .O(n45)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n46_lut (
        .I0(1'b1), .I1(n45), .I2(1'b1), .I3(1'b1), .I4(x[7]), .I5(x[9]), .O(n46)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n47_lut (
        .I0(n46), .I1(n39), .I2(n39), .I3(n39), .I4(x[1]), .I5(x[3]), .O(n47)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h23BF023B022B0023)) n48_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n48)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hBFFFBFFF3BFF2BBF)) n49_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n49)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0002000200000000)) n50_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n50)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n51_lut (
        .I0(n48), .I1(n49), .I2(n50), .I3(n48), .I4(x[1]), .I5(x[5]), .O(n51)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h022B002300020002)) n52_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n52)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n53_lut (
        .I0(1'b0), .I1(n52), .I2(1'b0), .I3(1'b0), .I4(x[1]), .I5(x[5]), .O(n53)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n54_lut (
        .I0(n51), .I1(n53), .I2(n53), .I3(n5), .I4(x[3]), .I5(x[7]), .O(n54)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFCD4D4C0FDFDFCD4)) n55_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[7]), .I5(x[8]), .O(n55)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h40400000D4C04040)) n56_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[7]), .I5(x[8]), .O(n56)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n57_lut (
        .I0(n55), .I1(n56), .I2(n56), .I3(1'b0), .I4(x[1]), .I5(x[9]), .O(n57)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFDFDFCD4FFFFFDFD)) n58_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[7]), .I5(x[8]), .O(n58)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hD4C04040FCD4D4C0)) n59_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[7]), .I5(x[8]), .O(n59)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n60_lut (
        .I0(1'b1), .I1(n58), .I2(n58), .I3(n59), .I4(x[1]), .I5(x[9]), .O(n60)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFFFFFFF7FFF7)) n61_lut (
        .I0(x[0]), .I1(x[1]), .I2(x[2]), .I3(x[4]), .I4(x[6]), .I5(x[7]), .O(n61)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n62_lut (
        .I0(1'b1), .I1(1'b1), .I2(1'b1), .I3(n61), .I4(x[8]), .I5(x[9]), .O(n62)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n63_lut (
        .I0(n57), .I1(n60), .I2(n60), .I3(n62), .I4(x[3]), .I5(x[5]), .O(n63)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h000004004D04CF4D)) n64_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n64)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000000000400)) n65_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n65)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h4D04CF4DDFCFFFDF)) n66_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n66)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n67_lut (
        .I0(n64), .I1(n65), .I2(n66), .I3(n64), .I4(x[1]), .I5(x[7]), .O(n67)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hCF4DDFCFFFDFFFFF)) n68_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n68)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h04004D04CF4DDFCF)) n69_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n69)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFDFFFFFFFFFFFFF)) n70_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n70)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n71_lut (
        .I0(n68), .I1(n69), .I2(n70), .I3(n68), .I4(x[1]), .I5(x[7]), .O(n71)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h0000000004004D04)) n72_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[4]), .I3(x[6]), .I4(x[8]), .I5(x[9]), .O(n72)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n73_lut (
        .I0(1'b0), .I1(1'b0), .I2(n72), .I3(1'b0), .I4(x[1]), .I5(x[7]), .O(n73)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n74_lut (
        .I0(n67), .I1(n71), .I2(n73), .I3(n67), .I4(x[3]), .I5(x[5]), .O(n74)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFFFFFFFF55555555)) n75_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[5]), .I5(x[6]), .O(n75)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'h5555555500000000)) n76_lut (
        .I0(x[0]), .I1(x[2]), .I2(x[3]), .I3(x[4]), .I4(x[5]), .I5(x[6]), .O(n76)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n77_lut (
        .I0(1'b1), .I1(n75), .I2(n76), .I3(1'b0), .I4(x[8]), .I5(x[9]), .O(n77)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n78_lut (
        .I0(n76), .I1(1'b0), .I2(1'b0), .I3(1'b0), .I4(x[8]), .I5(x[9]), .O(n78)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n79_lut (
        .I0(1'b1), .I1(1'b1), .I2(n75), .I3(n76), .I4(x[8]), .I5(x[9]), .O(n79)
    );

    (* DONT_TOUCH = "TRUE" *) plut_lut6 #(.INIT(64'hFF00F0F0CCCCAAAA)) n80_lut (
        .I0(n77), .I1(n78), .I2(n39), .I3(n79), .I4(x[1]), .I5(x[7]), .O(n80)
    );

    wire [9:0] ldtc_tss;
    wire [0:0] ldtc_td;
    assign ldtc_tss[0] = 1'b1;
    assign ldtc_tss[1] = n6;
    assign ldtc_tss[2] = n17;
    assign ldtc_tss[3] = n28;
    assign ldtc_tss[4] = n35;
    assign ldtc_tss[5] = n44;
    assign ldtc_tss[6] = n47;
    assign ldtc_tss[7] = n54;
    assign ldtc_tss[8] = n63;
    assign ldtc_tss[9] = n74;
    assign ldtc_td[0] = n80;
    wire [10:0] ldtc_tss_ext = { { 1{1'b0} }, ldtc_tss } << 1;
    wire [10:0] ldtc_td_ext  = { { 10{1'b0} }, ldtc_td  };
    assign f = ldtc_tss_ext + ldtc_td_ext;
endmodule
