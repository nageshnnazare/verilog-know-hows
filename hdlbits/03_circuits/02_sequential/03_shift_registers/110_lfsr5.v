//==============================================================================
// HDLBits 110 — 5-bit LFSR
// Official problem: https://hdlbits.01xz.net/wiki/Lfsr5
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 5-bit Galois LFSR. Bit numbering q[4:0] corresponds to positions 5..1
// in the figure. XOR tap at position 3 (q[2]). Synchronous reset to 1.
// q <= {0 xor q[0], q[4], q[3] xor q[0], q[2], q[1]} with Galois
// form: shift toward MSB, feedback into LSB, XOR into tap.
// Fibonacci equivalent used here: q <= {q[3:0], q[4] ^ q[2]}.
//

module top_module (
    input            clk,
    input            reset,
    output reg [4:0] q
);
    always @(posedge clk) begin
        if (reset)
            q <= 5'h1;
        else
            q <= {q[0], q[4], q[3] ^ q[0], q[2], q[1]};
    end
endmodule
