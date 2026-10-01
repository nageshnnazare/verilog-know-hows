# 033. Case statement

**Section:** Verilog Language — Procedures  
**HDLBits:** [Case statement](https://hdlbits.01xz.net/wiki/Always_case)

## Problem

Build a 6-to-1 multiplexer. `sel` is 3 bits selecting among data0..data5.
For sel=0..5 output the corresponding data input; for sel=6 or 7
output 0. Use a case statement.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`033_always_case.v`](./033_always_case.v).

```verilog
module top_module (
    input  [2:0] sel,
    input  [3:0] data0,
    input  [3:0] data1,
    input  [3:0] data2,
    input  [3:0] data3,
    input  [3:0] data4,
    input  [3:0] data5,
    output reg [3:0] out
);
    always @(*) begin
        case (sel)
            3'd0: out = data0;
            3'd1: out = data1;
            3'd2: out = data2;
            3'd3: out = data3;
            3'd4: out = data4;
            3'd5: out = data5;
            default: out = 4'd0;
        endcase
    end
endmodule
```
