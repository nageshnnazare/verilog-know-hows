# Part 9: Communication Protocols

## Introduction

Digital systems need to communicate with each other and with the outside world. This chapter covers the most common serial communication protocols you'll use in real designs.

### Why Serial Communication?

- **Fewer pins**: 2-4 wires vs 8-32 for parallel
- **Longer distances**: Less crosstalk and interference  
- **Lower cost**: Simpler PCB routing
- **Common**: Industry-standard protocols

## UART (Universal Asynchronous Receiver/Transmitter)

UART is the most common serial protocol. Used for:
- Debug consoles
- GPS modules
- Bluetooth modules
- Serial terminals

### UART Basics

**Key Characteristics:**
- Asynchronous (no clock signal)
- Two wires: TX (transmit) and RX (receive)
- Both devices must agree on baud rate
- Common baud rates: 9600, 115200, 921600 bps

### UART Frame Format

```
        Start                           Stop
        Bit   D0  D1  D2  D3  D4  D5  D6  D7  Bit
         ___   ___________________   ___________
IDLE ___|   |_|___________________|_|           |_____ IDLE
        ^   ^                       ^           ^
        |   |                       |           |
     Idle  Start                  Data      Stop
    (HIGH) (LOW)                 (8 bits)   (HIGH)

Idle state: Line is HIGH
Start bit: Transition to LOW (signals start of frame)
Data bits: 8 bits (LSB first), can be 5-9 bits
Stop bit: Transition to HIGH (signals end of frame)
Optional parity bit can be added between data and stop
```

**Timing:**
```
Baud rate = 9600 bps
Bit period = 1/9600 = 104.17 microseconds

        104µs per bit
        <--------->
        ___     ___     ___     ___     ___
        |  |___|   |___|   |___|   |___|   |___
```

### UART Transmitter

```verilog
module uart_transmitter #(
    parameter CLK_FREQ = 50000000,  // 50 MHz
    parameter BAUD_RATE = 115200
)(
    input  wire       clk,
    input  wire       rst_n,
    input  wire [7:0] data_in,
    input  wire       start,
    output reg        tx,
    output reg        busy
);

    // Calculate baud rate divisor
    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;
    
    // States
    localparam IDLE  = 3'b000;
    localparam START = 3'b001;
    localparam DATA  = 3'b010;
    localparam STOP  = 3'b011;
    
    reg [2:0] state;
    reg [15:0] clk_count;
    reg [2:0] bit_index;
    reg [7:0] tx_data;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            tx <= 1'b1;  // Idle high
            busy <= 1'b0;
            clk_count <= 16'h0000;
            bit_index <= 3'h0;
            tx_data <= 8'h00;
        end else begin
            case (state)
                IDLE: begin
                    tx <= 1'b1;
                    busy <= 1'b0;
                    clk_count <= 16'h0000;
                    bit_index <= 3'h0;
                    
                    if (start) begin
                        tx_data <= data_in;
                        busy <= 1'b1;
                        state <= START;
                    end
                end
                
                START: begin
                    tx <= 1'b0;  // Start bit
                    
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 16'h0000;
                        state <= DATA;
                    end
                end
                
                DATA: begin
                    tx <= tx_data[bit_index];  // Send LSB first
                    
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 16'h0000;
                        
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;
                        end else begin
                            bit_index <= 3'h0;
                            state <= STOP;
                        end
                    end
                end
                
                STOP: begin
                    tx <= 1'b1;  // Stop bit
                    
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 16'h0000;
                        state <= IDLE;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end
endmodule
```

**Timing Diagram:**

```
Time:     0          104µs       208µs       312µs
          ___________________________________________________
clk   ___|||||||||||||||||||||||||||||||||||||||||||||||||___

start:     ___
      ____|   |______________________________________________

          _____________________________________________________
busy: ____|

           _____     _____     _____     _____     _____     ___
tx:             |___|     |___|     |___|     |___|     |___|
          IDLE  START  D0    D1    D2    D3    D4    D5    STOP
                      (LSB)                          (MSB)

Sending: 0x53 (ASCII 'S') = 0b01010011
Bit sequence: 0-1-1-0-0-1-0-1-0-1 (Start-D0-D1-D2-D3-D4-D5-D6-D7-Stop)
```

### UART Receiver

```verilog
module uart_receiver #(
    parameter CLK_FREQ = 50000000,
    parameter BAUD_RATE = 115200
)(
    input  wire       clk,
    input  wire       rst_n,
    input  wire       rx,
    output reg  [7:0] data_out,
    output reg        data_valid
);

    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;
    localparam CLKS_PER_HALF_BIT = CLKS_PER_BIT / 2;
    
    localparam IDLE  = 3'b000;
    localparam START = 3'b001;
    localparam DATA  = 3'b010;
    localparam STOP  = 3'b011;
    
    reg [2:0] state;
    reg [15:0] clk_count;
    reg [2:0] bit_index;
    reg [7:0] rx_byte;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            data_valid <= 1'b0;
            clk_count <= 16'h0000;
            bit_index <= 3'h0;
            rx_byte <= 8'h00;
            data_out <= 8'h00;
        end else begin
            data_valid <= 1'b0;  // Default: pulse for one cycle
            
            case (state)
                IDLE: begin
                    clk_count <= 16'h0000;
                    bit_index <= 3'h0;
                    
                    if (rx == 1'b0) begin  // Start bit detected
                        state <= START;
                    end
                end
                
                START: begin
                    // Wait to middle of start bit to confirm
                    if (clk_count < CLKS_PER_HALF_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        if (rx == 1'b0) begin  // Valid start bit
                            clk_count <= 16'h0000;
                            state <= DATA;
                        end else begin
                            state <= IDLE;  // False start
                        end
                    end
                end
                
                DATA: begin
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 16'h0000;
                        rx_byte[bit_index] <= rx;  // Sample at middle
                        
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;
                        end else begin
                            bit_index <= 3'h0;
                            state <= STOP;
                        end
                    end
                end
                
                STOP: begin
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 16'h0000;
                        data_out <= rx_byte;
                        data_valid <= 1'b1;
                        state <= IDLE;
                    end
                end
                
                default: state <= IDLE;
            endcase
        end
    end
endmodule
```

### Complete UART Loopback Example

```verilog
module uart_loopback #(
    parameter CLK_FREQ = 50000000,
    parameter BAUD_RATE = 115200
)(
    input  wire clk,
    input  wire rst_n,
    input  wire rx,
    output wire tx
);

    wire [7:0] rx_data;
    wire rx_valid;
    wire tx_busy;
    
    // Receiver
    uart_receiver #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) uart_rx (
        .clk(clk),
        .rst_n(rst_n),
        .rx(rx),
        .data_out(rx_data),
        .data_valid(rx_valid)
    );
    
    // Transmitter
    uart_transmitter #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) uart_tx (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(rx_data),
        .start(rx_valid),
        .tx(tx),
        .busy(tx_busy)
    );
    
endmodule
```

## SPI (Serial Peripheral Interface)

SPI is a synchronous serial protocol with:
- **Higher speed** than UART (can be MHz+)
- **4 wires**: SCLK, MOSI, MISO, SS/CS
- **Master-slave** architecture
- **Full-duplex** communication

### SPI Signals

```
Master                              Slave
┌──────────┐                    ┌──────────┐
│          │──SCLK (clock)─────→│          │
│          │──MOSI (data out)──→│          │
│          │←─MISO (data in)────│          │
│          │──SS/CS (select)───→│          │
└──────────┘                    └──────────┘
```

- **SCLK**: Serial Clock (generated by master)
- **MOSI**: Master Out, Slave In (data from master to slave)
- **MISO**: Master In, Slave Out (data from slave to master)
- **SS/CS**: Slave Select / Chip Select (active low)

### SPI Timing Modes

SPI has 4 modes based on clock polarity (CPOL) and phase (CPHA):

| Mode | CPOL | CPHA | Clock Idle | Sample Edge |
|------|------|------|------------|-------------|
| 0    | 0    | 0    | Low        | Rising      |
| 1    | 0    | 1    | Low        | Falling     |
| 2    | 1    | 0    | High       | Falling     |
| 3    | 1    | 1    | High       | Rising      |

**Most common: Mode 0**

### SPI Mode 0 Timing

```
         ___     ___     ___     ___     ___     ___     ___     ___
SCLK ___|   |___|   |___|   |___|   |___|   |___|   |___|   |___|   |___
           ^       ^       ^       ^       ^       ^       ^       ^
           Sample  Sample  Sample  Sample  Sample  Sample  Sample  Sample

     ____________________________________________________________________
SS        |______________________________________________________________
          (Active low - selects slave)

MOSI  ----< D7 >---< D6 >---< D5 >---< D4 >---< D3 >---< D2 >---< D1 >---< D0 >---
          (MSB first)

MISO  ----< D7 >---< D6 >---< D5 >---< D4 >---< D3 >---< D2 >---< D1 >---< D0 >---

Data sampled on rising edge, shifted on falling edge
```

### SPI Master

```verilog
module spi_master #(
    parameter CLK_DIV = 4  // SPI clock = clk / (2 * CLK_DIV)
)(
    input  wire       clk,
    input  wire       rst_n,
    
    // Control interface
    input  wire [7:0] data_in,
    input  wire       start,
    output reg  [7:0] data_out,
    output reg        done,
    output reg        busy,
    
    // SPI interface
    output reg        sclk,
    output reg        mosi,
    input  wire       miso,
    output reg        ss_n
);

    localparam IDLE  = 2'b00;
    localparam TRANSFER = 2'b01;
    localparam FINISH = 2'b10;
    
    reg [1:0] state;
    reg [7:0] tx_buffer;
    reg [7:0] rx_buffer;
    reg [3:0] bit_count;
    reg [3:0] clk_count;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            sclk <= 1'b0;
            mosi <= 1'b0;
            ss_n <= 1'b1;
            done <= 1'b0;
            busy <= 1'b0;
            bit_count <= 4'h0;
            clk_count <= 4'h0;
            tx_buffer <= 8'h00;
            rx_buffer <= 8'h00;
            data_out <= 8'h00;
        end else begin
            done <= 1'b0;  // Pulse for one cycle
            
            case (state)
                IDLE: begin
                    sclk <= 1'b0;
                    ss_n <= 1'b1;
                    busy <= 1'b0;
                    bit_count <= 4'h0;
                    
                    if (start) begin
                        tx_buffer <= data_in;
                        busy <= 1'b1;
                        ss_n <= 1'b0;  // Select slave
                        state <= TRANSFER;
                    end
                end
                
                TRANSFER: begin
                    if (clk_count < CLK_DIV - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 4'h0;
                        sclk <= ~sclk;
                        
                        if (sclk == 1'b0) begin
                            // Rising edge: sample MISO
                            rx_buffer <= {rx_buffer[6:0], miso};
                        end else begin
                            // Falling edge: update MOSI
                            mosi <= tx_buffer[7];
                            tx_buffer <= {tx_buffer[6:0], 1'b0};
                            bit_count <= bit_count + 1;
                            
                            if (bit_count == 4'd7) begin
                                state <= FINISH;
                            end
                        end
                    end
                end
                
                FINISH: begin
                    ss_n <= 1'b1;
                    data_out <= rx_buffer;
                    done <= 1'b1;
                    state <= IDLE;
                end
                
                default: state <= IDLE;
            endcase
        end
    end
endmodule
```

### SPI Slave

```verilog
module spi_slave (
    input  wire       clk,
    input  wire       rst_n,
    
    // SPI interface
    input  wire       sclk,
    input  wire       mosi,
    output reg        miso,
    input  wire       ss_n,
    
    // Data interface
    input  wire [7:0] data_in,
    output reg  [7:0] data_out,
    output reg        data_valid
);

    reg [7:0] tx_buffer;
    reg [7:0] rx_buffer;
    reg [2:0] bit_count;
    reg sclk_prev;
    
    // Edge detection for SCLK
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sclk_prev <= 1'b0;
        end else begin
            sclk_prev <= sclk;
        end
    end
    
    wire sclk_rising = sclk && !sclk_prev;
    wire sclk_falling = !sclk && sclk_prev;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            miso <= 1'b0;
            bit_count <= 3'h0;
            tx_buffer <= 8'h00;
            rx_buffer <= 8'h00;
            data_out <= 8'h00;
            data_valid <= 1'b0;
        end else begin
            data_valid <= 1'b0;
            
            if (ss_n) begin
                // Not selected
                bit_count <= 3'h0;
                tx_buffer <= data_in;  // Load data to send
            end else begin
                // Selected
                if (sclk_rising) begin
                    // Sample MOSI on rising edge
                    rx_buffer <= {rx_buffer[6:0], mosi};
                    bit_count <= bit_count + 1;
                    
                    if (bit_count == 3'd7) begin
                        data_out <= {rx_buffer[6:0], mosi};
                        data_valid <= 1'b1;
                    end
                end
                
                if (sclk_falling) begin
                    // Update MISO on falling edge
                    miso <= tx_buffer[7];
                    tx_buffer <= {tx_buffer[6:0], 1'b0};
                end
            end
        end
    end
endmodule
```

## Protocol Comparison

| Feature | UART | SPI | I2C |
|---------|------|-----|-----|
| **Wires** | 2 | 4 | 2 |
| **Speed** | Low-Med (115.2k) | High (MHz+) | Medium (400k) |
| **Complexity** | Simple | Medium | Complex |
| **Devices** | 1-to-1 | 1 master, multiple slaves | Multi-master, multi-slave |
| **Full-duplex** | Yes | Yes | No |
| **Clock** | Async | Sync | Sync |
| **Use case** | Debug, simple | High-speed sensors | Multiple devices on bus |

## Common Applications

### UART:
- Serial console/debugging
- GPS modules
- Bluetooth (HC-05, HC-06)
- GSM modules
- Simple device-to-device

### SPI:
- SD cards
- Flash memory
- ADC/DAC
- Display controllers
- High-speed sensors

### I2C:
- EEPROMs
- RTCs (Real-Time Clocks)
- Temperature sensors
- Multiple sensors on one bus

## Practice Exercises

### Exercise 1: UART Echo
Modify the UART to echo received characters back with a prefix "You sent: "

### Exercise 2: SPI Temperature Sensor
Interface with an SPI temperature sensor (e.g., MAX6675)

### Exercise 3: Multi-Byte UART
Extend UART to send/receive multi-byte messages with start/end markers

### Exercise 4: SPI Flash Controller
Design a controller to read from SPI flash memory

## Summary

In this part, you learned:

- ✅ UART protocol and frame format
- ✅ UART transmitter and receiver implementation
- ✅ SPI protocol basics
- ✅ SPI master and slave implementation
- ✅ Protocol timing diagrams
- ✅ When to use each protocol
- ✅ Real-world applications

## What's Next?

In [Part 10: Debugging Techniques](./10_Debugging.md), we'll learn:
- Systematic debugging approaches
- Waveform analysis
- Finding timing violations
- Common bug patterns
- Tools and techniques

**Master the art of debugging Verilog!** 🚀

---

**Ready to become a debugging expert? Continue to Part 10!**

