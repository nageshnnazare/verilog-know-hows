//==============================================================================
// HDLBits 077 — Minimum SOP and POS
// Official problem: https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// A 4-input function is 1 for minterms 2, 7, 15; 0 for
// 0,1,4,5,6,9,10,13,14; don't-care for the rest (3,8,11,12).
//
// Minimum SOP (cover 2,7,15 using don't-cares):
//   out_sop = (c & d) | (~a & ~b & c)
// Minimum POS:
//   out_pos = c & (~a | ~b | d) & (~b | ~c | d)   (one accepted form)
// Equivalently implement POS from the 0-maxterms.
//

module top_module (
    input  a, b, c, d,
    output out_sop,
    output out_pos
);
    assign out_sop = (c & d) | (~a & ~b & c);
    assign out_pos = c & (~b | d) & (~a | b | d);
endmodule
