//==============================================================================
// HDLBits 074 — 4-variable
// Official problem: https://hdlbits.01xz.net/wiki/Kmap2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 4-variable K-map (ab rows, cd columns):
//
//            cd=00  01  11  10
//     ab=00    0     1   1   1
//     ab=01    0     0   0   0
//     ab=11    1     1   1   1
//     ab=10    1     1   0   1
//
// One SOP covering:
//   out = (~a & ~b & (c | d)) | (a & b) | (a & ~b & ~(c & d))
//

module top_module (
    input  a, b, c, d,
    output out
);
    assign out = (~a & ~b & (c | d))
               | (a & b)
               | (a & ~b & ~(c & d));
endmodule
