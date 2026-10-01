//==============================================================================
// HDLBits 123 — Simple state transitions 3
// Official problem: https://hdlbits.01xz.net/wiki/Fsm3comb
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Combinational next-state and output logic for a 4-state FSM
// (A=00,B=01,C=10,D=11):
//   A --1--> B --1--> B
//   A --0--> A
//   B --0--> C --0--> A
//   C --1--> D --1--> B
//   D --0--> C
// Moore output is 1 only in D.
//

module top_module (
    input        in,
    input  [1:0] state,
    output reg [1:0] next_state,
    output       out
);
    parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;
    always @(*) begin
        case (state)
            A: next_state = in ? B : A;
            B: next_state = in ? B : C;
            C: next_state = in ? D : A;
            D: next_state = in ? B : C;
            default: next_state = A;
        endcase
    end
    assign out = (state == D);
endmodule
