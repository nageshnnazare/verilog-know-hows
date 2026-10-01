//==============================================================================
// HDLBits 178 — T flip-flop
// Official problem: https://hdlbits.01xz.net/wiki/Tb/tff
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Testbench for a T flip-flop. Generate clk (period 10), reset for a
// few cycles, then apply a T sequence. HDLBits instantiates tff
// (.clk, .reset, .t, .q). You provide clk, reset, t.
//

`timescale 1ns/1ps
module top_module;
    reg clk, reset, t;
    wire q;
    tff dut (.clk(clk), .reset(reset), .t(t), .q(q));
    initial clk = 0;
    always #5 clk = ~clk;
    initial begin
        reset = 1'b1;
        t     = 1'b0;
        #10;
        reset = 1'b0;
        t     = 1'b1;
        #80;
        $finish;
    end
endmodule

module tff (
    input      clk,
    input      reset,
    input      t,
    output reg q
);
    always @(posedge clk) begin
        if (reset)
            q <= 1'b0;
        else if (t)
            q <= ~q;
    end
endmodule
