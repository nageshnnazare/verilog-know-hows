//==============================================================================
// HDLBits 045 — GND
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q4i
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Drive output `out` to constant 0 (ground).
//

module top_module (
    output out
);
    assign out = 1'b0;
endmodule
