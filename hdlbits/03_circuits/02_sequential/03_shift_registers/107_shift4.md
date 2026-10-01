# 107. 4-bit shift register

**Section:** Circuits — Sequential Logic — Shift Registers  
**HDLBits:** [4-bit shift register](https://hdlbits.01xz.net/wiki/Shift4)

## Problem

4-bit shift register, shifts toward MSB (q[3] is the last bit out):
  areset (async) to 0
  load: parallel load data[3:0]
  ena: shift in `in` at LSB (q <= {q[2:0], in})
Load has priority over ena.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`107_shift4.v`](./107_shift4.v).

```verilog
module top_module (
    input            clk,
    input            areset,
    input            load,
    input            ena,
    input      [3:0] data,
    output reg [3:0] q
);
    always @(posedge clk or posedge areset) begin
        if (areset)
            q <= 4'd0;
        else if (load)
            q <= data;
        else if (ena)
            q <= {1'b0, q[3:1]};
    end
endmodule
```
