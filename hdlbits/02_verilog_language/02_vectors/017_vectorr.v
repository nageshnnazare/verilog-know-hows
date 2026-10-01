//==============================================================================
// HDLBits 017 — Vector reversal 1
// Official problem: https://hdlbits.01xz.net/wiki/Vectorr
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Reverse the bit order of an 8-bit vector:
//   out[7] = in[0], out[6] = in[1], ..., out[0] = in[7]
//

module top_module (
    input  [7:0] in,
    output [7:0] out
);
    assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};
endmodule
