# 041. Combinational for-loop: 255-bit population count

**Section:** Verilog Language — More Verilog Features  
**HDLBits:** [Combinational for-loop: 255-bit population count](https://hdlbits.01xz.net/wiki/Popcount255)

## Problem

Count the number of 1s in a 255-bit vector. Output is 8 bits
(`out[7:0]`). A for-loop adding each bit is acceptable.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`041_popcount255.v`](./041_popcount255.v).

```verilog
module top_module (
    input  [254:0] in,
    output reg [7:0] out
);
    integer i;
    always @(*) begin
        out = 8'd0;
        for (i = 0; i < 255; i = i + 1)
            out = out + in[i];
    end
endmodule
```
