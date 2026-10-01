//==============================================================================
// HDLBits 069 — Adder
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q4j
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Add two 4-bit numbers x and y. Output is 5-bit `sum` (includes carry out).
//

module top_module (
    input  [3:0] x,
    input  [3:0] y,
    output [4:0] sum
);
    assign sum = x + y;
endmodule
