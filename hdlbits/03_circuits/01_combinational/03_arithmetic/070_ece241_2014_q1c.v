//==============================================================================
// HDLBits 070 — Signed addition overflow
// Official problem: https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q1c
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 8-bit signed adder: s = a + b. Overflow is 1 when the two operands
// have the same sign and the result has the opposite sign:
//   overflow = a[7]&b[7]&~s[7] | ~a[7]&~b[7]&s[7]
//

module top_module (
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] s,
    output       overflow
);
    assign s = a + b;
    assign overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);
endmodule
