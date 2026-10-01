//==============================================================================
// HDLBits 076 — 4-variable (XOR of all)
// Official problem: https://hdlbits.01xz.net/wiki/Kmap4
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// The K-map is a checkerboard: flipping any one input always inverts
// the output. That function is XOR of all four variables
// (odd parity): out = a ^ b ^ c ^ d.
//

module top_module (
    input  a, b, c, d,
    output out
);
    assign out = a ^ b ^ c ^ d;
endmodule
