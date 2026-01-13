# Part 5: Finite State Machines (FSMs)

## Introduction to FSMs

A **Finite State Machine** is a sequential circuit that:
- Has a finite number of states
- Transitions between states based on inputs
- Produces outputs based on current state (and possibly inputs)

FSMs are used everywhere:
- Traffic light controllers
- Vending machines
- Communication protocols
- CPU control units
- Game logic

## FSM Components

Every FSM has these elements:

1. **States**: Different operating modes
2. **Inputs**: Signals that affect transitions
3. **Outputs**: Signals produced by the FSM
4. **Transitions**: Rules for moving between states
5. **Initial State**: Where the FSM starts

## Moore vs Mealy Machines

### Moore Machine

**Outputs depend ONLY on current state**

```
        ┌─────────────┐
Input → │    State    │ → Output (function of state only)
        └─────────────┘
             ↓
        Next State
```

**Characteristics:**
- Outputs change only on state transitions (clock edges)
- Outputs are synchronized
- Generally easier to design
- May require more states

### Mealy Machine

**Outputs depend on current state AND inputs**

```
        ┌─────────────┐
Input → │    State    │
        └─────────────┘
         ↓           ↓
    Next State    Output (function of state AND input)
```

**Characteristics:**
- Outputs can change asynchronously with inputs
- Can respond faster (one cycle less delay)
- May have fewer states
- Outputs can glitch if inputs change

### Comparison Example: Sequence Detector

**Task**: Detect the sequence "101" in a serial bit stream

**Moore Machine** (outputs depend only on state):

```
States:
- IDLE:   Waiting for first '1'
- GOT_1:  Received '1'
- GOT_10: Received '10'
- GOT_101: Received '101' - OUTPUT HIGH

        _______        _______        _______        _______
       | IDLE  |      |GOT_1  |      |GOT_10 |      |GOT_101|
       |out=0  |      |out=0  |      |out=0  |      |out=1  |
       |_______|      |_______|      |_______|      |_______|
          |0             |0             |1             |
          ↓              ↓              ↓              ↓
         IDLE           IDLE          GOT_1          IDLE
          ↑1             ↑1             ↑0             ↑
          |______________|______________|______________|
```

**Mealy Machine** (outputs depend on state and input):

```
States:
- IDLE:   Waiting
- GOT_1:  Received '1'
- GOT_10: Received '10'

        _______                _______                _______
       | IDLE  |              |GOT_1  |              |GOT_10 |
       |_______|              |_______|              |_______|
        | |                    | |                    | |
      0/0 |1/0              0/0 |1/0              1/1 |0/0
        | |                    | |                    | |
        ↓ |___________________/  |___________________/  |
                                                         |
Notation: input/output                                   |
                                                         |
From GOT_10, if input='1' → output='1' (sequence detected)
```

## FSM Design Methodology

### Step-by-Step Process

1. **Understand the specification**
2. **Draw the state diagram**
3. **Create state transition table**
4. **Choose state encoding**
5. **Write the Verilog code**
6. **Simulate and verify**

## FSM Coding Styles

### Three-Block Style (Recommended)

Separate combinational and sequential logic:

```verilog
module fsm_three_block (
    input  wire clk,
    input  wire rst_n,
    input  wire input_signal,
    output reg  output_signal
);
    // State encoding
    localparam IDLE  = 2'b00;
    localparam STATE1 = 2'b01;
    localparam STATE2 = 2'b10;
    
    reg [1:0] current_state, next_state;
    
    // Block 1: State register (sequential)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    // Block 2: Next state logic (combinational)
    always @(*) begin
        next_state = current_state;  // Default: stay in current state
        case (current_state)
            IDLE: begin
                if (input_signal)
                    next_state = STATE1;
            end
            STATE1: begin
                if (input_signal)
                    next_state = STATE2;
                else
                    next_state = IDLE;
            end
            STATE2: begin
                next_state = IDLE;
            end
        endcase
    end
    
    // Block 3: Output logic (combinational)
    always @(*) begin
        output_signal = 1'b0;  // Default output
        case (current_state)
            STATE2: output_signal = 1'b1;
        endcase
    end
endmodule
```

### Two-Block Style

Combine next state and output logic:

```verilog
module fsm_two_block (
    input  wire clk,
    input  wire rst_n,
    input  wire input_signal,
    output reg  output_signal
);
    localparam IDLE  = 2'b00;
    localparam STATE1 = 2'b01;
    localparam STATE2 = 2'b10;
    
    reg [1:0] current_state, next_state;
    
    // Block 1: State register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end
    
    // Block 2: Next state and output logic
    always @(*) begin
        next_state = current_state;
        output_signal = 1'b0;
        
        case (current_state)
            IDLE: begin
                if (input_signal)
                    next_state = STATE1;
            end
            STATE1: begin
                if (input_signal)
                    next_state = STATE2;
                else
                    next_state = IDLE;
            end
            STATE2: begin
                output_signal = 1'b1;
                next_state = IDLE;
            end
        endcase
    end
endmodule
```

## Example 1: Traffic Light Controller

**Specification:**
- Normal operation: Green → Yellow → Red → Green
- Each state has a timer
- Emergency mode: Go directly to Red

**State Diagram:**

```
        ┌──────────┐
        │  GREEN   │
        │ out=001  │
        └──────────┘
             │ timer_done
             ↓
        ┌──────────┐
        │  YELLOW  │
        │ out=010  │
        └──────────┘
             │ timer_done
             ↓
        ┌──────────┐
        │   RED    │
        │ out=100  │
        └──────────┘
             │ timer_done
             └──────────→ (back to GREEN)
             
     emergency signal forces any state to RED
```

**Implementation:**

```verilog
module traffic_light (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       emergency,
    output reg  [2:0] lights      // {red, yellow, green}
);
    // State encoding
    localparam GREEN  = 2'b00;
    localparam YELLOW = 2'b01;
    localparam RED    = 2'b10;
    
    // Timer parameters (in clock cycles)
    localparam GREEN_TIME  = 100;
    localparam YELLOW_TIME = 20;
    localparam RED_TIME    = 80;
    
    reg [1:0] state, next_state;
    reg [7:0] timer;
    wire timer_done;
    
    // State register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= RED;  // Start with RED for safety
        else
            state <= next_state;
    end
    
    // Timer
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            timer <= 8'd0;
        else if (state != next_state)
            timer <= 8'd0;  // Reset timer on state change
        else
            timer <= timer + 1;
    end
    
    assign timer_done = (state == GREEN  && timer >= GREEN_TIME - 1)  ||
                       (state == YELLOW && timer >= YELLOW_TIME - 1) ||
                       (state == RED    && timer >= RED_TIME - 1);
    
    // Next state logic
    always @(*) begin
        if (emergency)
            next_state = RED;  // Emergency: go to RED immediately
        else begin
            case (state)
                GREEN:  next_state = timer_done ? YELLOW : GREEN;
                YELLOW: next_state = timer_done ? RED    : YELLOW;
                RED:    next_state = timer_done ? GREEN  : RED;
                default: next_state = RED;
            endcase
        end
    end
    
    // Output logic (Moore machine - depends only on state)
    always @(*) begin
        case (state)
            GREEN:   lights = 3'b001;  // Green on
            YELLOW:  lights = 3'b010;  // Yellow on
            RED:     lights = 3'b100;  // Red on
            default: lights = 3'b100;  // Default to RED for safety
        endcase
    end
endmodule
```

**Timing Diagram:**

```
Time:        0     100    120    200    300    320    400
             ___________________________________________________
clk      ___|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |___
             ___________________________________________
emergency ___|                                           |_______
             ___________                     ___________
state:   ____|GREEN     |_____RED___________|GREEN     |______
             001         100                 001
             ___________                     ___________
lights:  ____|green     |_____red___________|green     |______

Timer:   0→99 0→79  0→99    0→19   0→79     0→99
                │           │               │
              Skip        Skip            Skip
              YELLOW      GREEN           YELLOW
              (emergency) (emergency)     (emergency)

Explanation:
- Normally cycles: GREEN(100)→YELLOW(20)→RED(80)→GREEN...
- When emergency=1, immediately transitions to RED
- Timer resets on each state change
```

## Example 2: Sequence Detector (101)

Detects "101" pattern in serial input stream (Moore machine).

**State Diagram:**

```
        ┌──────────┐   0
        │   IDLE   │◄──┐
        │  out=0   │   │
        └──────────┘   │
             │1        │
             ↓         │
        ┌──────────┐   │
        │  GOT_1   │   │
        │  out=0   │◄──┤
        └──────────┘   │
          │0    │1     │
          │     └──────┘
          ↓
        ┌──────────┐   1
        │  GOT_10  │───┐
        │  out=0   │   │
        └──────────┘   │
             │0        │
             ↓         │
        ┌──────────┐   │
        │ GOT_101  │   │
        │  out=1   │───┘
        └──────────┘
```

**Implementation:**

```verilog
module sequence_detector_101 (
    input  wire clk,
    input  wire rst_n,
    input  wire data_in,
    output reg  detected
);
    // State encoding
    localparam IDLE    = 3'b000;
    localparam GOT_1   = 3'b001;
    localparam GOT_10  = 3'b010;
    localparam GOT_101 = 3'b011;
    
    reg [2:0] state, next_state;
    
    // State register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        case (state)
            IDLE: begin
                if (data_in)
                    next_state = GOT_1;
                else
                    next_state = IDLE;
            end
            
            GOT_1: begin
                if (data_in)
                    next_state = GOT_1;  // Stay, waiting for 0
                else
                    next_state = GOT_10;
            end
            
            GOT_10: begin
                if (data_in)
                    next_state = GOT_101;  // Sequence detected!
                else
                    next_state = IDLE;     // Start over
            end
            
            GOT_101: begin
                if (data_in)
                    next_state = GOT_1;   // New potential sequence
                else
                    next_state = GOT_10;  // Could be start of new seq
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // Output logic (Moore - depends only on state)
    always @(*) begin
        detected = (state == GOT_101);
    end
endmodule
```

**Timing Diagram:**

```
Time:     0    5    10   15   20   25   30   35   40   45
          __   __   __   __   __   __   __   __   __   __
clk   ___|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |_|  |___
          _____   _________    _____    _________
data_in __|   |__|         |__|     |__|         |________
          1    0     1       0   1    0     1      0

State sequence:
0ns:   IDLE
5ns:   GOT_1    (saw 1)
10ns:  GOT_10   (saw 10)
15ns:  GOT_101  (saw 101) ← DETECTED!
20ns:  GOT_1    (1 could start new sequence)
25ns:  GOT_10   (10...)
30ns:  GOT_101  (101) ← DETECTED again!
35ns:  GOT_1    
40ns:  GOT_10
45ns:  IDLE     (saw 0, restart)

         __________                     __________
detected|          |___________________|          |_______
         ^15ns                          ^30ns
         Detected!                      Detected again!
```

## Example 3: Vending Machine Controller

**Specification:**
- Product costs 15 cents
- Accepts 5¢ and 10¢ coins
- Dispenses product when >= 15¢
- Returns change if overpaid

**State Diagram:**

```
        ┌──────────┐
        │  CENTS_0 │ (initial state)
        └──────────┘
          │5¢  │10¢
     ┌────┴────┴───────┐
     ↓         ↓        │
┌──────────┐ ┌──────────┐
│ CENTS_5  │ │ CENTS_10 │
└──────────┘ └──────────┘
  │5¢  │10¢   │5¢  │10¢
  ↓    │      │    │
┌──────────┐  │    │
│ CENTS_10 │←─┘    │
└──────────┘       │
  │5¢  │10¢        │
  │    └───────────┴───→ CENTS_15+ (DISPENSE)
  ↓                          │
CENTS_15+ ←──────────────────┘
(DISPENSE)                    ↓
  │                    Return to CENTS_0
  └────────────────────────────┘
```

**Implementation:**

```verilog
module vending_machine (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       nickel,    // 5¢ coin inserted
    input  wire       dime,      // 10¢ coin inserted
    output reg        dispense,
    output reg        return_nickel  // Return 5¢ change
);
    // State encoding
    localparam CENTS_0  = 3'b000;
    localparam CENTS_5  = 3'b001;
    localparam CENTS_10 = 3'b010;
    localparam CENTS_15 = 3'b011;
    localparam CENTS_20 = 3'b100;
    
    reg [2:0] state, next_state;
    
    // State register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= CENTS_0;
        else
            state <= next_state;
    end
    
    // Next state logic
    always @(*) begin
        next_state = state;
        
        case (state)
            CENTS_0: begin
                if (nickel)
                    next_state = CENTS_5;
                else if (dime)
                    next_state = CENTS_10;
            end
            
            CENTS_5: begin
                if (nickel)
                    next_state = CENTS_10;
                else if (dime)
                    next_state = CENTS_15;
            end
            
            CENTS_10: begin
                if (nickel)
                    next_state = CENTS_15;
                else if (dime)
                    next_state = CENTS_20;
            end
            
            CENTS_15: begin
                next_state = CENTS_0;  // Dispense and return to start
            end
            
            CENTS_20: begin
                next_state = CENTS_0;  // Dispense with change
            end
        endcase
    end
    
    // Output logic
    always @(*) begin
        dispense = 1'b0;
        return_nickel = 1'b0;
        
        case (state)
            CENTS_15: begin
                dispense = 1'b1;
            end
            CENTS_20: begin
                dispense = 1'b1;
                return_nickel = 1'b1;  // Return 5¢ change
            end
        endcase
    end
endmodule
```

**Timing Diagram:**

```
Time:      0     10    20    30    40    50    60    70
           __    __    __    __    __    __    __    __
clk    ___|  |__|  |__|  |__|  |__|  |__|  |__|  |__|  |___
           _____                   _____
nickel ___|     |_________________|     |_________________
                       _____                 _____
dime   _______________|     |_______________|     |_______

State:  0¢    5¢    5¢   15¢    0¢    5¢   15¢    0¢
                         ^^^                ^^^
                      dispense           dispense

            ____________________       ____________________
dispense __|                    |_____|                    |___
                                ^30ns                     ^70ns

Scenario 1 (0-40ns):
- Insert 5¢: 0→5
- Wait: stay at 5
- Insert 10¢: 5→15 → DISPENSE!

Scenario 2 (40-80ns):
- Insert 5¢: 0→5
- Insert 10¢: 5→15 → DISPENSE!
```

## State Encoding Techniques

### 1. Binary Encoding (Compact)

```verilog
localparam IDLE   = 3'b000;  // 0
localparam STATE1 = 3'b001;  // 1
localparam STATE2 = 3'b010;  // 2
localparam STATE3 = 3'b011;  // 3
localparam STATE4 = 3'b100;  // 4

// Pros: Minimal flip-flops (log2(n) bits for n states)
// Cons: More combinational logic
```

### 2. One-Hot Encoding (Fast)

```verilog
localparam IDLE   = 5'b00001;  // Only bit 0 is 1
localparam STATE1 = 5'b00010;  // Only bit 1 is 1
localparam STATE2 = 5'b00100;  // Only bit 2 is 1
localparam STATE3 = 5'b01000;  // Only bit 3 is 1
localparam STATE4 = 5'b10000;  // Only bit 4 is 1

// Pros: Faster, simpler logic, easier to debug
// Cons: More flip-flops (n bits for n states)
// Best for: FPGAs (plenty of flip-flops)
```

### 3. Gray Code Encoding

```verilog
localparam IDLE   = 3'b000;
localparam STATE1 = 3'b001;
localparam STATE2 = 3'b011;  // Only 1 bit changes
localparam STATE3 = 3'b010;  // Only 1 bit changes
localparam STATE4 = 3'b110;

// Pros: Reduces glitches (only 1 bit changes per transition)
// Cons: More complex encoding
// Best for: Reducing power, critical designs
```

## FSM Best Practices

### ✅ DO:

1. **Use descriptive state names**
```verilog
localparam IDLE = 2'b00;  // Not S0
```

2. **Always include a default state**
```verilog
default: next_state = IDLE;
```

3. **Assign default values to avoid latches**
```verilog
always @(*) begin
    next_state = current_state;  // Default
    output_signal = 1'b0;        // Default
    case (current_state)
        // state transitions
    endcase
end
```

4. **Use parameters for readability**
```verilog
localparam TIMEOUT = 1000;
if (counter >= TIMEOUT) ...
```

5. **Add comments explaining state behavior**

### ❌ DON'T:

1. **Don't use magic numbers**
```verilog
if (state == 2'b01) ...  // Bad! Use named parameters
```

2. **Don't forget reset state**
```verilog
if (!rst_n)
    state <= IDLE;  // Always define initial state
```

3. **Don't create unreachable states**

4. **Don't mix blocking/non-blocking**

## Debugging FSMs

### Add State Monitoring

```verilog
// For simulation
always @(posedge clk) begin
    case (state)
        IDLE:   $display("Time %0t: IDLE", $time);
        STATE1: $display("Time %0t: STATE1", $time);
        STATE2: $display("Time %0t: STATE2", $time);
    endcase
end
```

### State Vector Output

```verilog
// Export state for debugging
output wire [1:0] debug_state;
assign debug_state = state;
```

## Practice Exercises

### Exercise 1: Elevator Controller
Design a 3-floor elevator controller with:
- Up/down buttons on each floor
- Current floor display
- Door open/close control

### Exercise 2: UART Transmitter FSM
Design an FSM for UART serial transmission:
- IDLE state
- START bit state
- 8 DATA bit states
- STOP bit state

### Exercise 3: Debounce FSM
Design a button debounce circuit using FSM:
- Wait for stable button press
- Ignore glitches < 10ms
- Generate clean output pulse

### Exercise 4: Pattern Recognizer
Design an FSM that recognizes the pattern "1011" with overlapping detection.

## Solutions

<details>
<summary>Exercise 4 Solution: Pattern "1011" Detector</summary>

```verilog
module pattern_1011_detector (
    input  wire clk,
    input  wire rst_n,
    input  wire data_in,
    output reg  detected
);
    localparam IDLE    = 3'b000;
    localparam GOT_1   = 3'b001;
    localparam GOT_10  = 3'b010;
    localparam GOT_101 = 3'b011;
    localparam GOT_1011 = 3'b100;
    
    reg [2:0] state, next_state;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= IDLE;
        else
            state <= next_state;
    end
    
    always @(*) begin
        case (state)
            IDLE: next_state = data_in ? GOT_1 : IDLE;
            GOT_1: next_state = data_in ? GOT_1 : GOT_10;
            GOT_10: next_state = data_in ? GOT_101 : IDLE;
            GOT_101: next_state = data_in ? GOT_1011 : GOT_10;
            GOT_1011: next_state = data_in ? GOT_1 : GOT_10;
            default: next_state = IDLE;
        endcase
    end
    
    always @(*) begin
        detected = (state == GOT_1011);
    end
endmodule
```
</details>

## Summary

In this part, you learned:

- ✅ FSMs organize complex sequential logic
- ✅ Moore vs Mealy machines
- ✅ Three-block FSM coding style (recommended)
- ✅ State encoding: binary, one-hot, Gray code
- ✅ Real-world examples:
  - Traffic light controller
  - Sequence detector
  - Vending machine
- ✅ FSM design methodology
- ✅ Best practices and debugging

## What's Next?

In [Part 6: Testbenches and Simulation](./06_Testbenches.md), we'll learn:

- Writing comprehensive testbenches
- System tasks for simulation
- Waveform analysis
- Coverage and verification
- Self-checking testbenches

**Learn to verify your designs properly!** 🚀

---

**Ready to master testing? Continue to Part 6!**

