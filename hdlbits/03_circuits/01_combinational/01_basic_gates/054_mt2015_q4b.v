//==============================================================================
// HDLBits 054 — Simple circuit B
// Official problem: https://hdlbits.01xz.net/wiki/Mt2015_q4b
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Circuit B is an XNOR of x and y: z = ~(x ^ y).
//

module top_module (
    input  x,
    input  y,
    output z
);
    assign z = ~(x ^ y);
endmodule
