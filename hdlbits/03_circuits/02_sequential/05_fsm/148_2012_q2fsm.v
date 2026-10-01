//==============================================================================
// HDLBits 148 — Q2a: FSM
// Official problem: https://hdlbits.01xz.net/wiki/Exams/2012_q2fsm
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 2012 Q2 FSM. Asynchronous reset to state A. Inputs w, outputs z? 
// Ports: clk, reset, w, z. Similar six-state machine; reset is
// asynchronous in this version.
//

module top_module (
    input      clk,
    input      reset,
    input      w,
    output     z
);
    parameter A=0, B=1, C=2, D=3, E=4, F=5;
    reg [2:0] state, next;
    always @(*) begin
        case (state)
            A: next = w ? B : A;
            B: next = w ? C : D;
            C: next = w ? E : D;
            D: next = w ? F : A;
            E: next = w ? E : D;
            F: next = w ? C : D;
            default: next = A;
        endcase
    end
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next;
    end
    assign z = (state == E) || (state == F);
endmodule
