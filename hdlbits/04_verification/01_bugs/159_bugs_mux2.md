# 159. Mux

**Section:** Verification — Finding bugs in code  
**HDLBits:** [Mux](https://hdlbits.01xz.net/wiki/Bugs_mux2)

## Problem

Fix a 2:1 mux. The original bug is typically using `=` inside a
clocked block, or swapping the select, or declaring `out` as a
wire and assigning in always. Correct function: sel=0 -> a, sel=1 -> b.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`159_bugs_mux2.v`](./159_bugs_mux2.v).

```verilog
module top_module (
    input      sel,
    input  [7:0] a,
    input  [7:0] b,
    output [7:0] out
);
    assign out = sel ? b : a;
endmodule
```
