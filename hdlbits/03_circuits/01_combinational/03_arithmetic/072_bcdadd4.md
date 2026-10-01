# 072. 4-digit BCD adder

**Section:** Circuits — Combinational Logic — Arithmetic Circuits  
**HDLBits:** [4-digit BCD adder](https://hdlbits.01xz.net/wiki/Bcdadd4)

## Problem

4-digit BCD adder from four `bcd_fadd` instances (HDLBits provides
that module). a and b are 16-bit BCD (4 digits). Produce 16-bit sum
and a carry-out.

## Notes

HDLBits provides `bcd_fadd`. Local helper: `helpers/bcd_fadd.v`.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`072_bcdadd4.v`](./072_bcdadd4.v).

```verilog
module top_module (
    input  [15:0] a, b,
    input         cin,
    output        cout,
    output [15:0] sum
);
    wire [3:0] c;
    bcd_fadd d0 (.a(a[3:0]),   .b(b[3:0]),   .cin(cin),  .cout(c[0]), .sum(sum[3:0]));
    bcd_fadd d1 (.a(a[7:4]),   .b(b[7:4]),   .cin(c[0]), .cout(c[1]), .sum(sum[7:4]));
    bcd_fadd d2 (.a(a[11:8]),  .b(b[11:8]),  .cin(c[1]), .cout(c[2]), .sum(sum[11:8]));
    bcd_fadd d3 (.a(a[15:12]), .b(b[15:12]), .cin(c[2]), .cout(c[3]), .sum(sum[15:12]));
    assign cout = c[3];
endmodule
```
