//==============================================================================
// HDLBits 179 — Timer
// Official problem: https://hdlbits.01xz.net/wiki/Cs450/timer
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Down-counter timer. If `load`=1, load the 10-bit `data` as the
// remaining count. Otherwise decrement (saturating at 0). `tc` is 1
// when the count is 0.
//

module top_module (
    input        clk,
    input        load,
    input  [9:0] data,
    output       tc
);
    reg [9:0] cnt;
    always @(posedge clk) begin
        if (load)
            cnt <= data;
        else if (cnt != 10'd0)
            cnt <= cnt - 10'd1;
    end
    assign tc = (cnt == 10'd0);
endmodule
