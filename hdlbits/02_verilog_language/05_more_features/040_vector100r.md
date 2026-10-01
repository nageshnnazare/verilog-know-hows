# 040. Combinational for-loop: Vector reversal 2

**Section:** Verilog Language — More Verilog Features  
**HDLBits:** [Combinational for-loop: Vector reversal 2](https://hdlbits.01xz.net/wiki/Vector100r)

## Problem

Reverse a 100-bit vector using a combinational for-loop inside an
always block (or generate). out[i] = in[99-i].

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`040_vector100r.v`](./040_vector100r.v).

```verilog
module top_module (
    input  [99:0] in,
    output reg [99:0] out
);
    integer i;
    always @(*) begin
        for (i = 0; i < 100; i = i + 1)
            out[i] = in[99 - i];
    end
endmodule
```
