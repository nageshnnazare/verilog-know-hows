//==============================================================================
// HDLBits 151 — Q2b: Another FSM
// Official problem: https://hdlbits.01xz.net/wiki/Exams/2013_q2bfsm
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 2013 Q2b: FSM with inputs r1,r2,r3 (requests) and outputs g1,g2,g3
// (grants). A simple arbiter: A is idle. Grant the lowest-numbered
// requester and hold the grant until that r deasserts. Sync resetn.
//

module top_module (
    input      clk,
    input      resetn,
    input      x,
    input      y,
    output     f,
    output     g
);
    parameter A=0, F1=1, F0=2, G1=3, G1Y=4, G0=5, GPERM=6;
    reg [2:0] state, next;
    always @(*) begin
        case (state)
            A:     next = F1;
            F1:    next = F0;
            F0:    next = x ? G1 : F0;
            G1:    next = x ? G1 : G1Y;
            G1Y:   next = x ? G1 : G0;
            G0:    next = y ? GPERM : (x ? G1 : G0);
            GPERM: next = GPERM;
            default: next = A;
        endcase
    end
    always @(posedge clk) begin
        if (!resetn)
            state <= A;
        else
            state <= next;
    end
    assign f = (state == F1);
    assign g = (state == G1) || (state == G1Y) || (state == GPERM);
endmodule
