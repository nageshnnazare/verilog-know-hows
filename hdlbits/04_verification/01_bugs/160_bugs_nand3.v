//==============================================================================
// HDLBits 160 — NAND
// Official problem: https://hdlbits.01xz.net/wiki/Bugs_nand3
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Fix a 3-input NAND. The bug is usually AND instead of NAND, or a 2-input gate.
//

module top_module (
    input  a, b, c,
    output out
);
    assign out = ~(a & b & c);
endmodule
