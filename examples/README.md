# Verilog Examples

This directory contains complete, working Verilog examples with testbenches.

## Running the Examples

### Using Icarus Verilog (iverilog)

```bash
# Compile and simulate
iverilog -o output.vvp example.v
vvp output.vvp

# View waveforms (if VCD file generated)
gtkwave waveform.vcd
```

### Example workflow:

```bash
# Example 1: Logic Gates
iverilog -o logic_gates.vvp 01_logic_gates.v
vvp logic_gates.vvp

# Example 5: ALU with waveform viewing
iverilog -o alu.vvp 05_alu.v
vvp alu.vvp
gtkwave alu_8bit.vcd
```

## Examples Overview

### 01_logic_gates.v
- Basic logic gates (AND, OR, NOT, NAND, NOR, XOR, XNOR)
- **Concepts**: Combinational logic, truth tables
- **Complexity**: Beginner

### 02_multiplexer.v
- 4-to-1 multiplexer with two implementation styles
- **Concepts**: Conditional operator, case statements
- **Complexity**: Beginner

### 03_counter.v
- 8-bit counter with enable and load
- **Concepts**: Sequential logic, control signals
- **Complexity**: Beginner

### 04_shift_register.v
- SISO (Serial-In Serial-Out) shift register
- PISO (Parallel-In Serial-Out) shift register
- **Concepts**: Data movement, register chains
- **Complexity**: Intermediate

### 05_alu.v
- 8-bit Arithmetic Logic Unit
- 10 operations: ADD, SUB, AND, OR, XOR, NOT, SLL, SRL, INC, DEC
- Status flags: Zero, Negative, Overflow
- **Concepts**: Complex combinational logic, arithmetic operations
- **Complexity**: Intermediate

### 06_fsm_traffic_light.v
- Traffic light controller using Moore FSM
- **Concepts**: State machines, timers
- **Complexity**: Intermediate

### 07_fsm_sequence_detector.v
- Detects "101" pattern in serial bit stream
- Moore machine with overlapping detection
- **Concepts**: Pattern matching, FSM design
- **Complexity**: Intermediate

### 08_fifo.v
- 8-entry, 8-bit FIFO buffer
- Full and empty flags
- **Concepts**: Memory, pointers, buffer management
- **Complexity**: Advanced

### 09_uart_transmitter.v
- UART serial transmitter
- Configurable baud rate
- **Concepts**: Serial communication, timing, FSM
- **Complexity**: Advanced

### 10_ram.v
- Single-port RAM implementation
- Synchronous read/write
- **Concepts**: Memory modeling, storage
- **Complexity**: Intermediate

### 11_tristate_logic.v
- Tri-state buffers and bidirectional I/O
- Bus controller example
- **Concepts**: High-impedance state, shared buses
- **Complexity**: Advanced

### 12_signed_arithmetic.v
- Signed number operations
- Overflow detection
- Sign extension
- **Concepts**: 2's complement, signed arithmetic
- **Complexity**: Intermediate

## Learning Path

1. **Week 1**: Examples 1-2 (Basic combinational logic)
2. **Week 2**: Example 3 (Sequential logic basics)
3. **Week 3**: Examples 4-5 (Shift registers and ALU)
4. **Week 4**: Examples 6-7 (State machines)
5. **Week 5**: Examples 8-10 (FIFO, UART, memory)
6. **Week 6**: Examples 11-12 (Tri-state logic, signed arithmetic)
7. **Week 7+**: Build your own projects!

## More practice: HDLBits (182 problems)

The [hdlbits/](../hdlbits/) folder contains every problem from [HDLBits](https://hdlbits.01xz.net/wiki/Main_Page), with a restated statement, official figures, and a Verilog solution. Start with Getting Started, then mix Verilog Language problems with Circuits as the official site recommends.

See [hdlbits/README.md](../hdlbits/README.md) for the full index.

## Tips for Learning

1. **Read the code first** - Understand what it does
2. **Simulate it** - Run the testbench and observe outputs
3. **View waveforms** - Use GTKWave to see signal timing
4. **Modify and experiment** - Change parameters, add features
5. **Write your own tests** - Add new test cases

## Common Commands

```bash
# Compile only (check for errors)
iverilog -t null example.v

# Compile with specific output name
iverilog -o my_sim.vvp module.v testbench.v

# Run simulation with output
vvp sim.vvp

# Generate VCD and view
vvp sim.vvp && gtkwave waveform.vcd
```

## Exercises

After understanding each example, try these modifications:

### Example 1 Extensions:
- Add a 3-input majority gate
- Create a full truth table generator

### Example 3 Extensions:
- Add up/down counting capability
- Implement a modulo-N counter
- Add overflow detection

### Example 5 Extensions:
- Add multiplication operation
- Implement signed arithmetic
- Add more status flags (carry, parity)

### Example 7 Extensions:
- Detect different patterns (e.g., "1101")
- Count pattern occurrences
- Add pattern length parameter

### Example 8 Extensions:
- Add almost-full and almost-empty flags
- Implement data count output
- Add asynchronous read/write

## Debugging Tips

1. **Use $display statements** to trace execution
2. **Generate VCD files** for timing analysis
3. **Check sensitivity lists** in always blocks
4. **Verify reset behavior** first
5. **Test corner cases** (empty, full, overflow, etc.)

## Additional Resources

- Refer back to tutorial parts for concepts
- Check timing diagrams in tutorial
- Use synthesis tools to see generated hardware
- Compare different implementation styles

---

**Happy coding! Build something amazing!** 🚀

