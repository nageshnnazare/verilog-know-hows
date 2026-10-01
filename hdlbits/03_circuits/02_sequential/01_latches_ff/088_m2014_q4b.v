//==============================================================================
// HDLBits 088 — DFF
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q4b
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Positive-edge DFF with active-high asynchronous reset to 0.
//

module top_module (
    input      clk,
    input      d,
    input      ar,
    output reg q
);
    always @(posedge clk or posedge ar) begin
        if (ar)
            q <= 1'b0;
        else
            q <= d;
    end
endmodule
