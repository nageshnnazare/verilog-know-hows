//==============================================================================
// HDLBits 102 — Slow decade counter
// Official problem: https://hdlbits.01xz.net/wiki/Countslow
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Decade counter (0-9) that only increments when `slowena` is 1.
// Synchronous reset to 0.
//

module top_module (
    input            clk,
    input            slowena,
    input            reset,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (reset)
            q <= 4'd0;
        else if (slowena) begin
            if (q == 4'd9)
                q <= 4'd0;
            else
                q <= q + 4'd1;
        end
    end
endmodule
