# 017. Vector reversal 1

**Section:** Verilog Language — Vectors  
**HDLBits:** [Vector reversal 1](https://hdlbits.01xz.net/wiki/Vectorr)

## Problem

Reverse the bit order of an 8-bit vector:
  out[7] = in[0], out[6] = in[1], ..., out[0] = in[7]

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`017_vectorr.v`](./017_vectorr.v).

```verilog
module top_module (
    input  [7:0] in,
    output [7:0] out
);
    assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};
endmodule
```
