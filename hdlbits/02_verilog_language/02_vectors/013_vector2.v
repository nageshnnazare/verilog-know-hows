//==============================================================================
// HDLBits 013 — Vector part select
// Official problem: https://hdlbits.01xz.net/wiki/Vector2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Reverse the four bytes of a 32-bit word:
//   out[31:24] = in[7:0]
//   out[23:16] = in[15:8]
//   out[15:8]  = in[23:16]
//   out[7:0]   = in[31:24]
//

module top_module (
    input  [31:0] in,
    output [31:0] out
);
    assign out[31:24] = in[7:0];
    assign out[23:16] = in[15:8];
    assign out[15:8]  = in[23:16];
    assign out[7:0]   = in[31:24];
endmodule
