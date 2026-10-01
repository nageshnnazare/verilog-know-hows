//==============================================================================
// HDLBits 075 — 4-variable (don't-cares)
// Official problem: https://hdlbits.01xz.net/wiki/Kmap3
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 4-variable K-map with don't-cares. One covering that matches the
// official map (don't-cares taken as 1 only where they help, never
// covering a required 0) is:
//
//   out = a ? (c | d) : (~b & c)
//
// Compare the K-map image on HDLBits if you regroup.
//

module top_module (
    input  a, b, c, d,
    output out
);
    assign out = a ? (c | d) : (~b & c);
endmodule
