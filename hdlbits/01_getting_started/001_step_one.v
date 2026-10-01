//==============================================================================
// HDLBits 001 — Getting Started (Step one)
// Official problem: https://hdlbits.01xz.net/wiki/Step_one
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build a circuit with no inputs and one output named `one`.
// The output must always drive logic 1 (high).
//

module top_module (
    output one
);
    assign one = 1'b1;
endmodule
