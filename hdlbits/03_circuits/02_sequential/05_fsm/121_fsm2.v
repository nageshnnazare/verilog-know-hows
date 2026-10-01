//==============================================================================
// HDLBits 121 — Simple FSM 2 (asynchronous reset)
// Official problem: https://hdlbits.01xz.net/wiki/Fsm2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Two-state Moore FSM. Reset (async) to OFF (out=0).
//   OFF: out=0; in=0 stay, in=1 go ON
//   ON : out=1; in=1 stay, in=0 go OFF
//

module top_module (
    input      clk,
    input      areset,
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
    always @(posedge clk or posedge areset) begin
        if (areset)
            state <= OFF;
        else
            state <= next;
    end
    assign out = (state == ON);
endmodule
