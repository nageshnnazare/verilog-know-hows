//==============================================================================
// HDLBits 161 — Mux
// Official problem: https://hdlbits.01xz.net/wiki/Bugs_mux4
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Fix a 4:1 mux built from 2:1 muxes. Inputs a,b,c,d, sel[1:0], out.
// sel=0..3 chooses a,b,c,d. The usual bug is wiring the two-level mux
// incorrectly (swap sel bits, or wrong intermediate).
//

module top_module (
    input  [1:0] sel,
    input  [7:0] a, b, c, d,
    output [7:0] out
);
    assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);
endmodule
