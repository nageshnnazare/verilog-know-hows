//==============================================================================
// HDLBits 126 — Simple FSM 3 (synchronous reset)
// Official problem: https://hdlbits.01xz.net/wiki/Fsm3s
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Same 4-state FSM with synchronous reset to A.
//

module top_module (
    input        clk,
    input        in,
    input        reset,
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
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next;
    end
    assign out = (state == D);
endmodule
