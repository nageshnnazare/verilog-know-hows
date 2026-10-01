//==============================================================================
// HDLBits 119 — Simple FSM 1 (asynchronous reset)
// Official problem: https://hdlbits.01xz.net/wiki/Fsm1
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Two-state Moore FSM. States A (out=0) and B (out=1). Asynchronous
// reset to B. Input `in`: if 1 stay; if 0 go to the other state.
//

module top_module (
    input      clk,
    input      areset,
    input      in,
    output     out
);
    parameter A = 1'b0, B = 1'b1;
    reg state, next;
    always @(*) begin
        case (state)
            A: next = in ? A : B;
            B: next = in ? B : A;
        endcase
    end
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= B;
        else
            state <= next;
    end
    assign out = (state == B);
endmodule
