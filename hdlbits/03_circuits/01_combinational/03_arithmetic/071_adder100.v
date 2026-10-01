//==============================================================================
// HDLBits 071 — 100-bit binary adder
// Official problem: https://hdlbits.01xz.net/wiki/Adder100
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 100-bit adder: {cout, sum} = a + b + cin.
//

module top_module (
    input  [99:0] a, b,
    input         cin,
    output        cout,
    output [99:0] sum
);
    assign {cout, sum} = a + b + cin;
endmodule
