# 012. Vectors in more detail

**Section:** Verilog Language — Vectors  
**HDLBits:** [Vectors in more detail](https://hdlbits.01xz.net/wiki/Vector1)

## Problem

Split a 16-bit input into a high byte `out_hi` (bits [15:8]) and
a low byte `out_lo` (bits [7:0]).

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`012_vector1.v`](./012_vector1.v).

```verilog
module top_module (
    input  wire [15:0] in,
    output wire [7:0]  out_hi,
    output wire [7:0]  out_lo
);
    assign out_hi = in[15:8];
    assign out_lo = in[7:0];
endmodule
```
