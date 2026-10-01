//==============================================================================
// HDLBits 122 — Simple FSM 2 (synchronous reset)
// Official problem: https://hdlbits.01xz.net/wiki/Fsm2s
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Same as fsm2 with synchronous reset. Ports are clk, reset, j, k, out.
//

module top_module (
    input      clk,
    input      reset,
    input      j,
    input      k,
    output     out
);
    parameter OFF = 1'b0, ON = 1'b1;
    reg state, next;
    always @(*) begin
        case (state)
            OFF: next = j ? ON  : OFF;
            ON : next = k ? OFF : ON;
        endcase
    end
    always @(posedge clk) begin
        if (reset)
            state <= OFF;
        else
            state <= next;
    end
    assign out = (state == ON);
endmodule
