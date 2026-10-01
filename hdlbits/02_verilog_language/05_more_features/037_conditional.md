# 037. Conditional ternary operator

**Section:** Verilog Language — More Verilog Features  
**HDLBits:** [Conditional ternary operator](https://hdlbits.01xz.net/wiki/Conditional)

## Problem

Given four unsigned 8-bit values a,b,c,d, find the minimum using
nested ternary operators. Output `min`.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`037_conditional.v`](./037_conditional.v).

```verilog
module top_module (
    input  [7:0] a, b, c, d,
    output [7:0] min
);
    wire [7:0] min_ab  = (a < b) ? a : b;
    wire [7:0] min_cd  = (c < d) ? c : d;
    assign min = (min_ab < min_cd) ? min_ab : min_cd;
endmodule
```
