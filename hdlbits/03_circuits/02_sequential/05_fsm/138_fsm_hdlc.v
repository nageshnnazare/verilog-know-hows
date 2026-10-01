//==============================================================================
// HDLBits 138 — Sequence recognition
// Official problem: https://hdlbits.01xz.net/wiki/Fsm_hdlc
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// HDLC bit-stuffing detector. Search the serial stream for 0111110
// (disc=1, bit to discard) and 01111110 (flag, done=1). Count
// consecutive 1s after a 0. Synchronous reset.
//

module top_module (
    input      clk,
    input      reset,
    input      in,
    output     disc,
    output     flag,
    output     err
);
    reg [3:0] ones, ones_n;
    always @(*) begin
        if (!in)
            ones_n = 4'd0;
        else if (ones < 4'd7)
            ones_n = ones + 4'd1;
        else
            ones_n = ones;
    end
    always @(posedge clk) begin
        if (reset)
            ones <= 4'd0;
        else
            ones <= ones_n;
    end
    assign disc = (ones == 4'd5) && (in == 1'b0);
    assign flag = (ones == 4'd6) && (in == 1'b0);
    assign err  = (ones >= 4'd7);
endmodule
