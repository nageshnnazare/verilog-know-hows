//==============================================================================
// HDLBits 062 — 2-to-1 bus multiplexer
// Official problem: https://hdlbits.01xz.net/wiki/Mux2to1v
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 100-bit 2:1 mux. `sel=0` chooses `a[99:0]`, else `b`.
//

module top_module (
    input  [99:0] a, b,
    input         sel,
    output [99:0] out
);
    assign out = sel ? b : a;
endmodule
