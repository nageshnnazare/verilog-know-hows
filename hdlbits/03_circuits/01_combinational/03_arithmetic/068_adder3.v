//==============================================================================
// HDLBits 068 — 3-bit binary adder
// Official problem: https://hdlbits.01xz.net/wiki/Adder3
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 3-bit ripple-carry adder. Inputs a[2:0], b[2:0], cin.
// Outputs cout and sum[2:0]. You may instantiate full adders or add directly.
//

module top_module (
    input  [2:0] a, b,
    input        cin,
    output [2:0] cout,
    output [2:0] sum
);
    full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin),     .cout(cout[0]), .sum(sum[0]));
    full_adder fa1 (.a(a[1]), .b(b[1]), .cin(cout[0]), .cout(cout[1]), .sum(sum[1]));
    full_adder fa2 (.a(a[2]), .b(b[2]), .cin(cout[1]), .cout(cout[2]), .sum(sum[2]));
endmodule

module full_adder (
    input  a, b, cin,
    output cout, sum
);
    assign {cout, sum} = a + b + cin;
endmodule
