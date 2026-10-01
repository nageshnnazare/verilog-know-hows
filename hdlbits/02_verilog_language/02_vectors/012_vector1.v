//==============================================================================
// HDLBits 012 — Vectors in more detail
// Official problem: https://hdlbits.01xz.net/wiki/Vector1
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Split a 16-bit input into a high byte `out_hi` (bits [15:8]) and
// a low byte `out_lo` (bits [7:0]).
//

module top_module (
    input  wire [15:0] in,
    output wire [7:0]  out_hi,
    output wire [7:0]  out_lo
);
    assign out_hi = in[15:8];
    assign out_lo = in[7:0];
endmodule
