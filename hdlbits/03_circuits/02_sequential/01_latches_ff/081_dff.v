//==============================================================================
// HDLBits 081 — D flip-flop
// Official problem: https://hdlbits.01xz.net/wiki/Dff
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Positive-edge D flip-flop: q <= d on posedge clk.
//

module top_module (
    input      clk,
    input      d,
    output reg q
);
    always @(posedge clk)
        q <= d;
endmodule
