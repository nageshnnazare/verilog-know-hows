# 062. 2-to-1 bus multiplexer

**Section:** Circuits — Combinational Logic — Multiplexers  
**HDLBits:** [2-to-1 bus multiplexer](https://hdlbits.01xz.net/wiki/Mux2to1v)

## Problem

100-bit 2:1 mux. `sel=0` chooses `a[99:0]`, else `b`.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`062_mux2to1v.v`](./062_mux2to1v.v).

```verilog
module top_module (
    input  [99:0] a, b,
    input         sel,
    output [99:0] out
);
    assign out = sel ? b : a;
endmodule
```
