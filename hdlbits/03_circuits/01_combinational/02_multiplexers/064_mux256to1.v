//==============================================================================
// HDLBits 064 — 256-to-1 multiplexer
// Official problem: https://hdlbits.01xz.net/wiki/Mux256to1
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 256:1 mux of 1-bit inputs packed in `in[255:0]`, selected by `sel[7:0]`.
//

module top_module (
    input  [255:0] in,
    input  [7:0]   sel,
    output         out
);
    assign out = in[sel];
endmodule
