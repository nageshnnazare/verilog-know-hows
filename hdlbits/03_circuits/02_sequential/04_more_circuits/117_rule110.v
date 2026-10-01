//==============================================================================
// HDLBits 117 — Rule 110
// Official problem: https://hdlbits.01xz.net/wiki/Rule110
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 512-cell Rule 110 automaton. For neighbourhood ABC (left,cell,right)
// the next bit is 1 for 110, 101, 011, 010, 001 (and 0 for 111, 100, 000).
// `load` loads `data`. End neighbours are 0.
//

module top_module (
    input              clk,
    input              load,
    input      [511:0] data,
    output reg [511:0] q
);
    wire [511:0] left  = {1'b0, q[511:1]};
    wire [511:0] right = {q[510:0], 1'b0};
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= (q ^ right) | (q & ~left);
    end
endmodule
