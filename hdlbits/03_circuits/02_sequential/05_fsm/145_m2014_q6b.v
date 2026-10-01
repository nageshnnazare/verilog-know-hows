//==============================================================================
// HDLBits 145 — Q6b: FSM next-state logic
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q6b
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Given one-hot / binary state y[3:1] and input w, produce next-state
// bit Y1 (the exam asks only for Y1).
//

module top_module (
    input  [3:1] y,
    input        w,
    output       Y1
);
    assign Y1 = (y == 3'b000 && w)
              | (y == 3'b001 && w)
              | (y == 3'b011 && w)
              | (y == 3'b100 && w);
endmodule
