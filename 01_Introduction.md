# Part 1: Introduction to Verilog

## What is Verilog?

Verilog is a **Hardware Description Language (HDL)** used to model and design digital circuits. Unlike traditional programming languages that describe sequential operations, Verilog describes the **structure and behavior of electronic systems**.

### Key Differences: Software vs Hardware

| Software (C/Python) | Hardware (Verilog) |
|---------------------|-------------------|
| Sequential execution | Concurrent execution |
| Variables store values | Wires carry signals |
| Procedural thinking | Structural thinking |
| Time = CPU cycles | Time = clock cycles |
| Single execution flow | Multiple parallel paths |

## Why Learn Verilog?

1. **FPGA Programming**: Program reconfigurable hardware
2. **ASIC Design**: Create custom chips
3. **Hardware Verification**: Test digital designs
4. **Digital System Design**: Build processors, controllers, interfaces
5. **Career Opportunities**: High demand in semiconductor industry

## Design Flow

```
┌─────────────────┐
│  Specification  │  (What should it do?)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│  Verilog Code   │  (Describe the hardware)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Simulation    │  (Does it work correctly?)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│   Synthesis     │  (Convert to gates)
└────────┬────────┘
         │
         ▼
┌─────────────────┐
│ Implementation  │  (Place on chip/FPGA)
└─────────────────┘
```

## Basic Module Structure

A **module** is the fundamental building block in Verilog. Think of it as a component or IC chip.

```verilog
module module_name (
    input  wire signal_in,   // Input port
    output wire signal_out   // Output port
);

    // Module body (logic goes here)
    
endmodule
```

### Anatomy of a Module

1. **Module declaration**: `module module_name`
2. **Port list**: Inputs and outputs in parentheses
3. **Module body**: The actual logic/structure
4. **End declaration**: `endmodule`

## Your First Verilog Module: Wire Through

Let's create the simplest possible circuit - connecting input to output:

```verilog
// File: wire_through.v
module wire_through (
    input  wire a,    // Input signal
    output wire y     // Output signal
);

    // Direct connection: output follows input
    assign y = a;
    
endmodule
```

### Understanding This Code

- `module wire_through`: Names our hardware block
- `input wire a`: Declares an input port named 'a'
- `output wire y`: Declares an output port named 'y'
- `assign y = a`: Continuously connects y to a (like a physical wire)
- `endmodule`: Ends the module definition

### Timing Diagram

```
Time:    0ns   1ns   2ns   3ns   4ns   5ns   6ns   7ns
         ___________             ___________
a    ___|           |___________|           |________
         ___________             ___________
y    ___|           |___________|           |________

Explanation: Output y follows input a with zero delay (idealized)
```

In reality, there's a small propagation delay:

```
Time:    0ns   1ns   2ns   3ns   4ns   5ns   6ns   7ns
         ___________             ___________
a    ___|           |___________|           |________
             ___________             ___________
y    _______|           |___________|           |____
        ^
        |--- Propagation delay (tpd ~ 1-10ns typical)
```

## Example 2: NOT Gate (Inverter)

```verilog
// File: inverter.v
module inverter (
    input  wire a,
    output wire y
);

    // Output is opposite of input
    assign y = ~a;  // ~ is the NOT operator
    
endmodule
```

### Timing Diagram

```
Time:    0ns   1ns   2ns   3ns   4ns   5ns   6ns   7ns
         ___________             ___________
a    ___|           |___________|           |________
     ___             ___________             _________
y       |___________|           |___________|
        
        └─── Inversion happens (with small delay)
```

## Example 3: AND Gate

```verilog
// File: and_gate.v
module and_gate (
    input  wire a,
    input  wire b,
    output wire y
);

    // Output is HIGH only when both inputs are HIGH
    assign y = a & b;  // & is the AND operator
    
endmodule
```

### Truth Table

| a | b | y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

### Timing Diagram

```
Time:    0ns   1ns   2ns   3ns   4ns   5ns   6ns   7ns
         _____             _____             _____
a    ___|     |___________|     |___________|     |___
     ___       _________________       ___________
b       |_____|                 |_____|
     ___                   ___             _____
y       |_________________|   |___________|     |___

Explanation:
- At 1ns: a=1, b=0 → y=0
- At 2ns: a=0, b=1 → y=0  
- At 3ns: a=1, b=1 → y=1  (both HIGH)
- At 5ns: a=1, b=0 → y=0
- At 6ns: a=1, b=1 → y=1
```

## Example 4: Creating a Testbench

To simulate our designs, we need a **testbench** - a special module that generates test inputs:

```verilog
// File: and_gate_tb.v
`timescale 1ns/1ps  // Time unit / Time precision

module and_gate_tb;
    
    // Declare signals
    reg a, b;        // Inputs are 'reg' in testbenches
    wire y;          // Output is still 'wire'
    
    // Instantiate the module we're testing (DUT = Device Under Test)
    and_gate dut (
        .a(a),
        .b(b),
        .y(y)
    );
    
    // Generate test stimulus
    initial begin
        // Display header
        $display("Time\ta\tb\ty");
        $display("---\t-\t-\t-");
        
        // Monitor changes
        $monitor("%0t\t%b\t%b\t%b", $time, a, b, y);
        
        // Test all combinations
        a = 0; b = 0; #10;  // Wait 10 time units
        a = 0; b = 1; #10;
        a = 1; b = 0; #10;
        a = 1; b = 1; #10;
        
        // End simulation
        $finish;
    end
    
endmodule
```

### How to Simulate

```bash
# Compile both files
iverilog -o and_gate_sim and_gate.v and_gate_tb.v

# Run simulation
vvp and_gate_sim

# Expected output:
# Time  a  b  y
# ---   -  -  -
# 0     0  0  0
# 10    0  1  0
# 20    1  0  0
# 30    1  1  1
```

## Key Concepts Introduced

### 1. Module
The basic building block - like a function in software or an IC chip in hardware.

### 2. Ports
- **Input**: Signals coming into the module
- **Output**: Signals going out of the module
- **Inout**: Bidirectional signals (advanced topic)

### 3. Data Types (Brief Introduction)
- **wire**: Represents physical connections (used with `assign`)
- **reg**: Stores values (used in `always` blocks - covered later)

### 4. Continuous Assignment
```verilog
assign output = expression;
```
This creates a permanent connection. Whenever the right side changes, the left side updates immediately (with propagation delay).

### 5. Operators (More in Part 2)
- `~` : NOT (inversion)
- `&` : AND
- `|` : OR
- `^` : XOR

## Hardware Thinking Exercise

**Question**: What happens if we write this?

```verilog
assign y = a;
assign y = b;
```

**Software thinking**: "y is assigned twice, so y = b"

**Hardware thinking**: "Two drivers on one wire - SHORT CIRCUIT! ⚡ This is an error!"

In hardware, you cannot connect two outputs to the same wire (called a "multi-driver" error). Only one source can drive a signal.

## Common Beginner Mistakes

### ❌ Mistake 1: Forgetting semicolons
```verilog
assign y = a  // Missing semicolon - ERROR!
```

### ❌ Mistake 2: Not declaring signals
```verilog
assign y = a;  // Where is 'a' declared? ERROR!
```

### ❌ Mistake 3: Using software syntax
```verilog
if a == 1 then y = 1;  // Wrong! Not Python/C
```

### ✅ Correct way (we'll learn this in Part 4):
```verilog
assign y = (a == 1) ? 1 : 0;
```

## Timing Diagram Notation Guide

Throughout this tutorial, we'll use timing diagrams extensively:

```
Symbol meanings:
   ___
__|   |__     High-Low-High transition

     ___
____|        Low to High (rising edge)

___
   |____     High to Low (falling edge)

====X====    Unknown or don't care value

~~~~~~~      High-Z (tri-state)

 ___
_|X|____     Glitch (unwanted short pulse)
```

## Practice Exercises

### Exercise 1: OR Gate
Create a module that implements an OR gate.

**Hints**:
- Use the `|` operator
- Output is HIGH if either input is HIGH

### Exercise 2: NAND Gate
Create a module that implements a NAND gate (AND followed by NOT).

**Hints**:
- Combine `&` and `~` operators
- NAND = ~(a & b)

### Exercise 3: XOR Gate
Create a module that implements an XOR (exclusive OR) gate.

**Truth table**:
| a | b | y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 1 |
| 1 | 0 | 1 |
| 1 | 1 | 0 |

**Hint**: Use the `^` operator

### Exercise 4: Write Testbenches
Create testbenches for all three gates above and verify they work correctly.

## Solutions to Exercises

<details>
<summary>Click to see Exercise 1 solution</summary>

```verilog
// or_gate.v
module or_gate (
    input  wire a,
    input  wire b,
    output wire y
);
    assign y = a | b;
endmodule
```
</details>

<details>
<summary>Click to see Exercise 2 solution</summary>

```verilog
// nand_gate.v
module nand_gate (
    input  wire a,
    input  wire b,
    output wire y
);
    assign y = ~(a & b);
endmodule
```
</details>

<details>
<summary>Click to see Exercise 3 solution</summary>

```verilog
// xor_gate.v
module xor_gate (
    input  wire a,
    input  wire b,
    output wire y
);
    assign y = a ^ b;
endmodule
```
</details>

## Summary

In this introduction, you learned:

- ✅ Verilog is a hardware description language
- ✅ Hardware thinking is different from software thinking
- ✅ Modules are the basic building blocks
- ✅ Ports define module interfaces (input/output)
- ✅ `assign` creates continuous connections
- ✅ Basic operators: `~`, `&`, `|`, `^`
- ✅ How to create simple testbenches
- ✅ How to read timing diagrams

## What's Next?

In [Part 2: Data Types and Operators](./02_DataTypes_Operators.md), we'll dive deeper into:
- Wire vs Reg (crucial distinction!)
- Vectors (multi-bit signals)
- All operators in detail
- Number representations
- Parameters

---

**Ready to continue? Move on to Part 2!** 🚀

