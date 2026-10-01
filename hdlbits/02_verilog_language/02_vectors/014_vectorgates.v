//==============================================================================
// HDLBits 014 — Bitwise operators
// Official problem: https://hdlbits.01xz.net/wiki/Vectorgates
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Given 3-bit vectors `a` and `b`:
//   out_or_bitwise = a | b          (bitwise OR)
//   out_or_logical = a || b         (logical OR, 1-bit)
//   out_not        = {~b, ~a}       (concatenation of inversions, 6 bits)
//

module top_module (
    input  [2:0] a,
    input  [2:0] b,
    output [2:0] out_or_bitwise,
    output       out_or_logical,
    output [5:0] out_not
);
    assign out_or_bitwise = a | b;
    assign out_or_logical = a || b;
    assign out_not        = {~b, ~a};
endmodule
