# 160. NAND

**Section:** Verification — Finding bugs in code  
**HDLBits:** [NAND](https://hdlbits.01xz.net/wiki/Bugs_nand3)

## Problem

Fix a 3-input NAND. The bug is usually AND instead of NAND, or a 2-input gate.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`160_bugs_nand3.v`](./160_bugs_nand3.v).

```verilog
module top_module (
    input  a, b, c,
    output out
);
    assign out = ~(a & b & c);
endmodule
```
