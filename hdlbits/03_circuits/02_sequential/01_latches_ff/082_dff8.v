//==============================================================================
// HDLBits 082 — D flip-flops
// Official problem: https://hdlbits.01xz.net/wiki/Dff8
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 8-bit register: q[7:0] <= d[7:0] on posedge clk.
//

module top_module (
    input            clk,
    input      [7:0] d,
    output reg [7:0] q
);
    always @(posedge clk)
        q <= d;
endmodule
