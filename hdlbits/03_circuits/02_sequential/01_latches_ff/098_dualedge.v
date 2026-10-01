//==============================================================================
// HDLBits 098 — Dual-edge triggered flip-flop
// Official problem: https://hdlbits.01xz.net/wiki/Dualedge
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// A flip-flop that samples `d` on both rising and falling edges of clk.
// Implement with two DFFs (posedge and negedge) and XOR/mux them:
//   q = clk ? q_neg : q_pos   (one accepted form)
// or q = q_pos ^ q_neg with carefully chosen next-state equations.
// The mux form: posedge register samples d, negedge register samples d,
// output is clk ? n : p so the most recently sampled value is seen.
//

module top_module (
    input      clk,
    input      d,
    output     q
);
    reg p, n;
    always @(posedge clk)
        p <= d;
    always @(negedge clk)
        n <= d;
    assign q = clk ? p : n;
endmodule
