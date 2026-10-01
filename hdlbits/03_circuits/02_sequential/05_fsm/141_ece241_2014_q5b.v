//==============================================================================
// HDLBits 141 — Q5b: Serial two's complementer (Mealy FSM)
// Official problem: https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q5b
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Same two's complementer as a Mealy machine (output depends on x and state).
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
