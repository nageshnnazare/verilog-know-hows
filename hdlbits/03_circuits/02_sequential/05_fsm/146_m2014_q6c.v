//==============================================================================
// HDLBits 146 — Q6c: FSM one-hot next-state logic
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q6c
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// One-hot version. States y[6:1], input w. Produce Y2 and Y4.
// Equations from the one-hot diagram:
//   Y2 = y[1] & ~w
//   Y4 = (y[2] | y[3] | y[5] | y[6]) & w   (example — see official figure)
// A widely used pair:
//   Y2 = y[1] & ~w
//   Y4 = y[2] & w | y[3] & w | y[5] & w | y[6] & w
//

module top_module (
    input  [6:1] y,
    input        w,
    output       Y2,
    output       Y4
);
    assign Y2 = y[1] & ~w;
    assign Y4 = (y[2] | y[3] | y[5] | y[6]) & w;
endmodule
