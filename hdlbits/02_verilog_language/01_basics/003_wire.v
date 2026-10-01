//==============================================================================
// HDLBits 003 — Simple wire
// Official problem: https://hdlbits.01xz.net/wiki/Wire
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Create a module with one input `in` and one output `out`.
// Connect `out` directly to `in` (a wire).
//

module top_module (
    input  in,
    output out
);
    assign out = in;
endmodule
