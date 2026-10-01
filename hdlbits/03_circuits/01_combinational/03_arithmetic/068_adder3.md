# 068. 3-bit binary adder

**Section:** Circuits — Combinational Logic — Arithmetic Circuits  
**HDLBits:** [3-bit binary adder](https://hdlbits.01xz.net/wiki/Adder3)

## Problem

3-bit ripple-carry adder. Inputs a[2:0], b[2:0], cin.
Outputs cout and sum[2:0]. You may instantiate full adders or add directly.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`068_adder3.v`](./068_adder3.v).

```verilog
module top_module (
    input  [2:0] a, b,
    input        cin,
    output [2:0] cout,
    output [2:0] sum
);
    full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin),     .cout(cout[0]), .sum(sum[0]));
    full_adder fa1 (.a(a[1]), .b(b[1]), .cin(cout[0]), .cout(cout[1]), .sum(sum[1]));
    full_adder fa2 (.a(a[2]), .b(b[2]), .cin(cout[1]), .cout(cout[2]), .sum(sum[2]));
endmodule

module full_adder (
    input  a, b, cin,
    output cout, sum
);
    assign {cout, sum} = a + b + cin;
endmodule
```
