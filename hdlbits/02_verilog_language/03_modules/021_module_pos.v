//==============================================================================
// HDLBits 021 — Connecting ports by position
// Official problem: https://hdlbits.01xz.net/wiki/Module_pos
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Instantiate `mod_a` whose ports, in declaration order, are
// `out1`, `out2`, `in1`, `in2`, `in3`, `in4`. Connect by position:
//   out1->out1, out2->out2, in1->a, in2->b, in3->c, in4->d
//

module top_module (
    input  a,
    input  b,
    input  c,
    input  d,
    output out1,
    output out2
);
    mod_a inst (out1, out2, a, b, c, d);
endmodule
