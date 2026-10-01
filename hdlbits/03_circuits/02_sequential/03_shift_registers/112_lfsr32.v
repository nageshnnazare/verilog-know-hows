//==============================================================================
// HDLBits 112 — 32-bit LFSR
// Official problem: https://hdlbits.01xz.net/wiki/Lfsr32
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 32-bit Galois LFSR with taps at 32, 22, 2, 1. Synchronous reset to 1.
// Fibonacci form: q <= {q[30:0], q[31]^q[21]^q[1]^q[0]}.
//

module top_module (
    input             clk,
    input             reset,
    output reg [31:0] q
);
    always @(posedge clk) begin
        if (reset)
            q <= 32'h1;
        else
            q <= {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};
    end
endmodule
