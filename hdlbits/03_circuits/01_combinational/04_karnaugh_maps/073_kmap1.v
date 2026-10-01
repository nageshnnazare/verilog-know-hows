//==============================================================================
// HDLBits 073 — 3-variable
// Official problem: https://hdlbits.01xz.net/wiki/Kmap1
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Implement the 3-variable K-map (a across the top, bc down the side):
//
//           a=0   a=1
//     bc=00  0     1
//     bc=01  1     1
//     bc=11  1     1
//     bc=10  1     1
//
// Only minterm 000 is 0, so out = a | b | c.
//

module top_module (
    input  a, b, c,
    output out
);
    assign out = a | b | c;
endmodule
