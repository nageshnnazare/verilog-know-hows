//============================================================================
// Example 9: UART Transmitter
// Description: Complete UART TX implementation
//============================================================================

module uart_tx #(
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

    localparam CLKS_PER_BIT = CLK_FREQ / BAUD_RATE;
    
    localparam IDLE  = 3'b000;
    localparam START_BIT = 3'b001;
    localparam DATA_BITS = 3'b010;
    localparam STOP_BIT  = 3'b011;
    
    reg [2:0] state;
    reg [15:0] clk_count;
    reg [2:0] bit_index;
    reg [7:0] tx_data;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= IDLE;
            tx <= 1'b1;
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
                        state <= START_BIT;
                    end
                end
                
                START_BIT: begin
                    tx <= 1'b0;
                    
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 16'h0000;
                        state <= DATA_BITS;
                    end
                end
                
                DATA_BITS: begin
                    tx <= tx_data[bit_index];
                    
                    if (clk_count < CLKS_PER_BIT - 1) begin
                        clk_count <= clk_count + 1;
                    end else begin
                        clk_count <= 16'h0000;
                        
                        if (bit_index < 7) begin
                            bit_index <= bit_index + 1;
                        end else begin
                            bit_index <= 3'h0;
                            state <= STOP_BIT;
                        end
                    end
                end
                
                STOP_BIT: begin
                    tx <= 1'b1;
                    
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

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module uart_tx_tb;
    reg        clk;
    reg        rst_n;
    reg  [7:0] data_in;
    reg        start;
    wire       tx;
    wire       busy;
    
    // For fast simulation, use lower clock frequency
    localparam CLK_FREQ = 1000000;   // 1 MHz
    localparam BAUD_RATE = 9600;
    
    uart_tx #(
        .CLK_FREQ(CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .start(start),
        .tx(tx),
        .busy(busy)
    );
    
    // Clock generation: 1 MHz
    initial begin
        clk = 0;
        forever #500 clk = ~clk;  // 1 µs period
    end
    
    // Task to send a byte
    task send_byte;
        input [7:0] data;
        begin
            @(posedge clk);
            data_in = data;
            start = 1;
            @(posedge clk);
            start = 0;
            
            // Wait for transmission to complete
            wait(busy == 0);
            $display("Sent byte: 0x%h ('%c')", data, data);
        end
    endtask
    
    initial begin
        $dumpfile("uart_tx.vcd");
        $dumpvars(0, uart_tx_tb);
        
        // Initialize
        rst_n = 0;
        start = 0;
        data_in = 8'h00;
        
        #1000 rst_n = 1;
        
        $display("\n=== UART Transmitter Test ===\n");
        
        // Send "Hello"
        send_byte(8'h48);  // 'H'
        send_byte(8'h65);  // 'e'
        send_byte(8'h6C);  // 'l'
        send_byte(8'h6C);  // 'l'
        send_byte(8'h6F);  // 'o'
        
        #10000;
        $display("\n✓ UART TX test completed!");
        $finish;
    end
endmodule

