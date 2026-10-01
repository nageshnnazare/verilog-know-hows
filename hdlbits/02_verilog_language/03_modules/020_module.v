//==============================================================================
// HDLBits 020 — Modules
// Official problem: https://hdlbits.01xz.net/wiki/Module
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Instantiate the provided module `mod_a` (ports `in1`, `in2`, `out`)
// once. Connect `in1` to `a`, `in2` to `b`, and `out` to `out`.
// HDLBits supplies `mod_a`; a local helper is in hdlbits/helpers/mod_a.v.
//

module top_module (
    input  a,
    input  b,
    output out
);
    mod_a inst (
        .in1(a),
        .in2(b),
        .out(out)
    );
endmodule
