//==============================================================================
// HDLBits 164 — Combinational circuit 1
// Official problem: https://hdlbits.01xz.net/wiki/Sim/circuit1
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Combinational. From the waveform, q is 1 only when both a and b are 1
// (AND).
//

module top_module (
    input  a,
    input  b,
    output q
);
    assign q = a & b;
endmodule
