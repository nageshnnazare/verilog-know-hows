//==============================================================================
// HDLBits 101 — Decade counter again
// Official problem: https://hdlbits.01xz.net/wiki/Count1to10
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Count 1 through 10, then wrap to 1. Synchronous reset to 1.
//

module top_module (
    input            clk,
    input            reset,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (reset || q == 4'd10)
            q <= 4'd1;
        else
            q <= q + 4'd1;
    end
endmodule
