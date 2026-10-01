//==============================================================================
// HDLBits 025 — Adder 1
// Official problem: https://hdlbits.01xz.net/wiki/Module_add
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// You are given `add16` (16-bit adder with carry in/out). Build a
// 32-bit adder by instantiating two `add16` modules. The low half
// has cin=0; its cout feeds the high half's cin. Ignore the upper cout.
//

module top_module (
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] sum
);
    wire cout_lo;
    add16 lo (
        .a(a[15:0]),
        .b(b[15:0]),
        .cin(1'b0),
        .sum(sum[15:0]),
        .cout(cout_lo)
    );
    add16 hi (
        .a(a[31:16]),
        .b(b[31:16]),
        .cin(cout_lo),
        .sum(sum[31:16]),
        .cout()
    );
endmodule
