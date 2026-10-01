# 085. DFF with asynchronous reset

**Section:** Circuits — Sequential Logic — Latches and Flip-Flops  
**HDLBits:** [DFF with asynchronous reset](https://hdlbits.01xz.net/wiki/Dff8ar)

## Problem

8-bit register with active-high asynchronous reset to 0.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`085_dff8ar.v`](./085_dff8ar.v).

```verilog
module top_module (
    input            clk,
    input            areset,
    input      [7:0] d,
    output reg [7:0] q
);
    always @(posedge clk or posedge areset) begin
        if (areset)
            q <= 8'd0;
        else
            q <= d;
    end
endmodule
```
