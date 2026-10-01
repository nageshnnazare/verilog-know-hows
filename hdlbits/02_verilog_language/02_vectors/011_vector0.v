//==============================================================================
// HDLBits 011 — Vectors
// Official problem: https://hdlbits.01xz.net/wiki/Vector0
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Input `vec[2:0]` is a 3-bit vector. Drive `outv` with the same
// vector, and also split it onto scalar outputs `o2`, `o1`, `o0`
// (o2 is the MSB).
//

module top_module (
    input  wire [2:0] vec,
    output wire [2:0] outv,
    output wire       o2,
    output wire       o1,
    output wire       o0
);
    assign outv = vec;
    assign o2   = vec[2];
    assign o1   = vec[1];
    assign o0   = vec[0];
endmodule
