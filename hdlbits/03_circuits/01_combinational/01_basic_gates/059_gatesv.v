//==============================================================================
// HDLBits 059 — Gates and vectors
// Official problem: https://hdlbits.01xz.net/wiki/Gatesv
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// For 4-bit `in[3:0]`:
//   out_both[2:0]      = in[2:0] & in[3:1]   (each bit AND neighbour)
//   out_any[3:1]       = in[3:1] | in[2:0]
//   out_different[3:0] = in ^ {in[0], in[3:1]}
// (out_different[3] compares in[3] with in[0], wrapping around.)
//

module top_module (
    input  [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    assign out_both      = in[2:0] & in[3:1];
    assign out_any       = in[3:1] | in[2:0];
    assign out_different = in ^ {in[0], in[3:1]};
endmodule
