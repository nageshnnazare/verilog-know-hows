//==============================================================================
// HDLBits 038 — Reduction operators
// Official problem: https://hdlbits.01xz.net/wiki/Reduction
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Compute even parity of an 8-bit value: `parity = ^in` (XOR reduction).
// Output 1 when there is an odd number of 1s.
//

module top_module (
    input  [7:0] in,
    output       parity
);
    assign parity = ^in;
endmodule
