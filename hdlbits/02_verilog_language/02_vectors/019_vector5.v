//==============================================================================
// HDLBits 019 — More replication
// Official problem: https://hdlbits.01xz.net/wiki/Vector5
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Given five inputs a,b,c,d,e, compute a 25-bit output that is the
// pairwise XNOR of every pair (including a signal with itself).
// One compact form:
//   out = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
//         ^ { 5{a,b,c,d,e} }
// Each 5-bit group compares one input against {a,b,c,d,e}.
//

module top_module (
    input        a, b, c, d, e,
    output [24:0] out
);
    assign out = ~{{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}} ^ {5{a, b, c, d, e}};
endmodule
