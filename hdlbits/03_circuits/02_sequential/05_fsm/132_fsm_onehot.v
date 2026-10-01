//==============================================================================
// HDLBits 132 — One-hot FSM
// Official problem: https://hdlbits.01xz.net/wiki/Fsm_onehot
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 10-state one-hot FSM (`state[9:0]`). Write each `next_state` bit as a
// Boolean equation from the official diagram (no case on the whole
// vector). Moore outputs:
//   out1 = state[8] | state[9]
//   out2 = state[7] | state[9]
//

module top_module (
    input        in,
    input  [9:0] state,
    output [9:0] next_state,
    output       out1,
    output       out2
);
    assign next_state[0] = ~in & (state[0]|state[1]|state[2]|state[3]|state[4]|state[7]|state[8]|state[9]);
    assign next_state[1] =  in &  state[0];
    assign next_state[2] =  in &  state[1];
    assign next_state[3] =  in &  state[2];
    assign next_state[4] =  in &  state[3];
    assign next_state[5] =  in &  state[4];
    assign next_state[6] =  in &  state[5];
    assign next_state[7] =  in & (state[6] | state[7]);
    assign next_state[8] = ~in &  state[5];
    assign next_state[9] = ~in & (state[6] | state[8]);
    assign out1 = state[8] | state[9];
    assign out2 = state[7] | state[9];
endmodule
