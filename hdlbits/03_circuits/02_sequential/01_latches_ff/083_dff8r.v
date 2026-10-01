//==============================================================================
// HDLBits 083 — DFF with reset
// Official problem: https://hdlbits.01xz.net/wiki/Dff8r
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 8-bit register with active-high synchronous reset to 0.
//

module top_module (
    input            clk,
    input            reset,
    input      [7:0] d,
    output reg [7:0] q
);
    always @(posedge clk) begin
        if (reset)
            q <= 8'd0;
        else
            q <= d;
    end
endmodule
