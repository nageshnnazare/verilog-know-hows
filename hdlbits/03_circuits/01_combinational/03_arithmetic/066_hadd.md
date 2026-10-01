# 066. Half adder

**Section:** Circuits — Combinational Logic — Arithmetic Circuits  
**HDLBits:** [Half adder](https://hdlbits.01xz.net/wiki/Hadd)

## Problem

Half adder: {cout, sum} = a + b.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`066_hadd.v`](./066_hadd.v).

```verilog
module top_module (
    input  a, b,
    output cout, sum
);
    assign {cout, sum} = a + b;
endmodule
```
