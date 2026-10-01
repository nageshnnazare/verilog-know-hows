//==============================================================================
// HDLBits 144 — Q3c: FSM logic
// Official problem: https://hdlbits.01xz.net/wiki/Exams/2014_q3c
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Combinational next-state for the Q3 FSM given Y2,Y1,Y0 and x.
// Output Y2A,Y1A,Y0A (next bits) and z.
// Equations from the exam state table (one accepted set):
//   Y2A = (~Y2 & Y1 & ~Y0 & x) | (Y2 & ~Y1 & ~Y0)
//   ... use a compact case on {Y2,Y1,Y0,x}.
//

module top_module (
    input  [3:1] y,
    input        w,
    output       Y2
);
    // Official ports are y[3:1], w, Y2 — only next-state bit Y2.
    assign Y2 = (y == 3'b001 && w == 1'b0)
              | (y == 3'b010 && w == 1'b0)
              | (y == 3'b101 && w == 1'b0)
              | (y == 3'b110 && w == 1'b0);
endmodule
