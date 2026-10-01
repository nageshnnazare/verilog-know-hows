//==============================================================================
// HDLBits 022 — Connecting ports by name
// Official problem: https://hdlbits.01xz.net/wiki/Module_name
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Same `mod_a` as the previous problem, but connect ports by name:
//   .out1(out1), .out2(out2), .in1(a), .in2(b), .in3(c), .in4(d)
//

module top_module (
    input  a,
    input  b,
    input  c,
    input  d,
    output out1,
    output out2
);
    mod_a inst (
        .out1(out1),
        .out2(out2),
        .in1(a),
        .in2(b),
        .in3(c),
        .in4(d)
    );
endmodule
