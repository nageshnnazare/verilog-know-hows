//==============================================================================
// HDLBits 104 — Counter 1000
// Official problem: https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q7b
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// From a 1000 Hz clock, produce a 1 Hz pulse `OneHertz` by cascading
// three decade (0-9) counters. HDLBits provides `bcdcount`
// (enable in, Q[3:0], enable out). Wire them so the next digit
// enables when the previous is at 9 and enabled.
// OneHertz is 1 when all three digits are 9.
//

module top_module (
    input  clk,
    input  reset,
    output OneHertz,
    output [2:0] c_enable
);
    wire [3:0] q0, q1, q2;
    assign c_enable[0] = 1'b1;
    assign c_enable[1] = (q0 == 4'd9);
    assign c_enable[2] = (q0 == 4'd9) && (q1 == 4'd9);
    bcdcount counter0 (.clk(clk), .reset(reset), .enable(c_enable[0]), .Q(q0));
    bcdcount counter1 (.clk(clk), .reset(reset), .enable(c_enable[1]), .Q(q1));
    bcdcount counter2 (.clk(clk), .reset(reset), .enable(c_enable[2]), .Q(q2));
    assign OneHertz = (q0 == 4'd9) && (q1 == 4'd9) && (q2 == 4'd9);
endmodule
