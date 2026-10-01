//==============================================================================
// HDLBits 050 — 7420 chip
// Official problem: https://hdlbits.01xz.net/wiki/7420
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// The 7420 is two independent 4-input NAND gates:
//   p1y = NAND(p1a,p1b,p1c,p1d)
//   p2y = NAND(p2a,p2b,p2c,p2d)
//

module top_module (
    input  p1a, p1b, p1c, p1d,
    output p1y,
    input  p2a, p2b, p2c, p2d,
    output p2y
);
    assign p1y = ~(p1a & p1b & p1c & p1d);
    assign p2y = ~(p2a & p2b & p2c & p2d);
endmodule
