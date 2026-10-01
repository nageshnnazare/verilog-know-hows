//==============================================================================
// HDLBits 140 — Q5a: Serial two's complementer (Moore FSM)
// Official problem: https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q5a
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Convert a serial bitstream to its two's complement, LSB first.
// Moore machine: pass bits unchanged until the first 1, then invert
// all subsequent bits. Synchronous reset starts a new number.
//

module top_module (
    input      clk,
    input      areset,
    input      x,
    output     z
);
    parameter A=0, B=1;
    reg state;
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else if (state == A && x)
            state <= B;
    end
    assign z = (state == A) ? x : ~x;
endmodule
