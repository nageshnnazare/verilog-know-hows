# 034. Priority encoder

**Section:** Verilog Language — Procedures  
**HDLBits:** [Priority encoder](https://hdlbits.01xz.net/wiki/Always_case2)

## Problem

Build a 4-bit priority encoder: given `in[3:0]`, `pos` is the index
of the first (least-significant) 1-bit. If `in` is 0, `pos` is 0
(this version does not have a valid flag).

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`034_always_case2.v`](./034_always_case2.v).

```verilog
module top_module (
    input  [3:0] in,
    output reg [1:0] pos
);
    always @(*) begin
        casez (in)
            4'bzzz1: pos = 2'd0;
            4'bzz10: pos = 2'd1;
            4'bz100: pos = 2'd2;
            4'b1000: pos = 2'd3;
            default: pos = 2'd0;
        endcase
    end
endmodule
```
