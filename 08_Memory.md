# Part 8: Memory Modeling and Storage

## Introduction to Memory in Digital Design

Memory is essential in almost every digital system. In Verilog, we model different types of memory:

- **ROM (Read-Only Memory)**: Fixed data, initialized at synthesis
- **RAM (Random Access Memory)**: Read and write capability
- **Register Files**: Fast, small memories for CPUs
- **FIFOs**: Already covered in examples, but important memory structure

## Memory Declaration

### Basic Memory Array

```verilog
// Declare a memory: array of words
reg [7:0] memory [0:255];  // 256 locations, 8 bits each
//    ^^^^         ^^^^
//    data width   address range

// Alternative notations:
reg [7:0] mem [0:255];     // 256 x 8-bit memory
reg [31:0] ram [0:1023];   // 1024 x 32-bit memory
```

**Important**: The first range `[7:0]` is the data width, the second `[0:255]` is the depth (number of locations).

## ROM (Read-Only Memory)

### Method 1: Initialize with Initial Block

```verilog
module rom_16x8 (
    input  wire [3:0] addr,
    output reg  [7:0] data
);
    reg [7:0] rom_data [0:15];  // 16 locations, 8 bits each
    
    // Initialize ROM contents
    initial begin
        rom_data[0]  = 8'h00;
        rom_data[1]  = 8'h11;
        rom_data[2]  = 8'h22;
        rom_data[3]  = 8'h33;
        rom_data[4]  = 8'h44;
        rom_data[5]  = 8'h55;
        rom_data[6]  = 8'h66;
        rom_data[7]  = 8'h77;
        rom_data[8]  = 8'h88;
        rom_data[9]  = 8'h99;
        rom_data[10] = 8'hAA;
        rom_data[11] = 8'hBB;
        rom_data[12] = 8'hCC;
        rom_data[13] = 8'hDD;
        rom_data[14] = 8'hEE;
        rom_data[15] = 8'hFF;
    end
    
    // Combinational read
    always @(*) begin
        data = rom_data[addr];
    end
endmodule
```

**Timing Diagram:**

```
Time:     0ns         10ns        20ns        30ns

addr:     4'h0        4'h5        4'hA        4'hF
          ____        ____        ____        ____
data:     8'h00       8'h55       8'hAA       8'hFF
          ^           ^           ^           ^
          Immediate   Immediate   Immediate   Immediate
          (combinational access)
```

### Method 2: Initialize from File

Create a file `rom_data.hex`:
```
00
11
22
33
44
55
66
77
88
99
AA
BB
CC
DD
EE
FF
```

```verilog
module rom_from_file (
    input  wire [3:0] addr,
    output reg  [7:0] data
);
    reg [7:0] rom_data [0:15];
    
    initial begin
        $readmemh("rom_data.hex", rom_data);
    end
    
    always @(*) begin
        data = rom_data[addr];
    end
endmodule
```

### Method 3: Case Statement ROM (Small ROMs)

```verilog
module rom_case (
    input  wire [2:0] addr,
    output reg  [7:0] data
);
    always @(*) begin
        case (addr)
            3'h0: data = 8'h41;  // 'A'
            3'h1: data = 8'h42;  // 'B'
            3'h2: data = 8'h43;  // 'C'
            3'h3: data = 8'h44;  // 'D'
            3'h4: data = 8'h45;  // 'E'
            3'h5: data = 8'h46;  // 'F'
            3'h6: data = 8'h47;  // 'G'
            3'h7: data = 8'h48;  // 'H'
        endcase
    end
endmodule
```

## RAM (Random Access Memory)

### Single-Port RAM (1 Read/Write Port)

```verilog
module ram_single_port (
    input  wire        clk,
    input  wire        we,      // Write enable
    input  wire [7:0]  addr,
    input  wire [7:0]  data_in,
    output reg  [7:0]  data_out
);
    // 256 x 8-bit RAM
    reg [7:0] ram [0:255];
    
    always @(posedge clk) begin
        if (we)
            ram[addr] <= data_in;  // Write
        data_out <= ram[addr];     // Read
    end
endmodule
```

**Timing Diagram:**

```
Time:     0     10    20    30    40    50    60    70
          __    __    __    __    __    __    __    __
clk   ___|  |__|  |__|  |__|  |__|  |__|  |__|  |__|  |___

we:       _________    _________    _________
          |       |____|       |____|       |___________

addr:     8'h00       8'h01       8'h02       8'h01

data_in:  8'hAA       8'hBB       8'hCC       8'hXX

          ____________________    __________
data_out: 8'h00|8'hAA|8'hAA|8'hBB|8'hBB|8'hCC|8'hBB
                ^         ^           ^           ^
                Write     Read        Write       Read
                to 00     from 00     to 01       from 01

Explanation:
- Cycle 0: Write 0xAA to address 0x00
- Cycle 1: Read shows written value (0xAA)
- Cycle 2: Write 0xBB to address 0x01
- Cycle 3: Read shows 0xBB from address 0x01
```

### Dual-Port RAM (Separate Read/Write Ports)

```verilog
module ram_dual_port (
    input  wire        clk,
    
    // Port A (Write)
    input  wire        we_a,
    input  wire [7:0]  addr_a,
    input  wire [7:0]  data_in_a,
    
    // Port B (Read)
    input  wire [7:0]  addr_b,
    output reg  [7:0]  data_out_b
);
    reg [7:0] ram [0:255];
    
    // Port A: Write
    always @(posedge clk) begin
        if (we_a)
            ram[addr_a] <= data_in_a;
    end
    
    // Port B: Read
    always @(posedge clk) begin
        data_out_b <= ram[addr_b];
    end
endmodule
```

**Key Advantage**: Can read and write simultaneously to different addresses!

**Timing Diagram:**

```
Time:     0     10    20    30    40    50    60
          __    __    __    __    __    __    __
clk   ___|  |__|  |__|  |__|  |__|  |__|  |__|  |___

Port A (Write):
we_a:     _____________________________
          |                           |___________
addr_a:   8'h10  8'h11  8'h12  8'h13  8'h14
data_in:  8'hAA  8'hBB  8'hCC  8'hDD  8'hEE

Port B (Read):
addr_b:   8'h00  8'h10  8'h11  8'h12  8'h13
          ____________________    ____    ____
data_out: 8'h??|8'h??|8'hAA|8'hBB|8'hCC|8'hDD

Explanation:
- Simultaneous operations on different ports
- Port B reads what Port A wrote in previous cycle
- Can access different addresses at the same time
```

### True Dual-Port RAM (Both Ports Can Read/Write)

```verilog
module ram_true_dual_port (
    input  wire        clk,
    
    // Port A
    input  wire        we_a,
    input  wire [7:0]  addr_a,
    input  wire [7:0]  data_in_a,
    output reg  [7:0]  data_out_a,
    
    // Port B
    input  wire        we_b,
    input  wire [7:0]  addr_b,
    input  wire [7:0]  data_in_b,
    output reg  [7:0]  data_out_b
);
    reg [7:0] ram [0:255];
    
    // Port A
    always @(posedge clk) begin
        if (we_a)
            ram[addr_a] <= data_in_a;
        data_out_a <= ram[addr_a];
    end
    
    // Port B
    always @(posedge clk) begin
        if (we_b)
            ram[addr_b] <= data_in_b;
        data_out_b <= ram[addr_b];
    end
endmodule
```

## Register File (CPU-style)

Fast, small memory used in processors:

```verilog
module register_file (
    input  wire        clk,
    input  wire        rst_n,
    
    // Write port
    input  wire        we,
    input  wire [4:0]  wr_addr,    // 32 registers
    input  wire [31:0] wr_data,
    
    // Read port 1
    input  wire [4:0]  rd_addr1,
    output reg  [31:0] rd_data1,
    
    // Read port 2
    input  wire [4:0]  rd_addr2,
    output reg  [31:0] rd_data2
);
    // 32 registers, 32 bits each
    reg [31:0] registers [0:31];
    
    integer i;
    
    // Write port (synchronous)
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 32; i = i + 1)
                registers[i] <= 32'h00000000;
        end else if (we && wr_addr != 5'h00) begin
            registers[wr_addr] <= wr_data;  // Register 0 is read-only (always 0)
        end
    end
    
    // Read ports (combinational for fast access)
    always @(*) begin
        rd_data1 = registers[rd_addr1];
        rd_data2 = registers[rd_addr2];
    end
endmodule
```

**Key Features**:
- Register 0 is hardwired to 0 (RISC convention)
- 2 read ports for simultaneous reads
- 1 write port
- Combinational reads for speed

## Memory Initialization Techniques

### Using $readmemb (Binary)

File `init_data.bin`:
```
00000000
00000001
00000010
00000011
```

```verilog
initial begin
    $readmemb("init_data.bin", memory);
end
```

### Using $readmemh (Hexadecimal)

File `init_data.hex`:
```
00
01
02
03
04
```

```verilog
initial begin
    $readmemh("init_data.hex", memory);
end
```

### Specifying Address Range

```verilog
initial begin
    // Load into addresses 10-19
    $readmemh("init_data.hex", memory, 10, 19);
end
```

### Addressing Format in File

You can specify addresses in the data file:

File `data_with_addr.hex`:
```
@00A  // Start at address 0x00A
11
22
33
@100  // Jump to address 0x100
AA
BB
CC
```

## FPGA Block RAM Inference

Modern FPGAs have dedicated block RAM. Synthesis tools infer them when you follow specific patterns:

### Single-Port Block RAM Pattern

```verilog
module block_ram_inferred (
    input  wire        clk,
    input  wire        we,
    input  wire [9:0]  addr,  // 1024 addresses
    input  wire [7:0]  din,
    output reg  [7:0]  dout
);
    reg [7:0] ram [0:1023];
    
    // This pattern infers block RAM
    always @(posedge clk) begin
        if (we)
            ram[addr] <= din;
        dout <= ram[addr];  // Register output for better timing
    end
endmodule
```

### Read-First vs Write-First Behavior

```verilog
// Read-First (output shows OLD value when writing)
always @(posedge clk) begin
    if (we)
        ram[addr] <= din;
    dout <= ram[addr];  // Reads before write takes effect
end

// Write-First (output shows NEW value when writing)
always @(posedge clk) begin
    if (we) begin
        ram[addr] <= din;
        dout <= din;  // Output new data
    end else begin
        dout <= ram[addr];
    end
end
```

## Cache Memory Basics

Simple direct-mapped cache:

```verilog
module simple_cache (
    input  wire        clk,
    input  wire        rst_n,
    input  wire [7:0]  addr,
    input  wire [7:0]  data_in,
    input  wire        read_req,
    input  wire        write_req,
    output reg  [7:0]  data_out,
    output reg         hit
);
    // Cache: 16 lines, 8 bits data + 4 bits tag + 1 valid bit
    reg [7:0]  cache_data [0:15];
    reg [3:0]  cache_tag [0:15];
    reg        cache_valid [0:15];
    
    wire [3:0] index = addr[3:0];
    wire [3:0] tag = addr[7:4];
    
    integer i;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (i = 0; i < 16; i = i + 1) begin
                cache_valid[i] <= 1'b0;
                cache_tag[i] <= 4'h0;
                cache_data[i] <= 8'h00;
            end
            hit <= 1'b0;
            data_out <= 8'h00;
        end else begin
            // Check for hit
            if (cache_valid[index] && cache_tag[index] == tag) begin
                hit <= 1'b1;
                if (read_req)
                    data_out <= cache_data[index];
                if (write_req) begin
                    cache_data[index] <= data_in;
                end
            end else begin
                hit <= 1'b0;
                // On miss, load from main memory (simplified)
                if (read_req || write_req) begin
                    cache_valid[index] <= 1'b1;
                    cache_tag[index] <= tag;
                    cache_data[index] <= data_in;
                end
            end
        end
    end
endmodule
```

## Memory Testing Best Practices

### Walking 1's Test

```verilog
task test_walking_ones;
    integer i, j;
    reg [7:0] pattern;
    begin
        $display("Walking 1's test");
        for (i = 0; i < 256; i = i + 1) begin
            for (j = 0; j < 8; j = j + 1) begin
                pattern = 1 << j;
                write_mem(i, pattern);
                read_mem(i);
                if (read_data != pattern)
                    $display("ERROR at addr %h", i);
            end
        end
    end
endtask
```

### Checkerboard Test

```verilog
task test_checkerboard;
    integer i;
    begin
        $display("Checkerboard test");
        // Write 0xAA to even addresses, 0x55 to odd
        for (i = 0; i < 256; i = i + 1) begin
            if (i[0])
                write_mem(i, 8'h55);
            else
                write_mem(i, 8'hAA);
        end
        
        // Verify
        for (i = 0; i < 256; i = i + 1) begin
            read_mem(i);
            if (i[0] && read_data != 8'h55)
                $display("ERROR at addr %h", i);
            else if (!i[0] && read_data != 8'hAA)
                $display("ERROR at addr %h", i);
        end
    end
endtask
```

## Common Memory Mistakes

### ❌ Mistake 1: Asynchronous Read (Non-Synthesizable for Block RAM)

```verilog
// BAD for FPGA block RAM
always @(*) begin
    data_out = ram[addr];  // Combinational read
end
```

### ✅ Correct: Synchronous Read

```verilog
always @(posedge clk) begin
    data_out <= ram[addr];  // Registered output
end
```

### ❌ Mistake 2: Initializing Large RAM in Always Block

```verilog
// BAD: Slow simulation
always @(posedge clk) begin
    if (!rst_n) begin
        for (i = 0; i < 1024; i = i + 1)  // Takes 1024 cycles!
            ram[i] <= 8'h00;
    end
end
```

### ✅ Correct: Use Initial Block or File

```verilog
initial begin
    $readmemh("zeros.hex", ram);  // Or use synthesis attribute
end
```

## Practice Exercises

### Exercise 1: Instruction Memory
Create a ROM that stores simple CPU instructions. Initialize it with a program.

### Exercise 2: Stack Memory
Implement a stack (LIFO) using RAM with push/pop operations.

### Exercise 3: Content-Addressable Memory (CAM)
Create a simple CAM that searches for matching data.

### Exercise 4: Memory with Parity
Add parity bit generation and checking to RAM.

## Summary

In this part, you learned:

- ✅ Memory array declaration and initialization
- ✅ ROM implementation (case, initial, file)
- ✅ RAM types: single-port, dual-port, true dual-port
- ✅ Register files for CPU design
- ✅ Memory initialization: `$readmemh`, `$readmemb`
- ✅ FPGA block RAM inference patterns
- ✅ Basic cache concepts
- ✅ Memory testing techniques
- ✅ Common mistakes and best practices

## What's Next?

In [Part 9: Communication Protocols](./09_Communication_Protocols.md), we'll implement:
- UART (Universal Asynchronous Receiver/Transmitter)
- SPI (Serial Peripheral Interface)
- I2C basics

**Learn to communicate with the outside world!** 🚀

---

**Ready to learn communication protocols? Continue to Part 9!**

