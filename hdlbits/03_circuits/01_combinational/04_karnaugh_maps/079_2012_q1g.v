//==============================================================================
// HDLBits 079 — Karnaugh map
// Official problem: https://hdlbits.01xz.net/wiki/Exams/2012_q1g
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Another exam K-map on x[4:1]. A common simplified SOP:
//   f = (~x[2] & ~x[4]) | (~x[1] & x[3]) | (x[2] & x[3] & x[4])
// This is similar to m2014_q3 with a different covering of the 1s.
//

module top_module (
    input  [4:1] x,
    output       f
);
    assign f = (~x[2] & ~x[4])
             | (~x[1] & x[3])
             | (x[2] & x[3] & x[4]);
endmodule
