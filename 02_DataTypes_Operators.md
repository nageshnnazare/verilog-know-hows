# Part 2: Data Types and Operators

## Understanding Verilog Data Types

The most important concept for beginners: **wire vs reg**

### Wire vs Reg - The Critical Distinction

| Characteristic | wire | reg |
|----------------|------|-----|
| **Represents** | Physical connection | Storage element |
| **Used with** | `assign` statements | `always` blocks |
| **Drives** | Combinational logic | Sequential logic (usually) |
| **Think of it as** | Actual wire in circuit | Variable that holds value |
| **Must be driven by** | Single source | Procedural assignment |

### Wire Example

```verilog
module wire_example (
    input  wire a,
    input  wire b,
    output wire sum,
    output wire carry
);
    // Continuous assignment - always active
    assign sum   = a ^ b;      // XOR for sum
    assign carry = a & b;      // AND for carry
endmodule
```

**Timing Diagram:**

```
Time:    0ns    5ns    10ns   15ns   20ns   25ns
         ______        ______
a    ___|      |______|      |______________
     __________        ______________
b              |______|              |______
     ______        __        ______
sum        |______|  |______|      |________
     ______                  ______
carry      |________________|      |________

Explanation: sum and carry update immediately when a or b changes
```

### Reg Example (Preview - full coverage in Part 4)

```verilog
module reg_example (
    input  wire       clk,
    input  wire       d,
    output reg        q
);
    // Sequential assignment - changes on clock edge
    always @(posedge clk) begin
        q <= d;  // Non-blocking assignment
    end
endmodule
```

**Key Point**: Despite the name "`reg`", this doesn't always synthesize to a register! It just means "assigned in a procedural block."

## Vectors (Multi-bit Signals)

Real hardware uses buses - multiple bits grouped together.

### Vector Declaration

```verilog
wire [7:0] data_bus;    // 8-bit wire (bits 7 down to 0)
reg  [3:0] counter;     // 4-bit reg
wire [15:0] address;    // 16-bit address bus
```

### Bit Ordering

```verilog
wire [7:0] byte1;  // MSB=7, LSB=0 (most common - descending)
wire [0:7] byte2;  // MSB=0, LSB=7 (ascending - less common)

// Always use [MSB:LSB] format for consistency!
```

### Accessing Bits

```verilog
module bit_access (
    input  wire [7:0] data_in,
    output wire [3:0] upper_nibble,
    output wire [3:0] lower_nibble,
    output wire       msb,
    output wire       lsb
);
    // Extract ranges (bit slicing)
    assign upper_nibble = data_in[7:4];  // Bits 7,6,5,4
    assign lower_nibble = data_in[3:0];  // Bits 3,2,1,0
    
    // Access individual bits
    assign msb = data_in[7];  // Most significant bit
    assign lsb = data_in[0];  // Least significant bit
endmodule
```

### Timing Diagram for Bit Slicing

```
Time:    0ns         10ns        20ns        30ns
         
data_in: 8'b00000000  8'b11110000  8'b10101010  8'b11111111

         ____        ____    ____        ________
upper[3] ____|______|____|__|____|______|________
         ____        ____    ____        ________
upper[2] ____|______|____|__|____|______|________
         ____        ____    ____        ________
upper[1] ____|______|____|__|____|______|________
         ____        ____    ____        ________
upper[0] ____|______|____|__|____|______|________

         ____        ____        ____    ________
lower[3] ____|______|____|______|____|__|________
         ____        ____    ____    ____    ____
lower[2] ____|______|____|__|____|__|____|__|____
         ____        ____        ____    ________
lower[1] ____|______|____|______|____|__|________
         ____        ____    ____    ____    ____
lower[0] ____|______|____|__|____|__|____|__|____
```

## Concatenation and Replication

### Concatenation `{ }`

Combine multiple signals into one vector:

```verilog
module concatenation (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [7:0] y
);
    // Combine a and b into 8-bit output
    assign y = {a, b};  // y = [a3,a2,a1,a0,b3,b2,b1,b0]
endmodule
```

**Example:**
```verilog
a = 4'b1010
b = 4'b0011
y = {a, b} = 8'b10100011
```

### Replication `{n{value}}`

Repeat a value n times:

```verilog
module replication (
    input  wire       sign_bit,
    input  wire [7:0] value,
    output wire [15:0] extended
);
    // Sign-extend 8-bit to 16-bit
    assign extended = {{8{sign_bit}}, value};
    // If sign_bit=1 and value=8'b11110000
    // Result: 16'b1111111111110000
endmodule
```

## Number Representations

### Number Format: `<size>'<base><value>`

```verilog
8'b10101010      // 8-bit binary
4'd15            // 4-bit decimal (1111 in binary)
16'hABCD         // 16-bit hexadecimal
8'o377           // 8-bit octal
32'h0000_FFFF    // Underscores for readability (ignored)
```

### Examples

```verilog
wire [7:0] a = 8'b1111_0000;     // Binary: 11110000
wire [7:0] b = 8'd240;            // Decimal: 240 (same value)
wire [7:0] c = 8'hF0;             // Hex: F0 (same value)

wire [3:0] d = 4'b1010;           // 10 in decimal
wire [3:0] e = 4'd10;             // Same as above
wire [3:0] f = 4'hA;              // Same as above
```

### Signed Numbers

```verilog
wire signed [7:0] temperature = -25;  // 2's complement
reg  signed [15:0] result;
```

## Operators in Verilog

### Arithmetic Operators

| Operator | Operation | Example | Result |
|----------|-----------|---------|--------|
| `+` | Addition | `4'b0101 + 4'b0011` | `4'b1000` (5+3=8) |
| `-` | Subtraction | `4'b0101 - 4'b0011` | `4'b0010` (5-3=2) |
| `*` | Multiplication | `4'b0101 * 4'b0011` | `8'b00001111` (5*3=15) |
| `/` | Division | `4'b1000 / 4'b0010` | `4'b0100` (8/2=4) |
| `%` | Modulus | `4'b1001 % 4'b0100` | `4'b0001` (9%4=1) |
| `**` | Power | `2**3` | `8` |

### Example: 4-bit Adder

```verilog
module adder_4bit (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [4:0] sum  // 5 bits to hold carry-out
);
    assign sum = a + b;
endmodule
```

**Timing Diagram:**

```
Time:      0ns         10ns        20ns        30ns

a[3:0]:    4'b0001     4'b0101     4'b1111     4'b1000
b[3:0]:    4'b0010     4'b0110     4'b0001     4'b1000

sum[4:0]:  5'b00011    5'b01011    5'b10000    5'b10000
           (1+2=3)     (5+6=11)    (15+1=16)   (8+8=16)
                                    ^carry
```

### Logical Operators (return 1-bit true/false)

| Operator | Operation | Example | Result |
|----------|-----------|---------|--------|
| `!` | Logical NOT | `!4'b0000` | `1` (true) |
| `&&` | Logical AND | `(3 > 2) && (5 < 6)` | `1` (true) |
| `||` | Logical OR | `(3 > 5) || (2 < 4)` | `1` (true) |

```verilog
wire a = 4'b0101;  // Non-zero = true
wire b = 4'b0000;  // Zero = false

wire result1 = a && b;  // false (0)
wire result2 = a || b;  // true (1)
wire result3 = !b;      // true (1)
```

### Bitwise Operators (operate on each bit)

| Operator | Operation | Example | Result |
|----------|-----------|---------|--------|
| `~` | NOT | `~4'b1010` | `4'b0101` |
| `&` | AND | `4'b1100 & 4'b1010` | `4'b1000` |
| `|` | OR | `4'b1100 | 4'b1010` | `4'b1110` |
| `^` | XOR | `4'b1100 ^ 4'b1010` | `4'b0110` |
| `~^` or `^~` | XNOR | `4'b1100 ~^ 4'b1010` | `4'b1001` |

**Example:**

```verilog
module bitwise_ops (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire [3:0] and_out,
    output wire [3:0] or_out,
    output wire [3:0] xor_out
);
    assign and_out = a & b;
    assign or_out  = a | b;
    assign xor_out = a ^ b;
endmodule

// If a = 4'b1100 and b = 4'b1010:
// and_out = 4'b1000
// or_out  = 4'b1110
// xor_out = 4'b0110
```

**Timing Diagram:**

```
Time:     0ns         10ns        20ns        30ns

a[3:0]:   4'b0000     4'b1100     4'b1111     4'b1010
b[3:0]:   4'b0000     4'b1010     4'b0000     4'b0101

and_out:  4'b0000     4'b1000     4'b0000     4'b0000
or_out:   4'b0000     4'b1110     4'b1111     4'b1111
xor_out:  4'b0000     4'b0110     4'b1111     4'b1111
```

### Reduction Operators (operate on all bits, return 1 bit)

| Operator | Operation | Example | Result |
|----------|-----------|---------|--------|
| `&` | AND all bits | `& 4'b1111` | `1` |
| `|` | OR all bits | `| 4'b0001` | `1` |
| `^` | XOR all bits (parity) | `^ 4'b0101` | `0` |
| `~&` | NAND all bits | `~& 4'b1111` | `0` |
| `~|` | NOR all bits | `~| 4'b0000` | `1` |
| `~^` | XNOR all bits | `~^ 4'b0011` | `1` |

**Example:**

```verilog
module reduction_ops (
    input  wire [3:0] data,
    output wire       all_ones,   // True if all bits are 1
    output wire       any_one,    // True if any bit is 1
    output wire       parity      // Even parity check
);
    assign all_ones = &data;   // AND reduction
    assign any_one  = |data;   // OR reduction
    assign parity   = ^data;   // XOR reduction
endmodule

// Examples:
// data = 4'b1111: all_ones=1, any_one=1, parity=0
// data = 4'b1000: all_ones=0, any_one=1, parity=1
// data = 4'b0000: all_ones=0, any_one=0, parity=0
```

### Relational Operators

| Operator | Operation | Example | Result |
|----------|-----------|---------|--------|
| `>` | Greater than | `5 > 3` | `1` (true) |
| `<` | Less than | `5 < 3` | `0` (false) |
| `>=` | Greater or equal | `5 >= 5` | `1` (true) |
| `<=` | Less or equal | `5 <= 3` | `0` (false) |

### Equality Operators

| Operator | Operation | Example | Result |
|----------|-----------|---------|--------|
| `==` | Equality | `4'b1010 == 4'b1010` | `1` |
| `!=` | Inequality | `4'b1010 != 4'b0101` | `1` |
| `===` | Case equality (includes X,Z) | `4'b1X0Z === 4'b1X0Z` | `1` |
| `!==` | Case inequality | `4'b1X0Z !== 4'b1X0Z` | `0` |

**Important:** Use `===` and `!==` in testbenches to compare X (unknown) and Z (high-impedance) values.

### Shift Operators

| Operator | Operation | Example | Result |
|----------|-----------|---------|--------|
| `<<` | Logical left shift | `4'b0011 << 1` | `4'b0110` |
| `>>` | Logical right shift | `4'b1100 >> 1` | `4'b0110` |
| `<<<` | Arithmetic left shift | `4'b0011 <<< 1` | `4'b0110` |
| `>>>` | Arithmetic right shift | `4'b1100 >>> 1` | `4'b1110` |

**Example:**

```verilog
module shifter (
    input  wire [7:0] data,
    input  wire [2:0] shift_amt,
    output wire [7:0] left_shifted,
    output wire [7:0] right_shifted
);
    assign left_shifted  = data << shift_amt;
    assign right_shifted = data >> shift_amt;
endmodule
```

**Timing Diagram:**

```
Time:       0ns              10ns             20ns

data:       8'b00001111      8'b11110000      8'b10101010
shift_amt:  3'd1             3'd2             3'd3

left<<:     8'b00011110      8'b11000000      8'b01010000
right>>:    8'b00000111      8'b00111100      8'b00010101
```

### Conditional (Ternary) Operator

```verilog
assign output = condition ? value_if_true : value_if_false;
```

**Example: 2-to-1 Multiplexer**

```verilog
module mux2to1 (
    input  wire       sel,
    input  wire [7:0] a,
    input  wire [7:0] b,
    output wire [7:0] y
);
    assign y = sel ? b : a;  // If sel=1, y=b; else y=a
endmodule
```

**Timing Diagram:**

```
Time:     0ns      5ns      10ns     15ns     20ns

sel:      0        1        1        0        1

a[7:0]:   8'hAA    8'hAA    8'h11    8'h22    8'h33
b[7:0]:   8'hBB    8'hCC    8'hDD    8'hEE    8'hFF

y[7:0]:   8'hAA    8'hCC    8'hDD    8'h22    8'hFF
          ^sel=0   ^sel=1   ^sel=1   ^sel=0   ^sel=1
          picks a  picks b  picks b  picks a  picks b
```

### Nested Conditional (4-to-1 Mux)

```verilog
module mux4to1 (
    input  wire [1:0] sel,
    input  wire [7:0] a, b, c, d,
    output wire [7:0] y
);
    assign y = (sel == 2'b00) ? a :
               (sel == 2'b01) ? b :
               (sel == 2'b10) ? c : d;
endmodule
```

## Parameters and Constants

### Parameters (Compile-time Constants)

```verilog
module parameterized_adder #(
    parameter WIDTH = 8  // Default width
)(
    input  wire [WIDTH-1:0] a,
    input  wire [WIDTH-1:0] b,
    output wire [WIDTH:0]   sum
);
    assign sum = a + b;
endmodule

// Instantiate with different widths
parameterized_adder #(.WIDTH(4))  adder4  (.a(a4), .b(b4), .sum(sum4));
parameterized_adder #(.WIDTH(16)) adder16 (.a(a16), .b(b16), .sum(sum16));
```

### Localparam (Local Parameters)

```verilog
module state_machine (
    input wire clk,
    input wire rst,
    output reg [1:0] state
);
    // Local parameters (cannot be overridden)
    localparam IDLE  = 2'b00;
    localparam START = 2'b01;
    localparam RUN   = 2'b10;
    localparam STOP  = 2'b11;
    
    // Use parameters instead of magic numbers
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        // ... state machine logic ...
    end
endmodule
```

## Operator Precedence

From highest to lowest priority:

1. `()` - Parentheses
2. `!`, `~` - Logical/Bitwise NOT
3. `**` - Power
4. `*`, `/`, `%` - Multiply, divide, modulus
5. `+`, `-` - Add, subtract
6. `<<`, `>>`, `<<<`, `>>>` - Shifts
7. `<`, `<=`, `>`, `>=` - Relational
8. `==`, `!=`, `===`, `!==` - Equality
9. `&`, `~&` - Bitwise AND, NAND
10. `^`, `~^` - Bitwise XOR, XNOR
11. `|`, `~|` - Bitwise OR, NOR
12. `&&` - Logical AND
13. `||` - Logical OR
14. `?:` - Conditional

**Best Practice:** Use parentheses to make intent clear!

```verilog
// Unclear:
assign y = a & b | c ^ d;

// Clear:
assign y = ((a & b) | c) ^ d;
```

## Common Mistakes with Data Types

### ❌ Mistake 1: Size Mismatch

```verilog
wire [7:0] a = 8'b11111111;
wire [3:0] b = a;  // Truncates to 4'b1111 (loses upper bits!)
```

### ❌ Mistake 2: Signed/Unsigned Confusion

```verilog
wire [3:0] a = 4'b1111;        // Unsigned: value = 15
wire signed [3:0] b = 4'b1111; // Signed: value = -1 (2's complement)
```

### ❌ Mistake 3: Using Reg with Assign

```verilog
reg out;
assign out = a & b;  // ERROR! Cannot use assign with reg
```

### ✅ Correct:

```verilog
wire out;
assign out = a & b;  // Correct
```

## Practical Example: ALU (Arithmetic Logic Unit)

```verilog
module simple_alu (
    input  wire [7:0] a,
    input  wire [7:0] b,
    input  wire [2:0] op,     // Operation select
    output wire [7:0] result,
    output wire       zero    // Result is zero
);
    // Operation codes
    localparam OP_ADD  = 3'b000;
    localparam OP_SUB  = 3'b001;
    localparam OP_AND  = 3'b010;
    localparam OP_OR   = 3'b011;
    localparam OP_XOR  = 3'b100;
    localparam OP_SLL  = 3'b101;  // Shift left logical
    localparam OP_SRL  = 3'b110;  // Shift right logical
    
    // Perform operation based on op code
    assign result = (op == OP_ADD) ? (a + b) :
                    (op == OP_SUB) ? (a - b) :
                    (op == OP_AND) ? (a & b) :
                    (op == OP_OR)  ? (a | b) :
                    (op == OP_XOR) ? (a ^ b) :
                    (op == OP_SLL) ? (a << b[2:0]) :
                    (op == OP_SRL) ? (a >> b[2:0]) : 8'b0;
    
    // Zero flag: true if all bits of result are 0
    assign zero = ~(|result);  // NOR reduction
endmodule
```

## Practice Exercises

### Exercise 1: Bit Reversal
Create a module that reverses an 8-bit input.
```
Input:  8'b10110011
Output: 8'b11001101
```

### Exercise 2: Parity Generator
Create a module that generates even parity for an 8-bit data word.

### Exercise 3: Magnitude Comparator
Create a module that compares two 4-bit numbers and outputs:
- `greater`: HIGH if a > b
- `equal`: HIGH if a == b
- `less`: HIGH if a < b

### Exercise 4: Barrel Shifter
Create a module that can shift an 8-bit input left or right by 0-3 positions.

## Solutions

<details>
<summary>Exercise 1 Solution: Bit Reversal</summary>

```verilog
module bit_reversal (
    input  wire [7:0] data_in,
    output wire [7:0] data_out
);
    assign data_out = {data_in[0], data_in[1], data_in[2], data_in[3],
                       data_in[4], data_in[5], data_in[6], data_in[7]};
endmodule
```
</details>

<details>
<summary>Exercise 2 Solution: Parity Generator</summary>

```verilog
module parity_gen (
    input  wire [7:0] data,
    output wire       parity_bit
);
    // XOR all bits to get even parity
    assign parity_bit = ^data;
endmodule
```
</details>

<details>
<summary>Exercise 3 Solution: Magnitude Comparator</summary>

```verilog
module comparator (
    input  wire [3:0] a,
    input  wire [3:0] b,
    output wire       greater,
    output wire       equal,
    output wire       less
);
    assign greater = (a > b);
    assign equal   = (a == b);
    assign less    = (a < b);
endmodule
```
</details>

## Summary

In this part, you learned:

- ✅ **wire** vs **reg** - the fundamental distinction
- ✅ Vectors and bit manipulation
- ✅ Concatenation `{ }` and replication `{n{val}}`
- ✅ Number representations (binary, hex, decimal, octal)
- ✅ All operator types:
  - Arithmetic (`+`, `-`, `*`, `/`, `%`)
  - Logical (`&&`, `||`, `!`)
  - Bitwise (`&`, `|`, `^`, `~`)
  - Reduction (`&`, `|`, `^` on all bits)
  - Relational (`>`, `<`, `>=`, `<=`)
  - Equality (`==`, `!=`, `===`, `!==`)
  - Shift (`<<`, `>>`, `<<<`, `>>>`)
  - Conditional (`?:`)
- ✅ Parameters and localparams
- ✅ Operator precedence

## What's Next?

In [Part 3: Combinational Logic](./03_Combinational_Logic.md), we'll build:
- Complete multiplexers and demultiplexers
- Encoders and decoders
- Arithmetic circuits
- Real-world combinational designs

---

**Ready for combinational circuits? Let's continue!** 🚀

