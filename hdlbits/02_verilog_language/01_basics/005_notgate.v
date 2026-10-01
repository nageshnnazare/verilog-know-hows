//==============================================================================
// HDLBits 005 — Inverter
// Official problem: https://hdlbits.01xz.net/wiki/Notgate
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build a NOT gate: `out` is the inversion of `in`.
//

module top_module (
    input  in,
    output out
);
    assign out = ~in;
endmodule
