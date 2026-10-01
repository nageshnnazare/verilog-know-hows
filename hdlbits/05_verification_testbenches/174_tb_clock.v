//==============================================================================
// HDLBits 174 — Clock
// Official problem: https://hdlbits.01xz.net/wiki/Tb/clock
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Write a testbench that generates a clock (`clk`) with period 10
// time units (toggle every 5). The DUT is already instantiated as
// `dut` with port clk. (On HDLBits you only write the stimulus.)
// This file is a self-contained example that also includes a stub DUT.
//

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
