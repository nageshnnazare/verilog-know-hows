# Part 4: Sequential Logic and Timing

## Introduction to Sequential Logic

**Sequential logic** has **memory** - outputs depend on current inputs AND past history.

### Combinational vs Sequential

| Combinational | Sequential |
|---------------|------------|
| No memory | Has memory |
| Output = f(inputs) | Output = f(inputs, state) |
| No clock needed | Clock driven |
| Examples: AND gate, Mux | Examples: Flip-flop, Counter |

### Key Concepts in Sequential Logic

1. **Storage Elements**: Flip-flops and latches
2. **Clock**: Synchronizes operations
3. **State**: Information remembered from the past
4. **Timing**: Setup, hold, clock-to-Q delays

## The Clock Signal

The clock is the heartbeat of sequential circuits:

```
        ___     ___     ___     ___     ___
clk ___|   |___|   |___|   |___|   |___|   |___

      ↑     ↑     ↑     ↑     ↑
   Positive edges (posedge)
   
        ___     ___     ___     ___     ___
clk ___|   |___|   |___|   |___|   |___|   |___
         ↓     ↓     ↓     ↓     ↓
      Negative edges (negedge)

     <---->
  Clock Period (Tclk)

Frequency = 1 / Tclk
Example: Tclk = 10ns → f = 100MHz
```

### Clock Properties

- **Period (Tclk)**: Time for one complete cycle
- **Frequency (f)**: f = 1/Tclk
- **Duty Cycle**: % of time clock is HIGH
  - 50% duty cycle: HIGH time = LOW time

## Flip-Flops: The Basic Storage Element

### D Flip-Flop (Most Common)

The D flip-flop captures the input (D) on a clock edge and holds it:

```verilog
module d_flipflop (
    input  wire clk,
    input  wire d,
    output reg  q
);
    // Positive edge-triggered
    always @(posedge clk) begin
        q <= d;  // Non-blocking assignment
    end
endmodule
```

**Timing Diagram:**

```
Time:     0ns    5ns    10ns   15ns   20ns   25ns   30ns
          ___     ___     ___     ___     ___     ___
clk   ___|   |___|   |___|   |___|   |___|   |___|   |___
          _______         ___________         _______
d     ___|       |_______|           |_______|       |___
          _______         ___________         _______
q     ___|       |_______|           |_______|       |___
          ^       ^       ^           ^       ^
          |       |       |           |       |
        Edge    q=0     q=1         q=1     q=0
        but             captures            captures
        no              d at                d at
        change          10ns               20ns

Key Points:
- q changes ONLY on rising clock edge (posedge)
- q holds its value between clock edges
- Changes in d between clock edges don't affect q
```

### D Flip-Flop with Asynchronous Reset

Most flip-flops have a reset signal:

```verilog
module d_flipflop_reset (
    input  wire clk,
    input  wire rst_n,  // Active-low reset
    input  wire d,
    output reg  q
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 1'b0;  // Asynchronous reset
        else
            q <= d;
    end
endmodule
```

**Timing Diagram:**

```
Time:     0ns    5ns    10ns   15ns   20ns   25ns   30ns
          ___________________________     ___     ___
rst_n ___|                           |___|   |___|   |___
          ___     ___     ___     ___     ___     ___
clk   ___|   |___|   |___|   |___|   |___|   |___|   |___
          _______________     ___________     _______
d     ___|               |___|           |___|       |___
          _______________________________         ___
q     ___|                               |_______|   |___
          ^                               ^       ^
          |                               |       |
      rst_n=0                          posedge posedge
      forces q=0                        clk    clk
      immediately                       q=d    q=d

Key Points:
- When rst_n=0, q immediately becomes 0 (asynchronous)
- Reset happens regardless of clock
- After reset released, q follows d on clock edges
```

### D Flip-Flop with Synchronous Reset

```verilog
module d_flipflop_sync_reset (
    input  wire clk,
    input  wire rst,    // Synchronous reset
    input  wire d,
    output reg  q
);
    always @(posedge clk) begin
        if (rst)
            q <= 1'b0;  // Synchronous reset
        else
            q <= d;
    end
endmodule
```

**Timing Diagram:**

```
Time:     0ns    5ns    10ns   15ns   20ns   25ns   30ns
          ___________________________     ___________
rst   ___|                           |___|           |___
          ___     ___     ___     ___     ___     ___
clk   ___|   |___|   |___|   |___|   |___|   |___|   |___
          _______________     ___________     _______
d     ___|               |___|           |___|       |___
          ___________________         ___________
q     ___|                   |_______|           |_______
                              ^       ^           ^
                              |       |           |
                          posedge posedge     posedge
                          rst=1   rst=0       rst=1
                          q=0     q=d         q=0

Key Points:
- Reset only takes effect on clock edge (synchronous)
- Better for timing closure
- More predictable behavior
```

### D Flip-Flop with Enable

```verilog
module d_flipflop_enable (
    input  wire clk,
    input  wire en,     // Enable
    input  wire d,
    output reg  q
);
    always @(posedge clk) begin
        if (en)
            q <= d;     // Update when enabled
        // else q keeps its current value
    end
endmodule
```

**Timing Diagram:**

```
Time:     0ns    5ns    10ns   15ns   20ns   25ns   30ns
          ___     _______________     _______________
en    ___|   |___|               |___|               |___
          ___     ___     ___     ___     ___     ___
clk   ___|   |___|   |___|   |___|   |___|   |___|   |___
          _______     ___________     ___________
d     ___|   0   |___|     1     |___|     0     |_______
          _______     ___________         ___________
q     ___|   0   |___|     1     |_______|     0     |___
          ^       ^       ^       ^       ^       ^
          |       |       |       |       |       |
        en=1    en=0    en=1    en=1    en=0    en=1
        q=d     q keeps q=d     q=d     q keeps q=d
                value                   value

Key Point: When en=0, q holds its value even on clock edges
```

## Registers (Multi-bit Flip-Flops)

A register is a collection of flip-flops:

```verilog
module register_8bit (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [7:0]  d,
    output reg  [7:0]  q
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 8'h00;
        else
            q <= d;
    end
endmodule
```

**Timing Diagram:**

```
Time:       0ns          10ns         20ns         30ns
            ___________________________     ___     ___
rst_n   ___|                           |___|   |___|   |___
            ___           ___           ___           ___
clk     ___|   |_________|   |_________|   |_________|   |___
            _______________     _______________     _______
d[7:0]: ___|    8'hAA      |___|    8'h55      |___|  8'hCC |___
            _______________                 _______________
q[7:0]: ___|    8'h00      |_______________|    8'h55      |___
            ^               ^                   ^
            |               |                   |
         Reset           Capture             Capture
         q=0             q=AA               q=55
```

## Shift Registers

Shift registers move data through a chain of flip-flops:

### Serial-In Serial-Out (SISO)

```verilog
module shift_register_4bit (
    input  wire clk,
    input  wire rst_n,
    input  wire serial_in,
    output wire serial_out
);
    reg [3:0] shift_reg;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            shift_reg <= 4'b0000;
        else
            shift_reg <= {shift_reg[2:0], serial_in};  // Shift left
    end
    
    assign serial_out = shift_reg[3];  // Output MSB
endmodule
```

**Timing Diagram:**

```
Time:     0    5    10   15   20   25   30   35   40
          __________________________________________
rst_n ___|
          __   __   __   __   __   __   __   __   __
clk   ___|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |___
          _______ _______ _______
serial_in|___1___|___0___|___1___|___0_______________

Internal shift_reg evolution:
Time:     Content
0ns:      4'b0000  (after reset)
5ns:      4'b0001  (shifted in: 1)
10ns:     4'b0010  (shifted in: 0, previous 1 moved)
15ns:     4'b0101  (shifted in: 1)
20ns:     4'b1010  (shifted in: 0)
25ns:     4'b0100  (shifted in: 0)
30ns:     4'b1000  (shifted in: 0)
35ns:     4'b0000  (shifted in: 0)

          ___________________________
serial_out                           |_______________
          ^                           ^
          Initial                  First bit
          value                   exits after
                                  4 clock cycles
```

### Parallel-In Serial-Out (PISO)

```verilog
module piso_8bit (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       load,        // Load parallel data
    input  wire [7:0] parallel_in,
    output wire       serial_out
);
    reg [7:0] shift_reg;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            shift_reg <= 8'h00;
        else if (load)
            shift_reg <= parallel_in;  // Parallel load
        else
            shift_reg <= {shift_reg[6:0], 1'b0};  // Shift left
    end
    
    assign serial_out = shift_reg[7];
endmodule
```

## Counters

Counters are essential sequential circuits:

### 4-bit Up Counter

```verilog
module counter_4bit (
    input  wire       clk,
    input  wire       rst_n,
    output reg  [3:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'h0;
        else
            count <= count + 1;  // Increment
    end
endmodule
```

**Timing Diagram:**

```
Time:     0ns   10ns  20ns  30ns  40ns  50ns  60ns  70ns  80ns
          _____________________________________________________
rst_n ___|
          ___   ___   ___   ___   ___   ___   ___   ___   ___
clk   ___|   |_|   |_|   |_|   |_|   |_|   |_|   |_|   |_|   |___
          _____ _____ _____ _____ _____ _____ _____ _____ _____
count |_0_|_1_|_2_|_3_|_4_|_5_|_6_|_7_|_8_|_9_|_A_|_B_|_C_|_D_|___

Binary count sequence:
0: 4'b0000
1: 4'b0001
2: 4'b0010
3: 4'b0011
...
15: 4'b1111
0: 4'b0000 (wraps around)
```

### Modulo-N Counter (Counts 0 to N-1)

```verilog
module counter_mod10 (
    input  wire       clk,
    input  wire       rst_n,
    output reg  [3:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'h0;
        else if (count == 4'd9)
            count <= 4'h0;  // Wrap at 10
        else
            count <= count + 1;
    end
endmodule
```

**Timing Diagram:**

```
Time:     0    10   20   30   40   50   60   70   80   90  100  110
          __________________________________________________________
rst_n ___|
          __   __   __   __   __   __   __   __   __   __   __   __
clk   ___|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |___
       ___ ___ ___ ___ ___ ___ ___ ___ ___ ___ ___ ___
count |_0_|_1_|_2_|_3_|_4_|_5_|_6_|_7_|_8_|_9_|_0_|_1_|___
                                              ^
                                              Wraps to 0 after 9
```

### Up/Down Counter

```verilog
module counter_updown_8bit (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       up,        // 1=count up, 0=count down
    output reg  [7:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 8'h00;
        else if (up)
            count <= count + 1;
        else
            count <= count - 1;
    end
endmodule
```

## Critical Timing Concepts

### Setup Time (tsu)

**Setup Time**: Minimum time data must be stable BEFORE the clock edge.

```
        |<--- tsu --->|
                      ___
data ________XXXXXX===|===================================
                      ^
                    __|___
clk ________________|     |_________________________________
                      ^
                      Clock edge

Data must be stable for tsu before clock edge
```

### Hold Time (th)

**Hold Time**: Minimum time data must remain stable AFTER the clock edge.

```
                      |<--- th --->|
                      ___
data ================|===XXXXXX________________________
                      ^
                    __|___
clk ________________|     |_________________________________
                      ^
                      Clock edge

Data must remain stable for th after clock edge
```

### Clock-to-Q Delay (tcq)

**Clock-to-Q**: Time from clock edge to output change.

```
                    __|___
clk ________________|     |_________________________________
                      ^
                      |<----- tcq ----->|
                         ___________________
q   ____________________|                    _______________

Output changes tcq after clock edge
```

### Complete Timing Example

```verilog
// Two flip-flops with combinational logic between them
module timing_example (
    input  wire clk,
    input  wire d,
    output wire q2
);
    reg q1;
    wire combo_out;
    reg q2_reg;
    
    // First flip-flop
    always @(posedge clk) begin
        q1 <= d;
    end
    
    // Combinational logic
    assign combo_out = ~q1;  // Inverter
    
    // Second flip-flop
    always @(posedge clk) begin
        q2_reg <= combo_out;
    end
    
    assign q2 = q2_reg;
endmodule
```

**Detailed Timing Diagram:**

```
Time:     0    2    4    6    8    10   12   14   16   18
          __________   __________   __________   __________
clk   ___|          |_|          |_|          |_|          |___
          _______________________________________________
d     ___|                                               |_____
          |<-tsu->|  |<-th->|
                 __|___________________________________________
q1    __________|                                             |___
                    ^
                    tcq (clock-to-q delay)
                    
          _________    _______________________________________
combo             |__|
                    ^
                    tpd (propagation delay of inverter)
                    
                        |<-tsu->|  |<-th->|
                               __|_________________________
q2    ____________________|                                   |___
                              ^
                              tcq

Timing constraints:
1. d must be stable tsu before posedge clk
2. d must remain stable th after posedge clk
3. q1 changes tcq after posedge clk
4. combo_out changes tpd after q1 changes
5. For q2 to capture correctly:
   tcq(q1) + tpd(combo) + tsu(q2) < Tclk
   
This is the CRITICAL PATH timing equation!
```

### Maximum Clock Frequency

The maximum frequency is limited by the critical path:

```
Tclk_min = tcq + tpd_logic + tsu + tskew

Where:
- tcq: Clock-to-Q delay of source flip-flop
- tpd_logic: Propagation delay through combinational logic
- tsu: Setup time of destination flip-flop  
- tskew: Clock skew (difference in clock arrival times)

fmax = 1 / Tclk_min
```

**Example Calculation:**

```
Given:
- tcq = 0.5ns
- tpd_logic = 3.0ns (through adder and mux)
- tsu = 0.3ns
- tskew = 0.2ns

Tclk_min = 0.5 + 3.0 + 0.3 + 0.2 = 4.0ns
fmax = 1 / 4.0ns = 250 MHz
```

## Blocking vs Non-Blocking Assignments

**THIS IS CRITICAL - Most common source of bugs!**

### Non-Blocking (<=)  - USE FOR SEQUENTIAL LOGIC

```verilog
always @(posedge clk) begin
    a <= b;
    c <= a;  // Uses OLD value of a
end
```

**Behavior:**
- All assignments happen "simultaneously" at the end of the time step
- Models hardware registers correctly
- Right side evaluated first, then all left sides updated

**Timing:**

```
Time:     0ns         10ns        20ns
          ___           ___           ___
clk   ___|   |_______|   |_______|   |___

Before clock edge:
b = 1
a = 0  
c = 0

At posedge (10ns):
a <= b  means a_next = 1 (current b)
c <= a  means c_next = 0 (current a, OLD value!)

After clock edge:
a = 1
c = 0

At posedge (20ns):
a <= b  means a_next = 1
c <= a  means c_next = 1 (now gets previous a)

After clock edge:
a = 1
c = 1
```

### Blocking (=) - USE FOR COMBINATIONAL LOGIC

```verilog
always @(*) begin
    a = b;
    c = a;  // Uses NEW value of a
end
```

**Behavior:**
- Assignments happen sequentially (like software)
- Evaluated in order, top to bottom
- Models combinational logic

**Example: Shift Register**

```verilog
// WRONG - Using blocking in sequential logic
module shift_wrong (
    input  wire clk,
    input  wire d,
    output wire q2
);
    reg q0, q1;
    
    always @(posedge clk) begin
        q0 = d;    // BLOCKING
        q1 = q0;   // Gets NEW q0!
    end
    
    assign q2 = q1;
endmodule
```

**Problem:**

```
Time:     0ns         10ns        20ns
          ___           ___           ___
clk   ___|   |_______|   |_______|   |___
          _______________
d     ___|               |_______________
          _______________
q0    ___|               |_______________  (correct)
          _______________
q1    ___|               |_______________  (WRONG! Should delay)

Both change at once - NO shift register behavior!
```

**Correct - Using non-blocking:**

```verilog
module shift_correct (
    input  wire clk,
    input  wire d,
    output wire q2
);
    reg q0, q1;
    
    always @(posedge clk) begin
        q0 <= d;    // NON-BLOCKING
        q1 <= q0;   // Gets OLD q0
    end
    
    assign q2 = q1;
endmodule
```

**Timing:**

```
Time:     0ns         10ns        20ns        30ns
          ___           ___           ___           ___
clk   ___|   |_______|   |_______|   |_______|   |___
          _______________
d     ___|               |_________________________________
          _______________
q0    ___________|               |_______________________
                        _______________
q1    ____________________|               |_______________

Correct shift behavior - data moves through pipeline
```

### Golden Rules

1. **Sequential logic (`always @(posedge clk)`)**: Use `<=` (non-blocking)
2. **Combinational logic (`always @(*)`)**: Use `=` (blocking)
3. **Never mix** blocking and non-blocking in the same always block
4. **Never assign** the same signal in multiple always blocks

## Metastability and Clock Domain Crossing

### Metastability

When setup/hold times are violated, flip-flop can enter **metastable state**:

```
        Undefined voltage level
                |
        ________|________
              ??
        ___________  _____   Stable states
                   \/
              
Output might oscillate or take long time to settle!
```

### Clock Domain Crossing (CDC)

When signals cross between different clock domains:

```verilog
// UNSAFE - No synchronization
module unsafe_cdc (
    input  wire clk_a,
    input  wire clk_b,
    input  wire data_a,
    output reg  data_b
);
    // WRONG: data_a is in clk_a domain
    always @(posedge clk_b) begin
        data_b <= data_a;  // Metastability risk!
    end
endmodule
```

**Solution: Two-Flop Synchronizer**

```verilog
module synchronizer (
    input  wire clk_b,
    input  wire rst_n,
    input  wire async_in,  // From different clock domain
    output reg  sync_out
);
    reg sync_ff1;  // First stage
    
    always @(posedge clk_b or negedge rst_n) begin
        if (!rst_n) begin
            sync_ff1 <= 1'b0;
            sync_out <= 1'b0;
        end else begin
            sync_ff1 <= async_in;    // First FF might be metastable
            sync_out <= sync_ff1;    // Second FF has time to settle
        end
    end
endmodule
```

**Timing:**

```
                 Metastability!
                      ??
         ______________|______________
async_in               |              |_______________
         ___________________________
clk_b ___|   |_|   |_|   |_|   |_|   |_|   |___
         _____________??_____
sync_ff1              |?????|___________________________
                            ___________________________
sync_out ___________________|

First FF might be metastable, but has full clock period to settle
Second FF captures stable value
```

## Best Practices for Sequential Logic

### ✅ DO:

1. **Use non-blocking assignments for sequential logic**
```verilog
always @(posedge clk) begin
    q <= d;  // ✓
end
```

2. **Include reset in sequential logic**
```verilog
always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        q <= 1'b0;
    else
        q <= d;
end
```

3. **Synchronize signals crossing clock domains**
```verilog
// Use 2-FF synchronizer
```

4. **Use separate always blocks for different clock domains**
```verilog
always @(posedge clk_a) begin
    // clk_a domain logic
end

always @(posedge clk_b) begin
    // clk_b domain logic
end
```

### ❌ DON'T:

1. **Don't mix blocking and non-blocking**
```verilog
always @(posedge clk) begin
    a <= b;   // Non-blocking
    c = a;    // Blocking - WRONG!
end
```

2. **Don't use combinational logic on clock**
```verilog
always @(posedge (clk & enable)) begin  // WRONG!
    // Use enable signal inside always block instead
end
```

3. **Don't create unintentional latches**
```verilog
always @(posedge clk) begin
    if (en)
        q <= d;
    // Missing else - creates latch! Use explicit else or default values
end
```

## Practice Exercises

### Exercise 1: 8-bit Register with Load Enable
Create an 8-bit register that only loads new data when the enable signal is high.

### Exercise 2: Ring Counter
Create a 4-bit ring counter (one-hot counter: 0001 → 0010 → 0100 → 1000 → 0001).

### Exercise 3: Frequency Divider
Create a circuit that divides the input clock frequency by 4.

### Exercise 4: FIFO Buffer
Create a simple 4-entry, 8-bit FIFO (First-In-First-Out) buffer with write/read enables and full/empty flags.

## Solutions

<details>
<summary>Exercise 1 Solution</summary>

```verilog
module register_with_enable (
    input  wire        clk,
    input  wire        rst_n,
    input  wire        load_en,
    input  wire [7:0]  d,
    output reg  [7:0]  q
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 8'h00;
        else if (load_en)
            q <= d;
    end
endmodule
```
</details>

<details>
<summary>Exercise 2 Solution</summary>

```verilog
module ring_counter (
    input  wire       clk,
    input  wire       rst_n,
    output reg  [3:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 4'b0001;  // Initialize to 0001
        else
            count <= {count[2:0], count[3]};  // Rotate left
    end
endmodule
```
</details>

<details>
<summary>Exercise 3 Solution</summary>

```verilog
module clock_divider_by_4 (
    input  wire clk_in,
    input  wire rst_n,
    output reg  clk_out
);
    reg [1:0] counter;
    
    always @(posedge clk_in or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 2'b00;
            clk_out <= 1'b0;
        end else begin
            counter <= counter + 1;
            if (counter == 2'b01)
                clk_out <= ~clk_out;  // Toggle every 2 clocks
        end
    end
endmodule
```
</details>

## Summary

In this part, you learned:

- ✅ Flip-flops are the basic storage elements
- ✅ Clock signals synchronize sequential circuits
- ✅ D flip-flops capture data on clock edges
- ✅ Registers are collections of flip-flops
- ✅ Shift registers move data through chains
- ✅ Counters track state over time
- ✅ **Critical timing concepts:**
  - Setup time (tsu)
  - Hold time (th)
  - Clock-to-Q delay (tcq)
  - Critical path determines max frequency
- ✅ **Non-blocking (`<=`) vs blocking (`=`):**
  - Non-blocking for sequential logic
  - Blocking for combinational logic
- ✅ Metastability and clock domain crossing
- ✅ Synchronizers for safe CDC

## What's Next?

In [Part 5: Finite State Machines](./05_FSM.md), we'll learn:

- FSM design methodology
- Moore vs Mealy machines
- State encoding techniques
- Complex sequential systems
- Real-world FSM examples

**FSMs are where everything comes together!** 🚀

---

**Ready to design state machines? Continue to Part 5!**

