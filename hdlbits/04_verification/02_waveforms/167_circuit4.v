//==============================================================================
// HDLBits 167 — Combinational circuit 4
// Official problem: https://hdlbits.01xz.net/wiki/Sim/circuit4
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Combinational a,b,c,d -> q. Waveform matches q = b (q follows b).
//

module top_module (
    input  a, b, c, d,
    output q
);
    assign q = b;
endmodule
