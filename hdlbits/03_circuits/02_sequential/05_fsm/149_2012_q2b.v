//==============================================================================
// HDLBits 149 — Q2b: One-hot FSM equations
// Official problem: https://hdlbits.01xz.net/wiki/Exams/2012_q2b
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// One-hot next-state bits y[3:1] / Y1,Y3 for the 2012 FSM.
// Ports: y[3:1], w, Y1, Y3.
//

module top_module (
    input  [3:1] y,
    input        w,
    output       Y1,
    output       Y3
);
    assign Y1 = y[2] & ~w;
    assign Y3 = (y[1] | y[2] | y[3]) & w;
endmodule
