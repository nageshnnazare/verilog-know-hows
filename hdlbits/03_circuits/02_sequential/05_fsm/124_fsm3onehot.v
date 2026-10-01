//==============================================================================
// HDLBits 124 — Simple one-hot state transitions 3
// Official problem: https://hdlbits.01xz.net/wiki/Fsm3onehot
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Same 4-state FSM as fsm3comb, but state and next_state are one-hot
// [3:0] = {D,C,B,A}. Derive next-state bits as Boolean equations
// (no case on the whole state vector). out1 is Moore (state D),
// out2 is Mealy (state C or D and in=1? HDLBits has out1, out2):
// Standard: out1 = state[3] | state[2] & in? 
// HDLBits fsm3onehot: only `out` which is 1 in D: out = state[3]
// Wait, ports are: in, [3:0] state, [3:0] next_state, out
// out = state[3]
// next_state[0] = ~in & (state[0]|state[2]);
// next_state[1] = in & (state[0]|state[1]|state[3]);
// next_state[2] = ~in & (state[1]|state[3]);
// next_state[3] = in & state[2];
//

module top_module (
    input        in,
    input  [3:0] state,
    output [3:0] next_state,
    output       out
);
    assign next_state[0] = ~in & (state[0] | state[2]);
    assign next_state[1] =  in & (state[0] | state[1] | state[3]);
    assign next_state[2] = ~in & (state[1] | state[3]);
    assign next_state[3] =  in &  state[2];
    assign out = state[3];
endmodule
