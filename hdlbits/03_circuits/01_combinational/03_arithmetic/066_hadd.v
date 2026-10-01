//==============================================================================
// HDLBits 066 — Half adder
// Official problem: https://hdlbits.01xz.net/wiki/Hadd
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Half adder: {cout, sum} = a + b.
//

module top_module (
    input  a, b,
    output cout, sum
);
    assign {cout, sum} = a + b;
endmodule
