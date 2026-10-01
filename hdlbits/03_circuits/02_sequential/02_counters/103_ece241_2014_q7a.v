//==============================================================================
// HDLBits 103 — Counter 1-12
// Official problem: https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q7a
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Count 1 through 12 using a provided 4-bit binary counter with
// enable, load, and load-data ports. You drive:
//   c_enable, c_load, c_d[3:0]
// and the provided counter's Q is `q`. Reset (active high, sync)
// loads 1. Wrap from 12 back to 1 by loading 1.
// HDLBits provides `count4`. Local helper: helpers/count4.v.
//

module top_module (
    input            clk,
    input            reset,
    input            enable,
    output [3:0]     Q,
    output           c_enable,
    output           c_load,
    output [3:0]     c_d
);
    count4 the_counter (
        .clk(clk),
        .enable(c_enable),
        .load(c_load),
        .d(c_d),
        .q(Q)
    );
    assign c_enable = enable;
    assign c_load   = reset | (Q == 4'd12 && enable);
    assign c_d      = 4'd1;
endmodule
