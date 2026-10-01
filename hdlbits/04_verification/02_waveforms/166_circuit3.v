//==============================================================================
// HDLBits 166 — Combinational circuit 3
// Official problem: https://hdlbits.01xz.net/wiki/Sim/circuit3
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Combinational a,b,c,d -> q. Waveform matches (a|b) & (c|d).
//

module top_module (
    input  a, b, c, d,
    output q
);
    assign q = (a | b) & (c | d);
endmodule
