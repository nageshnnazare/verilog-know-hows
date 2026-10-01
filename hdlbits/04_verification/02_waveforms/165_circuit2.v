//==============================================================================
// HDLBits 165 — Combinational circuit 2
// Official problem: https://hdlbits.01xz.net/wiki/Sim/circuit2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Combinational a,b,c,d -> q. Read the official waveform; the function
// implemented here is even parity inverted: q = ~(a ^ b ^ c ^ d).
// (If that does not match the figure, compare bit-by-bit on HDLBits.)
//

module top_module (
    input  a, b, c, d,
    output q
);
    assign q = ~(a ^ b ^ c ^ d);
endmodule
