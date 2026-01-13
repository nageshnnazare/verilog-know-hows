# Part 6: Testbenches and Simulation

## What is a Testbench?

A **testbench** is a Verilog module that:
- Generates stimulus (test inputs) for your design
- Monitors outputs
- Verifies correct behavior
- Does NOT synthesize to hardware

Think of it as a virtual test lab for your circuit.

## Testbench Structure

```verilog
`timescale 1ns/1ps  // Time unit / Time precision

module testbench_name;
    // 1. Signal declarations
    reg  input_signals;   // Inputs are 'reg' in testbench
    wire output_signals;  // Outputs are 'wire'
    
    // 2. Instantiate DUT (Device Under Test)
    module_name dut (
        .input(input_signals),
        .output(output_signals)
    );
    
    // 3. Clock generation (if needed)
    always #5 clk = ~clk;  // Toggle every 5 time units
    
    // 4. Stimulus generation
    initial begin
        // Test sequence here
    end
    
    // 5. Response checking
    // 6. Reporting
    
endmodule
```

## Basic Example: Testing an AND Gate

```verilog
// DUT: AND gate
module and_gate (
    input  wire a,
    input  wire b,
    output wire y
);
    assign y = a & b;
endmodule

// Testbench
`timescale 1ns/1ps

module and_gate_tb;
    // 1. Declare signals
    reg  a, b;      // Inputs
    wire y;         // Output
    
    // 2. Instantiate DUT
    and_gate dut (
        .a(a),
        .b(b),
        .y(y)
    );
    
    // 3. Stimulus
    initial begin
        // Display header
        $display("Time\ta\tb\ty");
        $display("================");
        
        // Test all combinations
        a = 0; b = 0; #10;
        $display("%0t\t%b\t%b\t%b", $time, a, b, y);
        
        a = 0; b = 1; #10;
        $display("%0t\t%b\t%b\t%b", $time, a, b, y);
        
        a = 1; b = 0; #10;
        $display("%0t\t%b\t%b\t%b", $time, a, b, y);
        
        a = 1; b = 1; #10;
        $display("%0t\t%b\t%b\t%b", $time, a, b, y);
        
        $finish;  // End simulation
    end
    
    // Optional: Generate VCD file for waveform viewing
    initial begin
        $dumpfile("and_gate.vcd");
        $dumpvars(0, and_gate_tb);
    end
endmodule
```

**Expected Output:**
```
Time    a    b    y
================
0       0    0    0
10      0    1    0
20      1    0    0
30      1    1    1
```

## System Tasks

### Display Tasks

| Task | Purpose | Example |
|------|---------|---------|
| `$display` | Print and newline | `$display("Value = %d", val);` |
| `$write` | Print without newline | `$write("x=%d ", x);` |
| `$monitor` | Print on signal change | `$monitor("Time=%0t a=%b", $time, a);` |
| `$strobe` | Print at end of timestep | `$strobe("Final: %d", val);` |

### Format Specifiers

| Specifier | Format | Example |
|-----------|--------|---------|
| `%b` | Binary | `%b` → 1010 |
| `%d` | Decimal (signed) | `%d` → -5 |
| `%h` | Hexadecimal | `%h` → A5 |
| `%o` | Octal | `%o` → 52 |
| `%t` | Time | `%t` → 100 |
| `%0t` | Time (no leading spaces) | `%0t` → 100 |
| `%c` | Character | `%c` → A |
| `%s` | String | `%s` → "hello" |

### Simulation Control

| Task | Purpose |
|------|---------|
| `$finish` | End simulation |
| `$stop` | Pause simulation (interactive) |
| `$time` | Current simulation time |
| `$realtime` | Current time (real number) |

### File Operations

| Task | Purpose | Example |
|------|---------|---------|
| `$dumpfile("file.vcd")` | Specify VCD output file | For GTKWave |
| `$dumpvars(level, module)` | Dump variables | `$dumpvars(0, tb);` |
| `$readmemh("file.hex", mem)` | Read hex file to memory | Load test vectors |
| `$readmemb("file.bin", mem)` | Read binary file to memory | Load test vectors |

## Clock Generation

### Method 1: Using always block

```verilog
reg clk;

initial begin
    clk = 0;
    forever #5 clk = ~clk;  // 10ns period = 100MHz
end
```

### Method 2: Compact form

```verilog
reg clk = 0;
always #5 clk = ~clk;
```

### Method 3: Parameterized

```verilog
parameter CLK_PERIOD = 10;

reg clk = 0;
always #(CLK_PERIOD/2) clk = ~clk;
```

**Timing Diagram:**

```
         ___     ___     ___     ___     ___
clk  ___|   |___|   |___|   |___|   |___|   |___
     0   5   10  15  20  25  30  35  40  45  50

Period = 10ns
Frequency = 1/10ns = 100 MHz
```

## Testing Sequential Circuits

### Example: D Flip-Flop Testbench

```verilog
`timescale 1ns/1ps

module d_ff_tb;
    reg  clk, rst_n, d;
    wire q;
    
    // Instantiate DUT
    d_flipflop_reset dut (
        .clk(clk),
        .rst_n(rst_n),
        .d(d),
        .q(q)
    );
    
    // Clock generation: 100MHz (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Stimulus
    initial begin
        // Initialize signals
        rst_n = 0;
        d = 0;
        
        // Generate VCD for waveform viewer
        $dumpfile("d_ff.vcd");
        $dumpvars(0, d_ff_tb);
        
        // Apply reset
        #15 rst_n = 1;
        
        // Test sequence
        @(posedge clk) d = 1;
        @(posedge clk) d = 0;
        @(posedge clk) d = 1;
        @(posedge clk) d = 1;
        @(posedge clk) d = 0;
        
        // Wait a few cycles
        repeat(5) @(posedge clk);
        
        // Test reset again
        rst_n = 0;
        #20 rst_n = 1;
        
        // Run a bit longer
        #100;
        
        $display("Test completed successfully!");
        $finish;
    end
    
    // Monitor outputs
    initial begin
        $monitor("Time=%0t rst_n=%b d=%b q=%b", $time, rst_n, d, q);
    end
endmodule
```

**Timing Diagram:**

```
Time:      0    10   20   30   40   50   60   70   80
           ___   ___   ___   ___   ___   ___   ___   ___
clk    ___|   |_|   |_|   |_|   |_|   |_|   |_|   |_|   |___
           _________________
rst_n  ___|                 |_________________________________
                   _____         ___________
d      ___________|     |_______|           |_______________
           _________________     _____         ___________
q      ___|                 |___|     |_______|           |___
           ^               ^     ^     ^       ^
           Reset           d=1   d=0   d=1     d=1
           q=0             captured
```

## Using `@` (Event Control)

### Wait for edge

```verilog
@(posedge clk);   // Wait for rising edge
@(negedge clk);   // Wait for falling edge
```

### Wait for signal change

```verilog
@(a or b);        // Wait for a OR b to change
@(*);             // Wait for any signal to change (rare in testbenches)
```

### Wait for specific value

```verilog
wait(ready == 1);  // Wait until ready is 1
```

## Repeat and Delay

```verilog
// Repeat statement
repeat(10) @(posedge clk);  // Wait 10 clock cycles

// Delay
#100;  // Wait 100 time units

// Combining
repeat(5) #10;  // Five 10ns delays
```

## Self-Checking Testbenches

Instead of manually checking, make the testbench verify itself:

```verilog
module adder_tb;
    reg  [3:0] a, b;
    wire [4:0] sum;
    integer errors = 0;
    
    adder_4bit dut (.a(a), .b(b), .sum(sum));
    
    initial begin
        // Test vectors
        test_add(4'd0, 4'd0, 5'd0);
        test_add(4'd5, 4'd3, 5'd8);
        test_add(4'd15, 4'd1, 5'd16);
        test_add(4'd7, 4'd9, 5'd16);
        
        // Report results
        if (errors == 0)
            $display("✓ ALL TESTS PASSED!");
        else
            $display("✗ %0d TESTS FAILED", errors);
        
        $finish;
    end
    
    // Task for testing
    task test_add;
        input [3:0] in_a, in_b;
        input [4:0] expected;
        begin
            a = in_a;
            b = in_b;
            #10;  // Wait for combinational delay
            
            if (sum !== expected) begin
                $display("ERROR: %0d + %0d = %0d (expected %0d)",
                         in_a, in_b, sum, expected);
                errors = errors + 1;
            end else begin
                $display("PASS: %0d + %0d = %0d", in_a, in_b, sum);
            end
        end
    endtask
endmodule
```

## Tasks and Functions

### Tasks (Can have delays)

```verilog
task send_byte;
    input [7:0] data;
    integer i;
    begin
        for (i = 0; i < 8; i = i + 1) begin
            serial_out = data[i];
            @(posedge clk);
        end
    end
endtask

// Usage:
initial begin
    send_byte(8'hA5);
    send_byte(8'h3C);
end
```

### Functions (No delays, must return value)

```verilog
function [7:0] reverse_bits;
    input [7:0] data;
    integer i;
    begin
        for (i = 0; i < 8; i = i + 1)
            reverse_bits[i] = data[7-i];
    end
endfunction

// Usage:
result = reverse_bits(8'b10110011);
```

## Testing an FSM

```verilog
`timescale 1ns/1ps

module sequence_detector_tb;
    reg clk, rst_n, data_in;
    wire detected;
    
    // Instantiate DUT
    sequence_detector_101 dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .detected(detected)
    );
    
    // Clock: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;
    
    // Test sequence
    initial begin
        $dumpfile("seq_det.vcd");
        $dumpvars(0, sequence_detector_tb);
        
        // Initialize
        rst_n = 0;
        data_in = 0;
        
        // Release reset
        #15 rst_n = 1;
        
        // Send sequence: 1-0-1 (should detect)
        @(posedge clk) data_in = 1;
        @(posedge clk) data_in = 0;
        @(posedge clk) data_in = 1;
        @(posedge clk);
        
        // Check detection
        if (detected)
            $display("✓ Sequence 101 detected correctly");
        else begin
            $display("✗ FAILED: Should have detected 101");
            $finish;
        end
        
        // Send non-matching sequence: 1-1-0
        @(posedge clk) data_in = 1;
        @(posedge clk) data_in = 1;
        @(posedge clk) data_in = 0;
        @(posedge clk);
        
        if (!detected)
            $display("✓ Correctly did not detect");
        else begin
            $display("✗ FAILED: False detection");
            $finish;
        end
        
        // Overlapping sequence: 1-0-1-0-1
        @(posedge clk) data_in = 1;
        @(posedge clk) data_in = 0;
        @(posedge clk) data_in = 1;
        @(posedge clk);
        if (detected)
            $display("✓ First 101 detected");
        
        @(posedge clk) data_in = 0;
        @(posedge clk) data_in = 1;
        @(posedge clk);
        if (detected)
            $display("✓ Second overlapping 101 detected");
        
        #50;
        $display("\n✓ ALL FSM TESTS PASSED!");
        $finish;
    end
    
    // Timeout watchdog
    initial begin
        #1000;
        $display("✗ TIMEOUT: Test took too long");
        $finish;
    end
endmodule
```

**Timing Diagram:**

```
Time:     0    10   20   30   40   50   60   70   80
          __   __   __   __   __   __   __   __   __
clk   ___|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |___
          _______________________________________
rst_n ___|
               _____   _________    _____
data_in _______|   |__|         |__|     |____________
               1    0     1       0   1

States:  IDLE GOT_1 GOT_10 GOT_101 GOT_10 GOT_101
                            ^^^^           ^^^^
                         detected!      detected!

            ______________________________   _______
detected __|                              |_|       |___
```

## Generating Random Tests

```verilog
module random_tb;
    reg [7:0] a, b;
    wire [8:0] sum;
    integer i;
    
    adder_8bit dut (.a(a), .b(b), .sum(sum));
    
    initial begin
        // Random seed (use different values for different runs)
        $random(42);
        
        // Run 1000 random tests
        for (i = 0; i < 1000; i = i + 1) begin
            a = $random;
            b = $random;
            #10;
            
            // Check result
            if (sum !== (a + b)) begin
                $display("ERROR at test %0d: %0d + %0d = %0d (expected %0d)",
                         i, a, b, sum, a+b);
                $finish;
            end
        end
        
        $display("✓ All 1000 random tests passed!");
        $finish;
    end
endmodule
```

## Reading Test Vectors from Files

### Create test file: `test_vectors.txt`
```
// Format: a b expected_sum
00 00 000
05 03 008
0F 01 010
FF FF 1FE
```

### Testbench:

```verilog
module adder_file_tb;
    reg  [7:0] a, b;
    reg  [8:0] expected;
    wire [8:0] sum;
    
    adder_8bit dut (.a(a), .b(b), .sum(sum));
    
    integer file, status;
    integer errors = 0;
    
    initial begin
        file = $fopen("test_vectors.txt", "r");
        if (file == 0) begin
            $display("ERROR: Could not open test file");
            $finish;
        end
        
        // Read and apply test vectors
        while (!$feof(file)) begin
            status = $fscanf(file, "%h %h %h\n", a, b, expected);
            if (status == 3) begin  // Successfully read 3 values
                #10;
                if (sum !== expected) begin
                    $display("ERROR: %h + %h = %h (expected %h)",
                             a, b, sum, expected);
                    errors = errors + 1;
                end
            end
        end
        
        $fclose(file);
        
        if (errors == 0)
            $display("✓ All file tests passed!");
        else
            $display("✗ %0d errors found", errors);
        
        $finish;
    end
endmodule
```

## Coverage Analysis

### Functional Coverage Example

```verilog
module coverage_example;
    reg [1:0] sel;
    reg [7:0] a, b, c, d;
    wire [7:0] y;
    
    mux4to1_8bit dut (.sel(sel), .a(a), .b(b), .c(c), .d(d), .y(y));
    
    // Coverage tracking
    integer sel_coverage [0:3];
    integer i;
    
    initial begin
        // Initialize coverage counters
        for (i = 0; i < 4; i = i + 1)
            sel_coverage[i] = 0;
        
        // Run tests
        repeat(100) begin
            sel = $random;
            a = $random; b = $random; c = $random; d = $random;
            #10;
            sel_coverage[sel] = sel_coverage[sel] + 1;
        end
        
        // Report coverage
        $display("\nCoverage Report:");
        for (i = 0; i < 4; i = i + 1) begin
            $display("sel=%0d: %0d tests (%0d%%)",
                     i, sel_coverage[i], sel_coverage[i]);
        end
    end
endmodule
```

## Assertions (Simple Form)

```verilog
// Check conditions during simulation
initial begin
    // Test setup
    a = 5; b = 3;
    #10;
    
    // Assertion: sum should be 8
    if (sum !== 8) begin
        $display("ASSERTION FAILED: sum=%0d (expected 8)", sum);
        $finish;
    end
    
    $display("Assertion passed");
end
```

## Waveform Viewing with VCD

### Generate VCD file:

```verilog
initial begin
    $dumpfile("simulation.vcd");
    $dumpvars(0, testbench_name);  // Dump all signals in testbench
    
    // Or dump specific signals:
    // $dumpvars(1, signal1, signal2, signal3);
end
```

### View with GTKWave:

```bash
# Run simulation
iverilog -o sim design.v testbench.v
vvp sim

# View waveforms
gtkwave simulation.vcd
```

## Common Testbench Patterns

### Pattern 1: Initialize-Test-Check

```verilog
initial begin
    // Initialize
    reset();
    
    // Test
    apply_stimulus();
    
    // Check
    verify_results();
    
    $finish;
end
```

### Pattern 2: Directed Tests + Random

```verilog
initial begin
    // Directed corner cases
    test_corner_cases();
    
    // Random testing
    repeat(1000) random_test();
    
    report_results();
    $finish;
end
```

### Pattern 3: Continuous Monitoring

```verilog
// Separate monitoring block
always @(posedge clk) begin
    if (error_condition) begin
        $display("ERROR detected at time %0t", $time);
        $finish;
    end
end
```

## Best Practices

### ✅ DO:

1. **Use meaningful test names**
```verilog
task test_reset_behavior;
task test_overflow_condition;
```

2. **Include self-checking**
```verilog
if (result !== expected)
    $display("ERROR...");
```

3. **Add timeouts**
```verilog
initial begin
    #100000;  // Maximum test time
    $display("TIMEOUT");
    $finish;
end
```

4. **Generate waveforms for debugging**
```verilog
$dumpfile("wave.vcd");
$dumpvars(0, tb);
```

5. **Test corner cases**
- All zeros
- All ones
- Maximum values
- Minimum values
- Boundary conditions

### ❌ DON'T:

1. **Don't forget to initialize signals**
```verilog
// BAD: uninitialized
reg a, b;

// GOOD: initialized
reg a = 0, b = 0;
```

2. **Don't create race conditions**
```verilog
// BAD: Non-blocking in testbench initial block
initial a <= 1;

// GOOD: Use blocking
initial a = 1;
```

3. **Don't forget $finish**
```verilog
// BAD: simulation never ends
initial begin
    test();
    // Missing $finish!
end
```

## Practice Exercises

### Exercise 1: Counter Testbench
Create a comprehensive testbench for an 8-bit counter with:
- Reset test
- Count sequence verification
- Overflow test

### Exercise 2: FIFO Testbench
Test a FIFO with:
- Full condition
- Empty condition
- Write and read sequences
- Overflow/underflow protection

### Exercise 3: Random Testing
Create a testbench that randomly tests an ALU with:
- 1000 random operations
- Coverage of all opcodes
- Self-checking
- Coverage report

## Summary

In this part, you learned:

- ✅ Testbench structure and components
- ✅ System tasks: `$display`, `$monitor`, `$finish`
- ✅ Clock generation techniques
- ✅ Event controls: `@(posedge clk)`, `wait()`
- ✅ Self-checking testbenches
- ✅ Tasks and functions
- ✅ Random testing
- ✅ File I/O for test vectors
- ✅ VCD waveform generation
- ✅ Coverage analysis
- ✅ Best practices

## What's Next?

In [Part 7: Advanced Topics](./07_Advanced_Topics.md), we'll cover:

- Blocking vs non-blocking in depth
- Race conditions
- Synthesis vs simulation
- Pipelining techniques
- Timing closure
- Industry best practices

**Master the advanced concepts!** 🚀

---

**Ready for advanced topics? Continue to Part 7!**

