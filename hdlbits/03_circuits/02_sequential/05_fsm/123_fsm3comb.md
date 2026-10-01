# 123. Simple state transitions 3

**Section:** Circuits — Sequential Logic — Finite State Machines  
**HDLBits:** [Simple state transitions 3](https://hdlbits.01xz.net/wiki/Fsm3comb)

## Problem

Combinational next-state and output logic for a 4-state FSM
(A=00,B=01,C=10,D=11):
  A --1--> B --1--> B
  A --0--> A
  B --0--> C --0--> A
  C --1--> D --1--> B
  D --0--> C
Moore output is 1 only in D.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`123_fsm3comb.v`](./123_fsm3comb.v).

```verilog
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
```
