# 038. Reduction operators

**Section:** Verilog Language — More Verilog Features  
**HDLBits:** [Reduction operators](https://hdlbits.01xz.net/wiki/Reduction)

## Problem

Compute even parity of an 8-bit value: `parity = ^in` (XOR reduction).
Output 1 when there is an odd number of 1s.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`038_reduction.v`](./038_reduction.v).

```verilog
module top_module (
    input  [7:0] in,
    output       parity
);
    assign parity = ^in;
endmodule
```
