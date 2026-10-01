//==============================================================================
// HDLBits 004 — Four wires
// Official problem: https://hdlbits.01xz.net/wiki/Wire4
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Create a module with three inputs `a`, `b`, `c` and four outputs
// `w`, `x`, `y`, `z`. Connect them as follows:
//   w = a,  x = b,  y = b,  z = c
// (`b` fans out to both `x` and `y`).
//

module top_module (
    input  a, b, c,
    output w, x, y, z
);
    assign w = a;
    assign x = b;
    assign y = b;
    assign z = c;
endmodule
