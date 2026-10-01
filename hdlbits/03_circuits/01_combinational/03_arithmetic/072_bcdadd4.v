//==============================================================================
// HDLBits 072 — 4-digit BCD adder
// Official problem: https://hdlbits.01xz.net/wiki/Bcdadd4
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 4-digit BCD adder from four `bcd_fadd` instances (HDLBits provides
// that module). a and b are 16-bit BCD (4 digits). Produce 16-bit sum
// and a carry-out.
//

module top_module (
    input  [15:0] a, b,
    input         cin,
    output        cout,
    output [15:0] sum
);
    wire [3:0] c;
    bcd_fadd d0 (.a(a[3:0]),   .b(b[3:0]),   .cin(cin),  .cout(c[0]), .sum(sum[3:0]));
    bcd_fadd d1 (.a(a[7:4]),   .b(b[7:4]),   .cin(c[0]), .cout(c[1]), .sum(sum[7:4]));
    bcd_fadd d2 (.a(a[11:8]),  .b(b[11:8]),  .cin(c[1]), .cout(c[2]), .sum(sum[11:8]));
    bcd_fadd d3 (.a(a[15:12]), .b(b[15:12]), .cin(c[2]), .cout(c[3]), .sum(sum[15:12]));
    assign cout = c[3];
endmodule
