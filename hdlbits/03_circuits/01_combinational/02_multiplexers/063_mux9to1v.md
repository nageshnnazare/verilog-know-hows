# 063. 9-to-1 multiplexer

**Section:** Circuits — Combinational Logic — Multiplexers  
**HDLBits:** [9-to-1 multiplexer](https://hdlbits.01xz.net/wiki/Mux9to1v)

## Problem

16-bit 9:1 mux. `sel` is 4 bits choosing a[15:0] through i[15:0]
for sel=0..8. For sel=9..15 output 16'hffff.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`063_mux9to1v.v`](./063_mux9to1v.v).

```verilog
module top_module (
    input  [15:0] a, b, c, d, e, f, g, h, i,
    input  [3:0]  sel,
    output reg [15:0] out
);
    always @(*) begin
        case (sel)
            4'd0: out = a;
            4'd1: out = b;
            4'd2: out = c;
            4'd3: out = d;
            4'd4: out = e;
            4'd5: out = f;
            4'd6: out = g;
            4'd7: out = h;
            4'd8: out = i;
            default: out = 16'hffff;
        endcase
    end
endmodule
```
