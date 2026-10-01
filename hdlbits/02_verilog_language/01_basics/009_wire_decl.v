//==============================================================================
// HDLBits 009 — Declaring wires
// Official problem: https://hdlbits.01xz.net/wiki/Wire_decl
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Implement the circuit that computes:
//   out   = (a | b) & (c | d)
//   out_n = ~out
// Declare an internal wire for the AND result rather than repeating
// the expression.
//

module top_module (
    input  a,
    input  b,
    input  c,
    input  d,
    output out,
    output out_n
);
    wire and_out;
    assign and_out = (a | b) & (c | d);
    assign out     = and_out;
    assign out_n   = ~and_out;
endmodule
