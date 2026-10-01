//==============================================================================
// HDLBits 116 — Rule 90
// Official problem: https://hdlbits.01xz.net/wiki/Rule90
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 512-cell elementary cellular automaton, Rule 90: next[i] = left XOR right.
// `load` parallel-loads `data`. Neighbours past the ends are 0.
// Advance one generation each clock when not loading.
//

module top_module (
    input             clk,
    input             load,
    input      [511:0] data,
    output reg [511:0] q
);
    always @(posedge clk) begin
        if (load)
            q <= data;
        else
            q <= {1'b0, q[511:1]} ^ {q[510:0], 1'b0};
    end
endmodule
