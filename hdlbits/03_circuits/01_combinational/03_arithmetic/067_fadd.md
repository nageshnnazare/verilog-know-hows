# 067. Full adder

**Section:** Circuits — Combinational Logic — Arithmetic Circuits  
**HDLBits:** [Full adder](https://hdlbits.01xz.net/wiki/Fadd)

## Problem

Full adder: {cout, sum} = a + b + cin.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`067_fadd.v`](./067_fadd.v).

```verilog
module top_module (
    input  a, b, cin,
    output cout, sum
);
    assign {cout, sum} = a + b + cin;
endmodule
```
