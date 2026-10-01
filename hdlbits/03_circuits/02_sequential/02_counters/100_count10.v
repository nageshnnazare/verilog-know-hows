//==============================================================================
// HDLBits 100 — Decade counter
// Official problem: https://hdlbits.01xz.net/wiki/Count10
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Count 0 through 9, then wrap to 0. Synchronous reset to 0.
//

module top_module (
    input            clk,
    input            reset,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (reset || q == 4'd9)
            q <= 4'd0;
        else
            q <= q + 4'd1;
    end
endmodule
