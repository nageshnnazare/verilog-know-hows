//==============================================================================
// HDLBits 097 — Edge capture register
// Official problem: https://hdlbits.01xz.net/wiki/Edgecapture
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 32-bit register. For each bit, set the output bit when that input bit
// has a 1->0 transition, and hold it until a synchronous reset.
// Reset is active-high and takes priority.
//

module top_module (
    input             clk,
    input             reset,
    input      [31:0] in,
    output reg [31:0] out
);
    reg [31:0] in_d;
    always @(posedge clk) begin
        in_d <= in;
        if (reset)
            out <= 32'd0;
        else
            out <= out | (~in & in_d);
    end
endmodule
