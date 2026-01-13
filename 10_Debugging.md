# Part 10: Debugging Techniques

## Introduction

Debugging is where you'll spend much of your time as a hardware designer. Unlike software where you can add print statements anywhere, hardware debugging requires different techniques.

**The Golden Rule**: Prevention is better than cure. Good design practices prevent 90% of bugs.

## Categories of Bugs

### 1. Syntax Errors (Easy)
- Caught by compiler
- Missing semicolons, endmodule, etc.
- Mismatched brackets

### 2. Functional Errors (Medium)
- Logic works differently than intended
- Wrong algorithm or formula
- Incorrect state machine transitions

### 3. Timing Errors (Hard)
- Setup/hold violations
- Race conditions
- Metastability issues
- Clock domain crossing problems

### 4. Synthesis-Simulation Mismatches (Tricky)
- Works in simulation, fails in hardware
- Usually latches or unsynthesizable code

## Systematic Debugging Process

```
1. Reproduce the bug reliably
   ↓
2. Isolate the problem (which module?)
   ↓
3. Understand the expected behavior
   ↓
4. Observe actual behavior (waveforms!)
   ↓
5. Form hypothesis about cause
   ↓
6. Test hypothesis
   ↓
7. Fix and verify
   ↓
8. Test regression (didn't break anything else?)
```

## Debugging Tools and Techniques

### 1. $display Debugging

The simplest but most effective technique:

```verilog
module counter_debug (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       enable,
    output reg  [7:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 8'h00;
            $display("[%0t] RESET: count = %0d", $time, count);
        end else if (enable) begin
            count <= count + 1;
            $display("[%0t] INCREMENT: count = %0d -> %0d", 
                     $time, count, count + 1);
        end else begin
            $display("[%0t] HOLD: count = %0d", $time, count);
        end
    end
endmodule
```

**Tips:**
- Use `%0t` for time without leading spaces
- Print before and after values
- Include context (state name, module path)
- Disable debug prints with `ifdef

```verilog
`ifdef DEBUG
    $display("Debug info: %d", value);
`endif
```

### 2. $monitor for Continuous Tracking

```verilog
initial begin
    $monitor("Time=%0t clk=%b rst=%b state=%b output=%h", 
             $time, clk, rst_n, state, output_signal);
end
```

**When to use:**
- Tracking signals that change infrequently
- Watching state machine transitions
- Monitoring control signals

**Don't use for:**
- High-frequency signals (too much output)
- Large buses

### 3. Waveform Debugging (Most Powerful!)

Generate VCD files and use GTKWave:

```verilog
initial begin
    $dumpfile("debug.vcd");
    $dumpvars(0, top_module);  // Dump all signals in top_module
    
    // Or dump specific signals:
    // $dumpvars(1, signal1, signal2, signal3);
end
```

**Waveform Analysis Workflow:**

```
1. Identify when problem occurs (timestamp)
2. Zoom in to that area
3. Check clock edges - are transitions aligned?
4. Trace backward from output to input
5. Look for:
   - Signals at wrong values
   - Transitions at wrong times
   - Glitches (brief unwanted pulses)
   - X (unknown) or Z (high-impedance) values
```

### 4. Assertions

Check conditions during simulation:

```verilog
module fifo_with_assertions (
    input  wire       clk,
    input  wire       wr_en,
    input  wire       rd_en,
    output wire       full,
    output wire       empty
);
    // ... FIFO logic ...
    
    // Assertions
    always @(posedge clk) begin
        // Can't be both full and empty
        if (full && empty) begin
            $display("ERROR: FIFO is both full and empty!");
            $finish;
        end
        
        // Don't write when full
        if (full && wr_en) begin
            $display("WARNING: Write attempted when FIFO is full");
        end
        
        // Don't read when empty
        if (empty && rd_en) begin
            $display("WARNING: Read attempted when FIFO is empty");
        end
    end
endmodule
```

### 5. Code Coverage

Track which parts of code were exercised:

```verilog
// In testbench
integer state_coverage [0:3];

initial begin
    state_coverage[0] = 0;
    state_coverage[1] = 0;
    state_coverage[2] = 0;
    state_coverage[3] = 0;
end

always @(posedge clk) begin
    state_coverage[current_state] = state_coverage[current_state] + 1;
end

// At end of simulation
initial begin
    #10000;  // Run for 10000 time units
    
    $display("\n=== Coverage Report ===");
    for (int i = 0; i < 4; i = i + 1) begin
        if (state_coverage[i] == 0)
            $display("WARNING: State %0d never visited!", i);
        else
            $display("State %0d visited %0d times", i, state_coverage[i]);
    end
end
```

## Common Bug Patterns and Solutions

### Bug 1: Unintentional Latches

**Symptom:** Synthesis warnings about inferred latches

**Example:**

```verilog
// ❌ BUG: Creates latch
always @(*) begin
    if (enable)
        out = data;
    // Missing else - out retains value!
end
```

**Waveform signature:**
```
enable: ___┌───┐___┌───┐___
data:   ───<A>─<B>─<C>───
out:    ───<A>─────<C>───  ← Holds 'A' when enable=0
                             (should change to 'C')
```

**Fix:**

```verilog
// ✓ FIXED
always @(*) begin
    if (enable)
        out = data;
    else
        out = 8'h00;  // Explicit default
end
```

### Bug 2: Blocking vs Non-Blocking Mixup

**Symptom:** Wrong values, doesn't shift properly

**Example:**

```verilog
// ❌ BUG: Using blocking in sequential
always @(posedge clk) begin
    a = b;  // Blocking
    c = a;  // Gets NEW value of a!
end
```

**Waveform signature:**
```
clk: ___┌┐___┌┐___┌┐___
b:   ───<1>───<2>───<3>
a:   ───────<1>───<2>───  ← Updates immediately
c:   ───────<1>───<2>───  ← Should lag by one cycle!
```

**Fix:**

```verilog
// ✓ FIXED
always @(posedge clk) begin
    a <= b;  // Non-blocking
    c <= a;  // Uses OLD value of a
end
```

**Correct waveform:**
```
clk: ___┌┐___┌┐___┌┐___
b:   ───<1>───<2>───<3>
a:   ───────<1>───<2>───
c:   ───────────<1>───<2> ← Properly delayed
```

### Bug 3: Race Conditions

**Symptom:** Non-deterministic behavior, works sometimes

**Example:**

```verilog
// ❌ BUG: Multiple drivers, order-dependent
always @(posedge clk) begin
    shared_sig = data1;
end

always @(posedge clk) begin
    shared_sig = data2;  // Which wins?
end
```

**Fix:**

```verilog
// ✓ FIXED: Single driver
always @(posedge clk) begin
    if (select)
        shared_sig <= data1;
    else
        shared_sig <= data2;
end
```

### Bug 4: Setup/Hold Violations

**Symptom:** Works in simulation, fails in hardware

**Example:**

```verilog
// ❌ BUG: Combinational path too long
always @(posedge clk) begin
    a <= b;
end

assign c = a + d + e + f + g;  // Long path

always @(posedge clk) begin
    result <= c;  // Might not meet timing!
end
```

**Timing diagram showing violation:**
```
clk:    ___┌┐______┌┐______
a:      ───<X>──────────────
              └──────┐ (propagation through add logic)
c:      ──────────<Y>──────
                     ^
                     | Too close to next clock edge!
result: ──────────────????  Setup violation!
```

**Fix: Add pipeline stage**

```verilog
// ✓ FIXED: Pipeline to meet timing
always @(posedge clk) begin
    a <= b;
    temp <= a + d;  // Stage 1
end

always @(posedge clk) begin
    result <= temp + e + f + g;  // Stage 2
end
```

### Bug 5: Clock Domain Crossing Without Synchronizer

**Symptom:** Metastability, random bit flips

**Example:**

```verilog
// ❌ BUG: Direct crossing
always @(posedge clk_b) begin
    data_b <= data_a;  // data_a is in clk_a domain!
end
```

**Waveform showing metastability:**
```
clk_a:  ___┌┐___┌┐___┌┐___
data_a: ───<1>─────────────
clk_b:  _____┌┐___┌┐___┌┐_
              ^
              | Transition during sampling!
data_b: ─────<?>──────────  Could be 0, 1, or metastable!
```

**Fix: Use 2-FF synchronizer**

```verilog
// ✓ FIXED
reg sync1, sync2;

always @(posedge clk_b) begin
    sync1 <= data_a;   // May be metastable
    sync2 <= sync1;    // Stable by now
end
```

### Bug 6: Off-by-One Errors

**Symptom:** Counter goes one too far, array out of bounds

**Example:**

```verilog
// ❌ BUG: Counter counts 0-10 (11 values!)
always @(posedge clk) begin
    if (count <= 10)
        count <= count + 1;
    else
        count <= 0;
end
```

**Fix:**

```verilog
// ✓ FIXED: Counts 0-9 (10 values)
always @(posedge clk) begin
    if (count == 9)
        count <= 0;
    else
        count <= count + 1;
end
```

### Bug 7: X Propagation

**Symptom:** Output shows 'x' in simulation

**Example:**

```verilog
reg [7:0] mem [0:255];
wire [7:0] data = mem[addr];  // mem not initialized!
```

**Waveform:**
```
addr: ──<0>──<1>──<2>──
data: ──<x>──<x>──<x>──  ← Uninitialized memory
```

**Fix:**

```verilog
initial begin
    for (int i = 0; i < 256; i++)
        mem[i] = 8'h00;
end
```

## Debugging FSMs

### Add State Visualization

```verilog
// For simulation debugging
always @(*) begin
    case (state)
        IDLE:   $write("IDLE   ");
        START:  $write("START  ");
        RUN:    $write("RUN    ");
        STOP:   $write("STOP   ");
        default: $write("UNKNOWN");
    endcase
end
```

### State Machine Assertions

```verilog
always @(posedge clk) begin
    // Check for illegal transitions
    case (state)
        IDLE: begin
            if (next_state != IDLE && next_state != START) begin
                $display("ERROR: Illegal transition from IDLE to %b", next_state);
                $finish;
            end
        end
        // ... check other states ...
    endcase
    
    // Check for stuck state
    if (state_counter > 1000) begin
        $display("WARNING: Stuck in state %b for %0d cycles", state, state_counter);
    end
end
```

## Simulation vs Synthesis Mismatches

### Common Causes:

1. **Initial blocks** (simulation only)
```verilog
// Works in sim, not in hardware
initial a = 0;  // No initialization in FPGA!
```

2. **Delays** (ignored by synthesis)
```verilog
assign #5 y = a & b;  // Delay ignored in synthesis
```

3. **Incomplete sensitivity lists**
```verilog
// Simulation: only triggers on 'a'
// Synthesis: triggers on 'a' and 'b'
always @(a) begin
    out = a & b;  // Synthesis warning
end

// Fix: Use always @(*)
```

4. **X and Z handling**
```verilog
if (signal == 1'bx)  // Works in sim, meaningless in hardware
```

## Advanced Debugging Techniques

### Signature Analysis

Compress large data streams into small signatures:

```verilog
module signature_analyzer (
    input wire clk,
    input wire data_in,
    output reg [15:0] signature
);
    always @(posedge clk) begin
        signature <= {signature[14:0], data_in ^ signature[15]};
    end
endmodule
```

Compare signatures between simulation and hardware to find mismatches.

### Trigger-Based Debugging

```verilog
reg [31:0] cycles_since_trigger;

always @(posedge clk) begin
    if (trigger_condition) begin
        cycles_since_trigger <= 0;
        $display("TRIGGER at time %0t", $time);
    end else begin
        cycles_since_trigger <= cycles_since_trigger + 1;
    end
    
    // Capture data around trigger
    if (cycles_since_trigger < 100) begin
        $display("  [+%0d] signal=%h", cycles_since_trigger, signal);
    end
end
```

### Debugging Checklist

Before asking for help, check:

```
□ Does it compile without errors?
□ Does it compile without warnings?
□ Did you check the waveforms?
□ Did you verify reset behavior?
□ Did you test boundary conditions?
□ Are all signals initialized?
□ Did you check for latches?
□ Are you using non-blocking in sequential logic?
□ Are you using blocking in combinational logic?
□ Did you test with different clock speeds?
□ Does it work with random inputs?
□ Did you check for race conditions?
□ Are there any 'x' or 'z' values in simulation?
□ Did you verify timing with synthesis tools?
```

## Tools and Workflows

### 1. Icarus Verilog + GTKWave

```bash
# Compile with debug info
iverilog -g2009 -o sim design.v testbench.v

# Run simulation
vvp sim

# View waveforms
gtkwave dump.vcd
```

### 2. Using Makefiles

Create `Makefile`:
```makefile
SIM = iverilog
SIMFLAGS = -g2009
VIEWER = gtkwave

# Default target
all: simulate

# Compile
compile:
	$(SIM) $(SIMFLAGS) -o sim.vvp $(RTL) $(TB)

# Run simulation
simulate: compile
	vvp sim.vvp

# View waveforms
view:
	$(VIEWER) dump.vcd &

# Clean
clean:
	rm -f *.vvp *.vcd

.PHONY: all compile simulate view clean
```

### 3. Regression Testing

```bash
#!/bin/bash
# run_tests.sh

PASS=0
FAIL=0

for test in tests/*.v; do
    echo "Running $test..."
    iverilog -o test.vvp design.v "$test"
    if vvp test.vvp | grep -q "PASS"; then
        ((PASS++))
        echo "✓ PASSED"
    else
        ((FAIL++))
        echo "✗ FAILED"
    fi
done

echo ""
echo "Results: $PASS passed, $FAIL failed"
```

## Best Practices to Prevent Bugs

### 1. Consistent Coding Style

```verilog
// Good template
module my_module (
    input  wire       clk,
    input  wire       rst_n,  // Active low reset
    input  wire [7:0] data_in,
    output reg  [7:0] data_out
);

    // Parameters
    localparam STATE_IDLE = 2'b00;
    
    // Internal signals
    reg [1:0] state, next_state;
    
    // Sequential logic
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= STATE_IDLE;
        else
            state <= next_state;
    end
    
    // Combinational logic
    always @(*) begin
        next_state = state;  // Default
        case (state)
            // ... state machine ...
        endcase
    end
    
endmodule
```

### 2. Self-Checking Testbenches

```verilog
task check_result;
    input [7:0] expected;
    input [7:0] actual;
    input [255:0] test_name;
    begin
        if (actual !== expected) begin
            $display("✗ FAIL: %s", test_name);
            $display("  Expected: %h, Got: %h", expected, actual);
            error_count = error_count + 1;
        end else begin
            $display("✓ PASS: %s", test_name);
        end
    end
endtask
```

### 3. Defensive Coding

```verilog
// Add default cases
case (opcode)
    OP_ADD: result = a + b;
    OP_SUB: result = a - b;
    default: begin
        result = 8'h00;
        $display("ERROR: Unknown opcode %b", opcode);
    end
endcase

// Check ranges
if (addr >= MEMORY_SIZE) begin
    $display("ERROR: Address out of range");
    addr = 0;
end
```

## Summary

In this part, you learned:

- ✅ Systematic debugging process
- ✅ Common bug patterns and how to spot them
- ✅ Using $display and $monitor effectively
- ✅ Waveform analysis techniques
- ✅ Assertions for catching bugs early
- ✅ Fixing timing violations
- ✅ Debugging FSMs
- ✅ Simulation vs synthesis mismatches
- ✅ Best practices to prevent bugs
- ✅ Tool workflows

## Remember:

1. **Read the warnings!** Most bugs are warned about
2. **Use waveforms** - they show the truth
3. **Test incrementally** - don't write 1000 lines then test
4. **Think in hardware** - not software
5. **When stuck**, explain the problem out loud (rubber duck debugging)

---

**You now have a complete Verilog tutorial from basics to advanced debugging!** 

Keep practicing, keep debugging, and keep building! 🚀

