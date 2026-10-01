# 002. Output Zero

**Section:** Getting Started  
**HDLBits:** [Output Zero](https://hdlbits.01xz.net/wiki/Zero)

## Problem

Build a circuit with no inputs and one output named `zero`.
The output must always drive logic 0 (low).

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`002_zero.v`](./002_zero.v).

```verilog
module top_module (
    output zero
);
    assign zero = 1'b0;
endmodule
```
