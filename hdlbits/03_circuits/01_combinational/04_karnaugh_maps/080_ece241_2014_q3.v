//==============================================================================
// HDLBits 080 — K-map implemented with a multiplexer
// Official problem: https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q3
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Implement the K-map using a 4:1 mux whose select is {a,b} (given
// as part of the top-level on HDLBits — you only drive mux_in[3:0],
// the four data inputs of the mux, as functions of c and d).
//
// One accepted programming of the mux data inputs:
//   mux_in[0] = c | d      // ab=00
//   mux_in[1] = 1'b0       // ab=01
//   mux_in[2] = ~d         // ab=11
//   mux_in[3] = c & d      // ab=10
// (Gray-code order of ab: 00, 01, 11, 10 corresponding to mux_in 0,1,2,3
// on some figures — HDLBits numbers mux_in[0] for ab=00, [1] for 01,
// [2] for 11, [3] for 10.)
//

module top_module (
    input        c,
    input        d,
    output [3:0] mux_in
);
    assign mux_in[0] = c | d;
    assign mux_in[1] = 1'b0;
    assign mux_in[2] = ~d;
    assign mux_in[3] = c & d;
endmodule
