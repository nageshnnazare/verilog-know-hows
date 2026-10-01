//==============================================================================
// HDLBits 044 — Wire
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q4h
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Connect output `out` directly to input `in`.
//

module top_module (
    input  in,
    output out
);
    assign out = in;
endmodule
