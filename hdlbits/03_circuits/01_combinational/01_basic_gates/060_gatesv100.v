//==============================================================================
// HDLBits 060 — Even longer vectors
// Official problem: https://hdlbits.01xz.net/wiki/Gatesv100
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Same neighbour-AND / neighbour-OR / wrap-XOR as Gatesv, but 100 bits.
//

module top_module (
    input  [99:0] in,
    output [98:0] out_both,
    output [99:1] out_any,
    output [99:0] out_different
);
    assign out_both      = in[98:0] & in[99:1];
    assign out_any       = in[99:1] | in[98:0];
    assign out_different = in ^ {in[0], in[99:1]};
endmodule
