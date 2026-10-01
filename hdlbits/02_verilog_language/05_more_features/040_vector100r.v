//==============================================================================
// HDLBits 040 — Combinational for-loop: Vector reversal 2
// Official problem: https://hdlbits.01xz.net/wiki/Vector100r
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Reverse a 100-bit vector using a combinational for-loop inside an
// always block (or generate). out[i] = in[99-i].
//

module top_module (
    input  [99:0] in,
    output reg [99:0] out
);
    integer i;
    always @(*) begin
        for (i = 0; i < 100; i = i + 1)
            out[i] = in[99 - i];
    end
endmodule
