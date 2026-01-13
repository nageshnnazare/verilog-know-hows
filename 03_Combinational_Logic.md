# Part 3: Combinational Logic

## What is Combinational Logic?

**Combinational logic** circuits have outputs that depend **only** on the current inputs - no memory, no state, no clock.

### Key Characteristics:
- ✅ Output = Function(Current Inputs)
- ✅ No feedback loops
- ✅ No storage elements (flip-flops, registers)
- ✅ Same inputs → Same outputs (deterministic)
- ✅ Implemented using `assign` statements

### Examples of Combinational Circuits:
- Logic gates (AND, OR, NOT, etc.)
- Multiplexers (Mux)
- Demultiplexers (Demux)
- Encoders and Decoders
- Adders and Subtractors
- Comparators
- ALU (Arithmetic Logic Unit)

## Timing in Combinational Circuits

Every gate has a **propagation delay** (tpd):

```
Input Change → [Propagation Delay] → Output Change
```

**Timing Diagram Example:**

```
Time:    0ns    1ns    2ns    3ns    4ns    5ns
         _______________
a    ___|               |________________________
         _______________________
b    ___|                       |________________
                 _______________
out  ___________|               |________________
                 ^              ^
                 |              |
          tpd from a      tpd from b
           (2ns)           (2ns)
```

## 1. Multiplexers (Data Selectors)

A multiplexer selects one of many inputs and routes it to the output.

### 2-to-1 Multiplexer

```verilog
module mux2to1 (
    input  wire       a,      // Input 0
    input  wire       b,      // Input 1
    input  wire       sel,    // Select signal
    output wire       y       // Output
);
    // When sel=0, output a; when sel=1, output b
    assign y = sel ? b : a;
endmodule
```

**Truth Table:**

| sel | y |
|-----|---|
| 0   | a |
| 1   | b |

**Timing Diagram:**

```
Time:     0ns     2ns     4ns     6ns     8ns     10ns
          ___             ___             ___
a     ___|   |___________|   |___________|   |_____
              ___     ___         ___     ___
b     _______|   |___|   |_______|   |___|   |_____
          ___         ___________         ___
sel   ___|   |_______|           |_______|   |_____
          ___         ___________         ___
y     ___|   |_______|           |_______|   |_____
          ^           ^                   ^
          |           |                   |
       sel=0       sel=1              sel=0
       picks a     picks b            picks a
```

### 4-to-1 Multiplexer

```verilog
module mux4to1 (
    input  wire [1:0] sel,    // 2-bit select
    input  wire       a, b, c, d,
    output wire       y
);
    assign y = (sel == 2'b00) ? a :
               (sel == 2'b01) ? b :
               (sel == 2'b10) ? c : d;
endmodule
```

**Truth Table:**

| sel[1:0] | y |
|----------|---|
| 00       | a |
| 01       | b |
| 10       | c |
| 11       | d |

### 8-bit 4-to-1 Multiplexer (Bus Width)

```verilog
module mux4to1_8bit (
    input  wire [1:0] sel,
    input  wire [7:0] a, b, c, d,
    output wire [7:0] y
);
    assign y = (sel == 2'b00) ? a :
               (sel == 2'b01) ? b :
               (sel == 2'b10) ? c : d;
endmodule
```

**Timing Diagram:**

```
Time:        0ns          5ns          10ns         15ns

sel[1:0]:    2'b00        2'b01        2'b10        2'b11

a[7:0]:      8'hAA        8'hAA        8'hAA        8'hAA
b[7:0]:      8'hBB        8'hBB        8'hBB        8'hBB
c[7:0]:      8'hCC        8'hCC        8'hCC        8'hCC
d[7:0]:      8'hDD        8'hDD        8'hDD        8'hDD

y[7:0]:      8'hAA        8'hBB        8'hCC        8'hDD
             ^sel=00      ^sel=01      ^sel=10      ^sel=11
```

### Case Statement Multiplexer

```verilog
module mux4to1_case (
    input  wire [1:0] sel,
    input  wire [7:0] a, b, c, d,
    output reg  [7:0] y  // Note: 'reg' because used in always block
);
    always @(*) begin  // Combinational always block
        case (sel)
            2'b00: y = a;
            2'b01: y = b;
            2'b10: y = c;
            2'b11: y = d;
        endcase
    end
endmodule
```

**Important:** `always @(*)` automatically includes all signals read in the block in the sensitivity list.

## 2. Demultiplexers (Data Distributors)

A demultiplexer routes one input to one of many outputs.

### 1-to-4 Demultiplexer

```verilog
module demux1to4 (
    input  wire [1:0] sel,
    input  wire       d,      // Data input
    output wire       y0, y1, y2, y3
);
    assign y0 = (sel == 2'b00) ? d : 1'b0;
    assign y1 = (sel == 2'b01) ? d : 1'b0;
    assign y2 = (sel == 2'b10) ? d : 1'b0;
    assign y3 = (sel == 2'b11) ? d : 1'b0;
endmodule
```

**Timing Diagram:**

```
Time:      0ns       5ns       10ns      15ns      20ns
           _____________________             _____
d      ___|                     |___________|     |___
           _____     _____     _____     _____
sel    ___|00   |___|01   |___|10   |___|11   |_______
           _____
y0     ___|     |_____________________________________
                 _____
y1     _________|     |_______________________________
                             _____
y2     _____________________|     |___________________
                                         _____
y3     _______________________________|     |_________
           ^         ^         ^         ^
           sel=00    sel=01    sel=10    sel=11
           d→y0      d→y1      d→y2      d→y3
```

## 3. Decoders

A decoder converts binary input to one-hot output.

### 2-to-4 Decoder

```verilog
module decoder2to4 (
    input  wire [1:0] in,
    output wire [3:0] out
);
    assign out[0] = (in == 2'b00);
    assign out[1] = (in == 2'b01);
    assign out[2] = (in == 2'b10);
    assign out[3] = (in == 2'b11);
endmodule
```

**Truth Table:**

| in[1:0] | out[3:0] |
|---------|----------|
| 00      | 0001     |
| 01      | 0010     |
| 10      | 0100     |
| 11      | 1000     |

**Timing Diagram:**

```
Time:       0ns        5ns        10ns       15ns
            _____      _____      _____      _____
in[1:0]:    |00  |____|01  |_____|10  |_____|11  |____
            _____
out[0]:     |    |________________________________________
                   _____
out[1]:     ______|    |________________________________
                              _____
out[2]:     __________________|    |____________________
                                         _____
out[3]:     ____________________________|    |__________
```

### 3-to-8 Decoder with Enable

```verilog
module decoder3to8 (
    input  wire [2:0] in,
    input  wire       en,     // Enable signal
    output wire [7:0] out
);
    assign out[0] = en && (in == 3'b000);
    assign out[1] = en && (in == 3'b001);
    assign out[2] = en && (in == 3'b010);
    assign out[3] = en && (in == 3'b011);
    assign out[4] = en && (in == 3'b100);
    assign out[5] = en && (in == 3'b101);
    assign out[6] = en && (in == 3'b110);
    assign out[7] = en && (in == 3'b111);
endmodule
```

## 4. Encoders

An encoder converts one-hot input to binary output.

### 4-to-2 Priority Encoder

```verilog
module priority_encoder4to2 (
    input  wire [3:0] in,
    output reg  [1:0] out,
    output reg        valid
);
    always @(*) begin
        if (in[3]) begin
            out = 2'b11;
            valid = 1'b1;
        end else if (in[2]) begin
            out = 2'b10;
            valid = 1'b1;
        end else if (in[1]) begin
            out = 2'b01;
            valid = 1'b1;
        end else if (in[0]) begin
            out = 2'b00;
            valid = 1'b1;
        end else begin
            out = 2'b00;
            valid = 1'b0;  // No input active
        end
    end
endmodule
```

**Priority:** Higher-indexed inputs have priority over lower-indexed ones.

**Truth Table:**

| in[3:0] | out[1:0] | valid | Comment |
|---------|----------|-------|---------|
| 0000    | XX       | 0     | No input |
| 0001    | 00       | 1     | in[0] active |
| 0010    | 01       | 1     | in[1] active |
| 0011    | 01       | 1     | in[1] has priority |
| 1000    | 11       | 1     | in[3] active |
| 1111    | 11       | 1     | in[3] has priority |

## 5. Adders

### Half Adder

Adds two 1-bit numbers:

```verilog
module half_adder (
    input  wire a,
    input  wire b,
    output wire sum,
    output wire carry
);
    assign sum   = a ^ b;  // XOR
    assign carry = a & b;  // AND
endmodule
```

**Truth Table:**

| a | b | sum | carry |
|---|---|-----|-------|
| 0 | 0 | 0   | 0     |
| 0 | 1 | 1   | 0     |
| 1 | 0 | 1   | 0     |
| 1 | 1 | 0   | 1     |

**Timing Diagram:**

```
Time:    0ns    2ns    4ns    6ns    8ns
         ___           ___           ___
a    ___|   |_________|   |_________|   |___
         _______     _________     _______
b    ___|       |___|         |___|       |___
         _______     ___           _______
sum  ___|       |___|   |_________|       |___
         ___           _______           ___
carry ___|   |_________|       |_________|   |___
         ^0+0  ^0+1    ^1+1    ^1+0    ^1+1
```

### Full Adder

Adds three 1-bit numbers (includes carry-in):

```verilog
module full_adder (
    input  wire a,
    input  wire b,
    input  wire cin,    // Carry in
    output wire sum,
    output wire cout    // Carry out
);
    assign sum  = a ^ b ^ cin;
    assign cout = (a & b) | (b & cin) | (a & cin);
endmodule
```

**Truth Table:**

| a | b | cin | sum | cout |
|---|---|-----|-----|------|
| 0 | 0 | 0   | 0   | 0    |
| 0 | 0 | 1   | 1   | 0    |
| 0 | 1 | 0   | 1   | 0    |
| 0 | 1 | 1   | 0   | 1    |
| 1 | 0 | 0   | 1   | 0    |
| 1 | 0 | 1   | 0   | 1    |
| 1 | 1 | 0   | 0   | 1    |
| 1 | 1 | 1   | 1   | 1    |

### 4-bit Ripple Carry Adder

```verilog
module ripple_carry_adder_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    input  wire       cin,
    output wire [3:0] sum,
    output wire       cout
);
    wire c1, c2, c3;  // Internal carries
    
    full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin), .sum(sum[0]), .cout(c1));
    full_adder fa1 (.a(a[1]), .b(b[1]), .cin(c1),  .sum(sum[1]), .cout(c2));
    full_adder fa2 (.a(a[2]), .b(b[2]), .cin(c2),  .sum(sum[2]), .cout(c3));
    full_adder fa3 (.a(a[3]), .b(b[3]), .cin(c3),  .sum(sum[3]), .cout(cout));
endmodule
```

**Timing Diagram - Ripple Effect:**

```
Time:       0ns   2ns   4ns   6ns   8ns   10ns

a[3:0]:     4'b0101  (decimal 5)
b[3:0]:     4'b0011  (decimal 3)
cin:        0

Internal signal propagation:
            _____
a[0],b[0]:  1,1  → sum[0]=0, c1=1     (at 0-2ns)
                     _____
a[1],b[1]:           0,1  → sum[1]=0, c2=1   (at 2-4ns)
                             _____
a[2],b[2]:                   1,0  → sum[2]=0, c3=1 (at 4-6ns)
                                     _____
a[3],b[3]:                           0,0  → sum[3]=1, cout=0 (at 6-8ns)

Result: sum[3:0] = 4'b1000 (decimal 8) ✓ 5+3=8

Critical Path Delay: 4 × (Full Adder Delay) = 4 × 2ns = 8ns
```

**Problem with Ripple Carry:** Slow for large bit widths! Better alternatives:
- Carry Look-Ahead Adder (faster, more complex)
- Carry Select Adder (moderate speed/area trade-off)

### Simple Adder (Using + Operator)

For most designs, use the built-in `+` operator:

```verilog
module simple_adder (
    input  wire [7:0] a,
    input  wire [7:0] b,
    output wire [8:0] sum  // 9 bits to hold carry-out
);
    assign sum = a + b;
    // Synthesis tool chooses the best adder implementation
endmodule
```

## 6. Subtractor

```verilog
module subtractor_8bit (
    input  wire [7:0] a,
    input  wire [7:0] b,
    output wire [7:0] diff,
    output wire       borrow
);
    assign {borrow, diff} = a - b;
endmodule
```

## 7. Comparator

```verilog
module comparator_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire       eq,    // Equal
    output wire       gt,    // Greater than
    output wire       lt     // Less than
);
    assign eq = (a == b);
    assign gt = (a > b);
    assign lt = (a < b);
endmodule
```

**Timing Diagram:**

```
Time:       0ns          5ns          10ns         15ns

a[3:0]:     4'b0101      4'b1000      4'b0011      4'b0110
            (5)          (8)          (3)          (6)

b[3:0]:     4'b0101      4'b0100      4'b1001      4'b0110
            (5)          (4)          (9)          (6)

eq:         ____          ____          ____      ________
            |  |__________|  |__________|  |_____|        |___
            ^5==5         ^8≠4          ^3≠9      ^6==6

gt:         ____      ________          ____          ____
            |  |_____|        |________|  |__________|  |___
            ^5>5?     ^8>4!             ^3>9?        ^6>6?
            NO        YES               NO           NO

lt:         ____          ____      ________          ____
            |  |__________|  |_____|        |________|  |___
            ^5<5?         ^8<4?    ^3<9!             ^6<6?
            NO            NO       YES               NO
```

## 8. Arithmetic Logic Unit (ALU)

A complete ALU combines multiple operations:

```verilog
module alu_8bit (
    input  wire [7:0]  a,
    input  wire [7:0]  b,
    input  wire [3:0]  opcode,
    output reg  [7:0]  result,
    output wire        zero,
    output wire        negative
);
    // Opcodes
    localparam OP_ADD  = 4'h0;
    localparam OP_SUB  = 4'h1;
    localparam OP_AND  = 4'h2;
    localparam OP_OR   = 4'h3;
    localparam OP_XOR  = 4'h4;
    localparam OP_NOT  = 4'h5;
    localparam OP_SLL  = 4'h6;  // Shift left logical
    localparam OP_SRL  = 4'h7;  // Shift right logical
    localparam OP_INC  = 4'h8;  // Increment a
    localparam OP_DEC  = 4'h9;  // Decrement a
    
    always @(*) begin
        case (opcode)
            OP_ADD:  result = a + b;
            OP_SUB:  result = a - b;
            OP_AND:  result = a & b;
            OP_OR:   result = a | b;
            OP_XOR:  result = a ^ b;
            OP_NOT:  result = ~a;
            OP_SLL:  result = a << b[2:0];
            OP_SRL:  result = a >> b[2:0];
            OP_INC:  result = a + 1;
            OP_DEC:  result = a - 1;
            default: result = 8'h00;
        endcase
    end
    
    // Status flags
    assign zero     = (result == 8'h00);
    assign negative = result[7];  // MSB indicates sign
endmodule
```

**Timing Diagram:**

```
Time:         0ns          10ns         20ns         30ns

opcode:       4'h0         4'h1         4'h2         4'h3
              (ADD)        (SUB)        (AND)        (OR)

a[7:0]:       8'h0F        8'h10        8'hF0        8'hAA
              (15)         (16)         (240)        (170)

b[7:0]:       8'h03        8'h05        8'h0F        8'h55
              (3)          (5)          (15)         (85)

result:       8'h12        8'h0B        8'h00        8'hFF
              (18)         (11)         (0)          (255)

zero:         _____        _____    ________         _____
              |   |________|   |___|        |________|   |___
                                   ^result=0

negative:     _____        _____        _____    _________
              |   |________|   |________|   |___|         |___
                                                 ^MSB=1
```

## 9. Priority Mux (Used in Arbitration)

```verilog
module priority_mux (
    input  wire [3:0] req,      // Request signals
    input  wire [7:0] data0,
    input  wire [7:0] data1,
    input  wire [7:0] data2,
    input  wire [7:0] data3,
    output reg  [7:0] out,
    output reg  [1:0] grant     // Which request was granted
);
    always @(*) begin
        if (req[3]) begin
            out = data3;
            grant = 2'd3;
        end else if (req[2]) begin
            out = data2;
            grant = 2'd2;
        end else if (req[1]) begin
            out = data1;
            grant = 2'd1;
        end else if (req[0]) begin
            out = data0;
            grant = 2'd0;
        end else begin
            out = 8'h00;
            grant = 2'd0;
        end
    end
endmodule
```

## Timing Analysis Concepts

### Propagation Delay

```
       Input Change
            |
            v
    ┌───────────────┐
    │ Combinational │  ← Takes time!
    │    Circuit    │
    └───────────────┘
            |
            v
       Output Change
       
Time elapsed = Propagation Delay (tpd)
```

### Critical Path

The **longest delay path** through your circuit:

```verilog
// Example: 4-input AND-OR circuit
module critical_path_example (
    input  wire a, b, c, d,
    output wire y
);
    wire and1, and2;
    
    assign and1 = a & b;    // Delay: 1ns
    assign and2 = c & d;    // Delay: 1ns
    assign y = and1 | and2; // Delay: 1ns
    
    // Total delay (critical path): 1ns + 1ns = 2ns
endmodule
```

**Timing Diagram:**

```
Time:    0ns   1ns   2ns   3ns   4ns   5ns
         _______________
a    ___|               |_______________________
         _______________
b    ___|               |_______________________
         _______________
c    ___|               |_______________________
         _______________
d    ___|               |_______________________
               ________
and1 _________|        |_______________________
               ________
and2 _________|        |_______________________
                      ________
y    ________________|        |_________________
         ^     ^     ^
         |     |     |
        Input AND    OR
        change gate  gate
               delay delay
               
        Total: 2ns propagation delay
```

## Best Practices for Combinational Logic

### ✅ DO:

1. **Use `assign` for simple combinational logic**
```verilog
assign y = a & b | c;
```

2. **Use `always @(*)` for complex combinational logic**
```verilog
always @(*) begin
    case (sel)
        // complex logic
    endcase
end
```

3. **Assign default values to avoid latches**
```verilog
always @(*) begin
    y = 1'b0;  // Default value
    case (sel)
        2'b00: y = a;
        2'b01: y = b;
        // etc.
    endcase
end
```

4. **Use parentheses for clarity**
```verilog
assign y = (a & b) | (c & d);  // Clear
```

### ❌ DON'T:

1. **Don't create unintentional latches**
```verilog
// BAD: y not assigned in all cases
always @(*) begin
    if (sel)
        y = a;
    // What if sel=0? → LATCH!
end

// GOOD:
always @(*) begin
    if (sel)
        y = a;
    else
        y = b;  // All cases covered
end
```

2. **Don't use multiple drivers**
```verilog
assign y = a;
assign y = b;  // ERROR! Multiple drivers
```

3. **Don't use delays in synthesizable code**
```verilog
assign #5 y = a;  // OK for simulation, NOT synthesizable
```

## Common Pitfalls

### Pitfall 1: Incomplete Case Statements

```verilog
// BAD: Missing default case
always @(*) begin
    case (sel)
        2'b00: y = a;
        2'b01: y = b;
        // What about 2'b10 and 2'b11? → LATCHES!
    endcase
end

// GOOD: Add default
always @(*) begin
    case (sel)
        2'b00: y = a;
        2'b01: y = b;
        default: y = 1'b0;
    endcase
end
```

### Pitfall 2: Incomplete If Statements

```verilog
// BAD: No else clause
always @(*) begin
    if (enable)
        out = data;
    // If enable=0? → LATCH!
end

// GOOD: Complete all branches
always @(*) begin
    if (enable)
        out = data;
    else
        out = 8'h00;
end
```

## Practice Exercises

### Exercise 1: 8-to-1 Multiplexer
Create an 8-to-1 multiplexer with 8-bit data inputs.

### Exercise 2: 7-Segment Decoder
Create a decoder that converts a 4-bit BCD input (0-9) to 7-segment display outputs.

```
Segments:     a
            -----
          f|     |b
            --g--
          e|     |c
            -----
              d
```

### Exercise 3: Barrel Shifter
Create a barrel shifter that can shift an 8-bit input left or right by 0-7 positions in one clock cycle.

### Exercise 4: Leading Zero Counter
Count the number of leading zeros in an 8-bit input.

## Solutions

<details>
<summary>Exercise 1 Solution: 8-to-1 Mux</summary>

```verilog
module mux8to1 (
    input  wire [2:0] sel,
    input  wire [7:0] in0, in1, in2, in3, in4, in5, in6, in7,
    output reg  [7:0] out
);
    always @(*) begin
        case (sel)
            3'd0: out = in0;
            3'd1: out = in1;
            3'd2: out = in2;
            3'd3: out = in3;
            3'd4: out = in4;
            3'd5: out = in5;
            3'd6: out = in6;
            3'd7: out = in7;
        endcase
    end
endmodule
```
</details>

<details>
<summary>Exercise 2 Solution: 7-Segment Decoder</summary>

```verilog
module seg7_decoder (
    input  wire [3:0] bcd,       // 0-9
    output reg  [6:0] segments   // {a,b,c,d,e,f,g}
);
    always @(*) begin
        case (bcd)
            4'd0: segments = 7'b1111110;  // 0
            4'd1: segments = 7'b0110000;  // 1
            4'd2: segments = 7'b1101101;  // 2
            4'd3: segments = 7'b1111001;  // 3
            4'd4: segments = 7'b0110011;  // 4
            4'd5: segments = 7'b1011011;  // 5
            4'd6: segments = 7'b1011111;  // 6
            4'd7: segments = 7'b1110000;  // 7
            4'd8: segments = 7'b1111111;  // 8
            4'd9: segments = 7'b1111011;  // 9
            default: segments = 7'b0000000;
        endcase
    end
endmodule
```
</details>

## Summary

In this part, you learned:

- ✅ Combinational logic has no memory/state
- ✅ Multiplexers select from multiple inputs
- ✅ Demultiplexers route to multiple outputs
- ✅ Decoders convert binary to one-hot
- ✅ Encoders convert one-hot to binary
- ✅ Adder implementations (half, full, ripple-carry)
- ✅ Building complex circuits (ALU, comparators)
- ✅ Timing analysis and critical paths
- ✅ How to avoid latches in combinational logic
- ✅ Best practices for clean, synthesizable code

## What's Next?

In [Part 4: Sequential Logic and Timing](./04_Sequential_Logic.md), we'll learn the most important topic:

- Flip-flops and registers
- Clock domains
- Setup and hold times
- Blocking vs non-blocking assignments
- Detailed timing analysis

**This is where Verilog gets really powerful!** 🚀

---

**Ready to master sequential logic? Continue to Part 4!**

