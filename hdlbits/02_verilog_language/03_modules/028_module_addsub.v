//==============================================================================
// HDLBits 028 — Adder-subtractor
// Official problem: https://hdlbits.01xz.net/wiki/Module_addsub
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build a 32-bit adder-subtractor using two `add16` modules.
// When `sub` is 0, compute a+b. When `sub` is 1, compute a-b by
// inverting `b` and setting the low-half carry-in to 1 (two's complement).
//

module top_module (
    input         sub,
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] sum
);
    wire [31:0] b_xor;
    wire        cout_lo;
    assign b_xor = b ^ {32{sub}};
    add16 lo (
        .a(a[15:0]), .b(b_xor[15:0]), .cin(sub),
        .sum(sum[15:0]), .cout(cout_lo)
    );
    add16 hi (
        .a(a[31:16]), .b(b_xor[31:16]), .cin(cout_lo),
        .sum(sum[31:16]), .cout()
    );
endmodule
