//==============================================================================
// HDLBits 037 — Conditional ternary operator
// Official problem: https://hdlbits.01xz.net/wiki/Conditional
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Given four unsigned 8-bit values a,b,c,d, find the minimum using
// nested ternary operators. Output `min`.
//

module top_module (
    input  [7:0] a, b, c, d,
    output [7:0] min
);
    wire [7:0] min_ab  = (a < b) ? a : b;
    wire [7:0] min_cd  = (c < d) ? c : d;
    assign min = (min_ab < min_cd) ? min_ab : min_cd;
endmodule
