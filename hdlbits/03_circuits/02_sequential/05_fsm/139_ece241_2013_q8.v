//==============================================================================
// HDLBits 139 — Q8: Design a Mealy FSM
// Official problem: https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q8
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Mealy FSM that detects overlapping sequence 101. Asynchronous reset.
// `z` is 1 in the cycle when the third bit of 101 arrives.
//

module top_module (
    input      clk,
    input      aresetn,
    input      x,
    output     z
);
    parameter S0=0, S1=1, S2=2;
    reg [1:0] state, next;
    always @(*) begin
        case (state)
            S0: next = x ? S1 : S0;
            S1: next = x ? S1 : S2;
            S2: next = x ? S1 : S0;
            default: next = S0;
        endcase
    end
    always @(posedge clk or negedge aresetn) begin
        if (!aresetn)
            state <= S0;
        else
            state <= next;
    end
    assign z = (state == S2) && x;
endmodule
