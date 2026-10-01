# 013. Vector part select

**Section:** Verilog Language — Vectors  
**HDLBits:** [Vector part select](https://hdlbits.01xz.net/wiki/Vector2)

## Problem

Reverse the four bytes of a 32-bit word:
  out[31:24] = in[7:0]
  out[23:16] = in[15:8]
  out[15:8]  = in[23:16]
  out[7:0]   = in[31:24]

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`013_vector2.v`](./013_vector2.v).

```verilog
module top_module (
    input  [31:0] in,
    output [31:0] out
);
    assign out[31:24] = in[7:0];
    assign out[23:16] = in[15:8];
    assign out[15:8]  = in[23:16];
    assign out[7:0]   = in[31:24];
endmodule
```
