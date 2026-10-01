//==============================================================================
// HDLBits 053 — Simple circuit A
// Official problem: https://hdlbits.01xz.net/wiki/Mt2015_q4a
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Circuit A from the exam figure implements
//   z = (x ^ y) & x
// which is the same as x & ~y.
//

module top_module (
    input  x,
    input  y,
    output z
);
    assign z = (x ^ y) & x;
endmodule
