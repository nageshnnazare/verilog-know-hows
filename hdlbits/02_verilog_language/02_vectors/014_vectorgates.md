# 014. Bitwise operators

**Section:** Verilog Language — Vectors  
**HDLBits:** [Bitwise operators](https://hdlbits.01xz.net/wiki/Vectorgates)

## Problem

Given 3-bit vectors `a` and `b`:
  out_or_bitwise = a | b          (bitwise OR)
  out_or_logical = a || b         (logical OR, 1-bit)
  out_not        = {~b, ~a}       (concatenation of inversions, 6 bits)

## Figures (from HDLBits)

Copied from the official HDLBits problem page for this tutorial.

![Figure 1](./014_vectorgates_fig1.png)

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`014_vectorgates.v`](./014_vectorgates.v).

```verilog
module top_module (
    input  [2:0] a,
    input  [2:0] b,
    output [2:0] out_or_bitwise,
    output       out_or_logical,
    output [5:0] out_not
);
    assign out_or_bitwise = a | b;
    assign out_or_logical = a || b;
    assign out_not        = {~b, ~a};
endmodule
```
