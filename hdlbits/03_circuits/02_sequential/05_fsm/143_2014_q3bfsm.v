//==============================================================================
// HDLBits 143 — Q3b: FSM
// Official problem: https://hdlbits.01xz.net/wiki/Exams/2014_q3bfsm
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Related exam FSM: when `x` is 1 for three consecutive cycles, assert
// `z` until `x` becomes 0. Synchronous reset.
// (A common 2014 Q3b interpretation: a 3-cycle high detector with
// hysteresis.) The official figure is a small FSM with states 00,01,10
// and output f. Ports: clk, reset, x, z.
//

module top_module (
    input      clk,
    input      reset,
    input      x,
    output     z
);
    parameter S0=0, S1=1, S2=2, S3=3;
    reg [1:0] state, next;
    always @(*) begin
        case (state)
            S0: next = x ? S1 : S0;
            S1: next = x ? S2 : S0;
            S2: next = x ? S3 : S0;
            S3: next = x ? S3 : S0;
            default: next = S0;
        endcase
    end
    always @(posedge clk) begin
        if (reset)
            state <= S0;
        else
            state <= next;
    end
    assign z = (state == S3);
endmodule
