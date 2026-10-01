//==============================================================================
// HDLBits 055 — Combine circuits A and B
// Official problem: https://hdlbits.01xz.net/wiki/Mt2015_q4
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Instantiate two copies of circuit A and two of circuit B, all driven
// by (x, y). Combine them as:
//   z = (A1 | B1) ^ (A2 & B2)
// Write A and B as submodules in the same file.
//

module top_module (
    input  x,
    input  y,
    output z
);
    wire a1, b1, a2, b2;
    mt2015_q4_a ua1 (.x(x), .y(y), .z(a1));
    mt2015_q4_b ub1 (.x(x), .y(y), .z(b1));
    mt2015_q4_a ua2 (.x(x), .y(y), .z(a2));
    mt2015_q4_b ub2 (.x(x), .y(y), .z(b2));
    assign z = (a1 | b1) ^ (a2 & b2);
endmodule

module mt2015_q4_a (
    input  x,
    input  y,
    output z
);
    assign z = (x ^ y) & x;
endmodule

module mt2015_q4_b (
    input  x,
    input  y,
    output z
);
    assign z = ~(x ^ y);
endmodule
