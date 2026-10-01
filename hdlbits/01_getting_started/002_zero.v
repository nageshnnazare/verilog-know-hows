//==============================================================================
// HDLBits 002 — Output Zero
// Official problem: https://hdlbits.01xz.net/wiki/Zero
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build a circuit with no inputs and one output named `zero`.
// The output must always drive logic 0 (low).
//

module top_module (
    output zero
);
    assign zero = 1'b0;
endmodule
