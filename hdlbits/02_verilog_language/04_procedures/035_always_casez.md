# 035. Priority encoder with casez

**Section:** Verilog Language — Procedures  
**HDLBits:** [Priority encoder with casez](https://hdlbits.01xz.net/wiki/Always_casez)

## Problem

Build an 8-bit priority encoder using `casez`. Output `pos[2:0]` is
the index of the least-significant 1 in `in[7:0]`. If none are 1,
output 0.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`035_always_casez.v`](./035_always_casez.v).

```verilog
module top_module (
    input  [7:0] in,
    output reg [2:0] pos
);
    always @(*) begin
        casez (in)
            8'bzzzzzzz1: pos = 3'd0;
            8'bzzzzzz10: pos = 3'd1;
            8'bzzzzz100: pos = 3'd2;
            8'bzzzz1000: pos = 3'd3;
            8'bzzz10000: pos = 3'd4;
            8'bzz100000: pos = 3'd5;
            8'bz1000000: pos = 3'd6;
            8'b10000000: pos = 3'd7;
            default:     pos = 3'd0;
        endcase
    end
endmodule
```
