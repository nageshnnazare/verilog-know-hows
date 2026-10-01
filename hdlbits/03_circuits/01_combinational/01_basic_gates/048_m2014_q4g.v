//==============================================================================
// HDLBits 048 — Two gates
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q4g
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// The exam figure is an AND of in2 and in3, then XOR with in1:
//   out = in1 ^ (in2 & in3)
//

module top_module (
    input  in1,
    input  in2,
    input  in3,
    output out
);
    assign out = (~(in1 ^ in2)) ^ in3;
endmodule
