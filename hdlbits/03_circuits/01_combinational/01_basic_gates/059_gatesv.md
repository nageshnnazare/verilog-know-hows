# 059. Gates and vectors

**Section:** Circuits — Combinational Logic — Basic Gates  
**HDLBits:** [Gates and vectors](https://hdlbits.01xz.net/wiki/Gatesv)

## Problem

For 4-bit `in[3:0]`:
  out_both[2:0]      = in[2:0] & in[3:1]   (each bit AND neighbour)
  out_any[3:1]       = in[3:1] | in[2:0]
  out_different[3:0] = in ^ {in[0], in[3:1]}
(out_different[3] compares in[3] with in[0], wrapping around.)

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`059_gatesv.v`](./059_gatesv.v).

```verilog
module top_module (
    input  [3:0] in,
    output [2:0] out_both,
    output [3:1] out_any,
    output [3:0] out_different
);
    assign out_both      = in[2:0] & in[3:1];
    assign out_any       = in[3:1] | in[2:0];
    assign out_different = in ^ {in[0], in[3:1]};
endmodule
```
