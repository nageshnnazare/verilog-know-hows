# 162. Add/sub

**Section:** Verification — Finding bugs in code  
**HDLBits:** [Add/sub](https://hdlbits.01xz.net/wiki/Bugs_addsubz)

## Problem

8-bit add/subtract with zero flag. `do_sub`=0 add, =1 subtract.
`result` is the sum/difference, `zero` is 1 when result is 0.
Typical bug: `zero` is assigned with blocking/wrong timing, or
subtract uses + instead of -, or zero checks the operands.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`162_bugs_addsubz.v`](./162_bugs_addsubz.v).

```verilog
module top_module (
    input            do_sub,
    input      [7:0] a,
    input      [7:0] b,
    output reg [7:0] out,
    output           result_is_zero
);
    always @(*) begin
        case (do_sub)
            0: out = a + b;
            1: out = a - b;
        endcase
    end
    assign result_is_zero = (out == 8'd0);
endmodule
```
