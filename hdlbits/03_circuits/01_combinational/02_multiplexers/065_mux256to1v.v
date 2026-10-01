//==============================================================================
// HDLBits 065 — 256-to-1 4-bit multiplexer
// Official problem: https://hdlbits.01xz.net/wiki/Mux256to1v
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 256:1 mux of 4-bit words packed in `in[1023:0]`.
// out = in[sel*4+3 : sel*4].
//

module top_module (
    input  [1023:0] in,
    input  [7:0]    sel,
    output [3:0]    out
);
    assign out = in[sel*4 +: 4];
endmodule
