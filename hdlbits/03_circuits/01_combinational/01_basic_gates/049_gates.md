# 049. More logic gates

**Section:** Circuits — Combinational Logic — Basic Gates  
**HDLBits:** [More logic gates](https://hdlbits.01xz.net/wiki/Gates)

## Problem

Given `a` and `b`, produce all of:
  out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb
where `out_anotb` is a AND NOT b.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`049_gates.v`](./049_gates.v).

```verilog
module top_module (
    input  a, b,
    output out_and,
    output out_or,
    output out_xor,
    output out_nand,
    output out_nor,
    output out_xnor,
    output out_anotb
);
    assign out_and  = a & b;
    assign out_or   = a | b;
    assign out_xor  = a ^ b;
    assign out_nand = ~(a & b);
    assign out_nor  = ~(a | b);
    assign out_xnor = ~(a ^ b);
    assign out_anotb = a & ~b;
endmodule
```
