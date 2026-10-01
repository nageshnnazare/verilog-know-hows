//==============================================================================
// HDLBits 058 — 3-bit population count
// Official problem: https://hdlbits.01xz.net/wiki/Popcount3
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Count the number of 1s in `in[2:0]`. Output is 2 bits (0..3).
//

module top_module (
    input  [2:0] in,
    output [1:0] out
);
    assign out = in[0] + in[1] + in[2];
endmodule
