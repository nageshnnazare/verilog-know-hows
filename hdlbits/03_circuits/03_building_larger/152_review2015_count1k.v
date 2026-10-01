//==============================================================================
// HDLBits 152 — Counter with period 1000
// Official problem: https://hdlbits.01xz.net/wiki/Exams/review2015_count1k
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Count 0..999 then wrap. Synchronous reset to 0. Output q[9:0].
//

module top_module (
    input            clk,
    input            reset,
    output reg [9:0] q
);
    always @(posedge clk) begin
        if (reset || q == 10'd999)
            q <= 10'd0;
        else
            q <= q + 10'd1;
    end
endmodule
