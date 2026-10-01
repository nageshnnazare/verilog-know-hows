//==============================================================================
// HDLBits 091 — Mux and DFF
// Official problem: https://hdlbits.01xz.net/wiki/Mt2015_muxdff
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 2:1 mux in front of a DFF. When L=1, load `d`; when L=0, load `w`
// (or the other way: L selects d vs feedback). HDLBits: L=1 chooses r
// (or d), L=0 chooses E ? w : q. This simpler problem is:
//   next = L ? r : w;  q <= next
// Ports: clk, L, q_in, r_in, Q? Standard ports:
//   clk, w, R, E, L  — that's 2014_q4a.
// This problem (mt2015_muxdff) ports: clk, L, q_in, d_in, Q
//   Q <= L ? d_in : q_in
//

module top_module (
    input      clk,
    input      L,
    input      q_in,
    input      r_in,
    output reg Q
);
    always @(posedge clk)
        Q <= L ? r_in : q_in;
endmodule
