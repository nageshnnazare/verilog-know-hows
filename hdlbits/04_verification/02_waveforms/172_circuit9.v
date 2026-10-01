//==============================================================================
// HDLBits 172 — Sequential circuit 9
// Official problem: https://hdlbits.01xz.net/wiki/Sim/circuit9
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// q[3:0] counts 0..5 (or similar) while a=0, and resets to 0 (or 4)
// when a=1. From the common waveform: when a=1, q=4; when a=0, q
// counts 4,5,0,1,2,3,4,... each clock.
//

module top_module (
    input            clk,
    input            a,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (a)
            q <= 4'd4;
        else if (q == 4'd6)
            q <= 4'd0;
        else
            q <= q + 4'd1;
    end
endmodule
