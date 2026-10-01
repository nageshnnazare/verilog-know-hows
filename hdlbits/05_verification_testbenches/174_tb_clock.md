# 174. Clock

**Section:** Verification — Writing Testbenches  
**HDLBits:** [Clock](https://hdlbits.01xz.net/wiki/Tb/clock)

## Problem

Write a testbench that generates a clock (`clk`) with period 10
time units (toggle every 5). The DUT is already instantiated as
`dut` with port clk. (On HDLBits you only write the stimulus.)
This file is a self-contained example that also includes a stub DUT.

## Figures (from HDLBits)

Copied from the official HDLBits problem page for this tutorial.

![Waveform 1](./174_tb_clock_wave1.svg)

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`174_tb_clock.v`](./174_tb_clock.v).

```verilog
`timescale 1ns/1ps
module top_module;
    reg clk;
    dut dut (.clk(clk));
    initial clk = 0;
    always #5 clk = ~clk;
endmodule

// Stub DUT for local simulation (HDLBits already has the DUT).
module dut (input clk);
endmodule
```
