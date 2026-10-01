//==============================================================================
// HDLBits 067 — Full adder
// Official problem: https://hdlbits.01xz.net/wiki/Fadd
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Full adder: {cout, sum} = a + b + cin.
//

module top_module (
    input  a, b, cin,
    output cout, sum
);
    assign {cout, sum} = a + b + cin;
endmodule
