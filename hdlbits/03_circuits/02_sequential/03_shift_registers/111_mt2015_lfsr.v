//==============================================================================
// HDLBits 111 — 3-bit LFSR
// Official problem: https://hdlbits.01xz.net/wiki/Mt2015_lfsr
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 3-bit LFSR with parallel load. Ports match the exam (SW/KEY/LEDR):
//   clk = KEY[0], L = KEY[1], R = SW[2:0], Q = LEDR[2:0]
// When L=1, load SW. Otherwise:
//   q[2] <= q[1]
//   q[1] <= q[0]
//   q[0] <= q[2] ^ q[1]
//

module top_module (
    input  [2:0] SW,
    input  [1:0] KEY,
    output [2:0] LEDR
);
    wire clk = KEY[0];
    wire L   = KEY[1];
    reg  [2:0] Q;
    always @(posedge clk) begin
        if (L)
            Q <= SW;
        else
            Q <= {Q[1], Q[0], Q[2] ^ Q[1]};
    end
    assign LEDR = Q;
endmodule
