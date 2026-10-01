//==============================================================================
// HDLBits 087 — D Latch
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q4a
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Level-sensitive D latch: when `ena` is 1, q follows d; otherwise q holds.
//

module top_module (
    input      d,
    input      ena,
    output reg q
);
    always @(*) begin
        if (ena)
            q = d;
    end
endmodule
