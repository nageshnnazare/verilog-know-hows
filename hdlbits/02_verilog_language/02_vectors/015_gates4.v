//==============================================================================
// HDLBits 015 — Four-input gates
// Official problem: https://hdlbits.01xz.net/wiki/Gates4
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build 4-input AND, OR, and XOR gates on vector `in[3:0]`.
// Reduction operators (`&in`, `|in`, `^in`) are the natural fit.
//

module top_module (
    input  [3:0] in,
    output       out_and,
    output       out_or,
    output       out_xor
);
    assign out_and = &in;
    assign out_or  = |in;
    assign out_xor = ^in;
endmodule
