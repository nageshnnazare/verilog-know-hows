//==============================================================================
// HDLBits 008 — XNOR gate
// Official problem: https://hdlbits.01xz.net/wiki/Xnorgate
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build a 2-input XNOR (equality) gate: `out` is 1 when `a` and `b`
// are the same.
//

module top_module (
    input  a,
    input  b,
    output out
);
    assign out = ~(a ^ b);
endmodule
