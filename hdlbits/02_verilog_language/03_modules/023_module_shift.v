//==============================================================================
// HDLBits 023 — Three modules
// Official problem: https://hdlbits.01xz.net/wiki/Module_shift
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// You are given `my_dff` (a positive-edge D flip-flop: clk, d, q).
// Instantiate three of them in a chain to make a 3-cycle delay:
//   d -> dff1 -> dff2 -> dff3 -> q
//

module top_module (
    input  clk,
    input  d,
    output q
);
    wire q1, q2;
    my_dff d1 (.clk(clk), .d(d),  .q(q1));
    my_dff d2 (.clk(clk), .d(q1), .q(q2));
    my_dff d3 (.clk(clk), .d(q2), .q(q));
endmodule
