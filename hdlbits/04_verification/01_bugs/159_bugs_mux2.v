//==============================================================================
// HDLBits 159 — Mux
// Official problem: https://hdlbits.01xz.net/wiki/Bugs_mux2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Fix a 2:1 mux. The original bug is typically using `=` inside a
// clocked block, or swapping the select, or declaring `out` as a
// wire and assigning in always. Correct function: sel=0 -> a, sel=1 -> b.
//

module top_module (
    input      sel,
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] out
);
    assign out = sel ? b : a;
endmodule
