# 015. Four-input gates

**Section:** Verilog Language — Vectors  
**HDLBits:** [Four-input gates](https://hdlbits.01xz.net/wiki/Gates4)

## Problem

Build 4-input AND, OR, and XOR gates on vector `in[3:0]`.
Reduction operators (`&in`, `|in`, `^in`) are the natural fit.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`015_gates4.v`](./015_gates4.v).

```verilog
module top_module (
    input  [3:0] in,
    output       out_and,
    output       out_or,
    output       out_xor
);
    assign out_and = &in;
    assign out_or  = |in;
    assign out_xor = ^in;
endmodule
```
