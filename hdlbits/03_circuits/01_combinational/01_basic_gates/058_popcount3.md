# 058. 3-bit population count

**Section:** Circuits — Combinational Logic — Basic Gates  
**HDLBits:** [3-bit population count](https://hdlbits.01xz.net/wiki/Popcount3)

## Problem

Count the number of 1s in `in[2:0]`. Output is 2 bits (0..3).

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`058_popcount3.v`](./058_popcount3.v).

```verilog
module top_module (
    input  [2:0] in,
    output [1:0] out
);
    assign out = in[0] + in[1] + in[2];
endmodule
```
