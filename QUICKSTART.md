# Quick Start Guide

This guide will help you get started with the Verilog tutorial immediately.

## Installation (macOS)

```bash
# Install Icarus Verilog (simulator)
brew install icarus-verilog

# Install GTKWave (waveform viewer)
brew install gtkwave

# Verify installation
iverilog -v
```

## Your First Verilog Program

### Step 1: Create a simple AND gate

Create a file `and_gate.v`:

```verilog
module and_gate (
    input  wire a,
    input  wire b,
    output wire y
);
    assign y = a & b;
endmodule
```

### Step 2: Create a testbench

Create a file `and_gate_tb.v`:

```verilog
`timescale 1ns/1ps

module and_gate_tb;
    reg a, b;
    wire y;
    
    and_gate dut (.a(a), .b(b), .y(y));
    
    initial begin
        $display("a b y");
        a = 0; b = 0; #10 $display("%b %b %b", a, b, y);
        a = 0; b = 1; #10 $display("%b %b %b", a, b, y);
        a = 1; b = 0; #10 $display("%b %b %b", a, b, y);
        a = 1; b = 1; #10 $display("%b %b %b", a, b, y);
        $finish;
    end
endmodule
```

### Step 3: Compile and run

```bash
# Compile
iverilog -o and_gate.vvp and_gate.v and_gate_tb.v

# Run simulation
vvp and_gate.vvp
```

**Expected output:**
```
a b y
0 0 0
0 1 0
1 0 0
1 1 1
```

## Next Steps

1. **Start the tutorial**: Begin with [Part 1: Introduction](./01_Introduction.md)
2. **Try examples**: Check out the [examples/](./examples/) directory
3. **View waveforms**: Add `$dumpfile` and `$dumpvars` to see timing diagrams in GTKWave

## Tutorial Structure

- **Part 1**: Introduction and basics → Start here!
- **Part 2**: Data types and operators
- **Part 3**: Combinational logic
- **Part 4**: Sequential logic and timing ⭐ Most important!
- **Part 5**: Finite State Machines
- **Part 6**: Testbenches and simulation
- **Part 7**: Advanced topics and best practices

## Quick Reference

### Common Syntax

```verilog
// Combinational logic
assign out = a & b;

// Sequential logic (flip-flop)
always @(posedge clk) begin
    q <= d;  // Use <= for sequential
end

// Combinational always block
always @(*) begin
    result = a + b;  // Use = for combinational
end
```

### Basic Structure

```verilog
module my_module (
    input  wire clk,
    input  wire [7:0] data_in,
    output reg  [7:0] data_out
);
    // Your logic here
endmodule
```

## Getting Help

- Read the detailed tutorials for in-depth explanations
- Check the examples for working code
- Look at timing diagrams to understand behavior
- Try the exercises at the end of each part

## Common First-Time Mistakes

❌ Using `=` in clocked always blocks → Use `<=`
❌ Forgetting `endmodule` → Always close your module
❌ Missing `;` at end of statements → Add semicolons
❌ Creating latches accidentally → Always assign in all cases

---

**You're ready to start! Open [Part 1](./01_Introduction.md) and begin your Verilog journey!** 🚀

