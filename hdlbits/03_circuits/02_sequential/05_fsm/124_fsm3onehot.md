# 124. Simple one-hot state transitions 3

**Section:** Circuits — Sequential Logic — Finite State Machines  
**HDLBits:** [Simple one-hot state transitions 3](https://hdlbits.01xz.net/wiki/Fsm3onehot)

## Problem

Same 4-state FSM as fsm3comb, but state and next_state are one-hot
[3:0] = {D,C,B,A}. Derive next-state bits as Boolean equations
(no case on the whole state vector). out1 is Moore (state D),
out2 is Mealy (state C or D and in=1? HDLBits has out1, out2):
Standard: out1 = state[3] | state[2] & in? 
HDLBits fsm3onehot: only `out` which is 1 in D: out = state[3]
Wait, ports are: in, [3:0] state, [3:0] next_state, out
out = state[3]
next_state[0] = ~in & (state[0]|state[2]);
next_state[1] = in & (state[0]|state[1]|state[3]);
next_state[2] = ~in & (state[1]|state[3]);
next_state[3] = in & state[2];

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`124_fsm3onehot.v`](./124_fsm3onehot.v).

```verilog
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
```
