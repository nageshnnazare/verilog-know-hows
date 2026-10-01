//==============================================================================
// HDLBits 125 — Simple FSM 3 (asynchronous reset)
// Official problem: https://hdlbits.01xz.net/wiki/Fsm3
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// The full 4-state FSM of fsm3comb, with asynchronous reset to A.
//

module top_module (
    input        clk,
    input        in,
    input        areset,
    output       out
);
    parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;
    reg [1:0] state, next;
    always @(*) begin
        case (state)
            A: next = in ? B : A;
            B: next = in ? B : C;
            C: next = in ? D : A;
            D: next = in ? B : C;
            default: next = A;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= A;
        else
            state <= next;
    end
    assign out = (state == D);
endmodule
