//==============================================================================
// HDLBits 026 — Adder 2
// Official problem: https://hdlbits.01xz.net/wiki/Module_fadd
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build a 32-bit adder from two provided `add16` modules (same as
// Adder 1) and also implement a 1-bit full adder `add1` (a, b, cin
// -> sum, cout). HDLBits uses your `add1` inside its `add16`.
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

module add1 (
    input  a,
    input  b,
    input  cin,
    output sum,
    output cout
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (a & cin) | (b & cin);
endmodule
