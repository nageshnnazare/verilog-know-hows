//==============================================================================
// HDLBits 052 — Two-bit equality
// Official problem: https://hdlbits.01xz.net/wiki/Mt2015_eq2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Output `z` is 1 iff 2-bit vectors `a` and `b` are equal.
//

module top_module (
    input  [1:0] a,
    input  [1:0] b,
    output       z
);
    assign z = (a == b);
endmodule
