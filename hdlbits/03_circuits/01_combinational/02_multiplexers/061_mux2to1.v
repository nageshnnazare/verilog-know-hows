//==============================================================================
// HDLBits 061 — 2-to-1 multiplexer
// Official problem: https://hdlbits.01xz.net/wiki/Mux2to1
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 1-bit 2:1 mux. `sel=0` chooses `a`, `sel=1` chooses `b`.
//

module top_module (
    input  a, b, sel,
    output out
);
    assign out = sel ? b : a;
endmodule
