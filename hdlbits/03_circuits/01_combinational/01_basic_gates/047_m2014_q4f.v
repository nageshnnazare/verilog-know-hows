//==============================================================================
// HDLBits 047 — Another gate
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q4f
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// AND of `in1` with the inversion of `in2`: `out = in1 & ~in2`.
//

module top_module (
    input  in1,
    input  in2,
    output out
);
    assign out = in1 & ~in2;
endmodule
