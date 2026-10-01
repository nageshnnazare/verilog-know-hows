//==============================================================================
// HDLBits 078 — Karnaugh map
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q3
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Implement f(x[4:1]) from the exam K-map. A standard simplified form is:
//   f = (~x[1] & x[3]) | (x[2] & x[3] & x[4]) | (~x[2] & ~x[4])
// Check the official figure if you want to regroup; any equivalent
// Boolean function is accepted.
//

module top_module (
    input  [4:1] x,
    output       f
);
    assign f = (~x[1] & x[3])
             | (x[2] & x[3] & x[4])
             | (~x[2] & ~x[4]);
endmodule
