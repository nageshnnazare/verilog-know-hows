//==============================================================================
// HDLBits 041 — Combinational for-loop: 255-bit population count
// Official problem: https://hdlbits.01xz.net/wiki/Popcount255
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Count the number of 1s in a 255-bit vector. Output is 8 bits
// (`out[7:0]`). A for-loop adding each bit is acceptable.
//

module top_module (
    input  [254:0] in,
    output reg [7:0] out
);
    integer i;
    always @(*) begin
        out = 8'd0;
        for (i = 0; i < 255; i = i + 1)
            out = out + in[i];
    end
endmodule
