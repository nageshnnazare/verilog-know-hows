# 018. Replication operator

**Section:** Verilog Language — Vectors  
**HDLBits:** [Replication operator](https://hdlbits.01xz.net/wiki/Vector4)

## Problem

Sign-extend an 8-bit number to 32 bits using the replication
operator: `{ {24{in[7]}}, in }`.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`018_vector4.v`](./018_vector4.v).

```verilog
module top_module (
    input  [7:0]  in,
    output [31:0] out
);
    assign out = {{24{in[7]}}, in};
endmodule
```
