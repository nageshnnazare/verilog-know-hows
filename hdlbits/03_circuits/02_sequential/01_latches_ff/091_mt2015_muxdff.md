# 091. Mux and DFF

**Section:** Circuits — Sequential Logic — Latches and Flip-Flops  
**HDLBits:** [Mux and DFF](https://hdlbits.01xz.net/wiki/Mt2015_muxdff)

## Problem

2:1 mux in front of a DFF. When L=1, load `d`; when L=0, load `w`
(or the other way: L selects d vs feedback). HDLBits: L=1 chooses r
(or d), L=0 chooses E ? w : q. This simpler problem is:
  next = L ? r : w;  q <= next
Ports: clk, L, q_in, r_in, Q? Standard ports:
  clk, w, R, E, L  — that's 2014_q4a.
This problem (mt2015_muxdff) ports: clk, L, q_in, d_in, Q
  Q <= L ? d_in : q_in

## Figures (from HDLBits)

Copied from the official HDLBits problem page for this tutorial.

![Figure 1](./091_mt2015_muxdff_fig1.png)

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`091_mt2015_muxdff.v`](./091_mt2015_muxdff.v).

```verilog
module top_module (
    input      clk,
    input      L,
    input      q_in,
    input      r_in,
    output reg Q
);
    always @(posedge clk)
        Q <= L ? r_in : q_in;
endmodule
```
