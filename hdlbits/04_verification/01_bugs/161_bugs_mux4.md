# 161. Mux

**Section:** Verification — Finding bugs in code  
**HDLBits:** [Mux](https://hdlbits.01xz.net/wiki/Bugs_mux4)

## Problem

Fix a 4:1 mux built from 2:1 muxes. Inputs a,b,c,d, sel[1:0], out.
sel=0..3 chooses a,b,c,d. The usual bug is wiring the two-level mux
incorrectly (swap sel bits, or wrong intermediate).

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`161_bugs_mux4.v`](./161_bugs_mux4.v).

```verilog
module top_module (
    input  [1:0] sel,
    input  [7:0] a, b, c, d,
    output [7:0] out
);
    assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);
endmodule
```
