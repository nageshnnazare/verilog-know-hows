//==============================================================================
// HDLBits 051 — Truth tables
// Official problem: https://hdlbits.01xz.net/wiki/Truthtable1
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Implement the 3-input function f(x3,x2,x1) whose 1-minterms are
// 2, 3, 5 and 7 (binary 010, 011, 101, 111).
// Simplified: f = (~x3 & x2) | (x3 & x1)
//

module top_module (
    input  x3,
    input  x2,
    input  x1,
    output f
);
    assign f = (~x3 & x2) | (x3 & x1);
endmodule
