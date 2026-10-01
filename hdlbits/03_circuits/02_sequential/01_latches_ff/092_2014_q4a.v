//==============================================================================
// HDLBits 092 — Mux and DFF
// Official problem: https://hdlbits.01xz.net/wiki/Exams/2014_q4a
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// One cell of a shift register: a DFF whose next value is
//   L=1: load R
//   L=0, E=1: shift in w
//   L=0, E=0: hold q
//

module top_module (
    input      clk,
    input      w, R, E, L,
    output reg Q
);
    always @(posedge clk) begin
        if (L)
            Q <= R;
        else if (E)
            Q <= w;
    end
endmodule
