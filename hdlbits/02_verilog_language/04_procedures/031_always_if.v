//==============================================================================
// HDLBits 031 — If statement
// Official problem: https://hdlbits.01xz.net/wiki/Always_if
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// A 2-to-1 mux selects between two AND-like results:
//   If `sel_b1` and `sel_b2` are both 1, choose `b`; otherwise choose `a`.
// Implement this with an `assign` (out_assign) and with an always-if
// (out_always).
//

module top_module (
    input      a,
    input      b,
    input      sel_b1,
    input      sel_b2,
    output     out_assign,
    output reg out_always
);
    assign out_assign = (sel_b1 & sel_b2) ? b : a;
    always @(*) begin
        if (sel_b1 & sel_b2)
            out_always = b;
        else
            out_always = a;
    end
endmodule
