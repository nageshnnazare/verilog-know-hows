//==============================================================================
// HDLBits 175 — Testbench1
// Official problem: https://hdlbits.01xz.net/wiki/Tb/tb1
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Pulse `in` : 0 for 10 units, 1 for 10 units, then $finish.
// DUT ports: in, out. Create the stimulus only (plus a stub DUT here).
//

`timescale 1ns/1ps
module top_module;
    reg  in;
    wire out;
    dut dut (.in(in), .out(out));
    initial begin
        in = 1'b0;
        #10 in = 1'b1;
        #10 $finish;
    end
endmodule

module dut (input in, output out);
    assign out = in;
endmodule
