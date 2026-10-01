//==============================================================================
// HDLBits 084 — DFF with reset value
// Official problem: https://hdlbits.01xz.net/wiki/Dff8p
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 8-bit register clocked on the *negative* edge, with active-high
// synchronous reset that loads 8'h34.
//

module top_module (
    input            clk,
    input            reset,
    input      [7:0] d,
    output reg [7:0] q
);
    always @(negedge clk) begin
        if (reset)
            q <= 8'h34;
        else
            q <= d;
    end
endmodule
