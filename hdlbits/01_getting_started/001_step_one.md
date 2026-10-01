# 001. Getting Started (Step one)

**Section:** Getting Started  
**HDLBits:** [Getting Started (Step one)](https://hdlbits.01xz.net/wiki/Step_one)

## Problem

Build a circuit with no inputs and one output named `one`.
The output must always drive logic 1 (high).

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`001_step_one.v`](./001_step_one.v).

```verilog
module top_module (
    output one
);
    assign one = 1'b1;
endmodule
```
