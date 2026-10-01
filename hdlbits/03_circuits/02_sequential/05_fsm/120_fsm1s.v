//==============================================================================
// HDLBits 120 — Simple FSM 1 (synchronous reset)
// Official problem: https://hdlbits.01xz.net/wiki/Fsm1s
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Same as fsm1 but the reset is synchronous (and named `reset`).
//

module top_module (
    input      clk,
    input      reset,
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
    always @(posedge clk) begin
        if (reset)
            state <= B;
        else
            state <= next;
    end
    assign out = (state == B);
endmodule
