//==============================================================================
// HDLBits 049 — More logic gates
// Official problem: https://hdlbits.01xz.net/wiki/Gates
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Given `a` and `b`, produce all of:
//   out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb
// where `out_anotb` is a AND NOT b.
//

module top_module (
    input  a, b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);
    assign out_and  = a & b;
    assign out_or   = a | b;
    assign out_xor  = a ^ b;
    assign out_nand = ~(a & b);
    assign out_nor  = ~(a | b);
    assign out_xnor = ~(a ^ b);
    assign out_anotb = a & ~b;
endmodule
