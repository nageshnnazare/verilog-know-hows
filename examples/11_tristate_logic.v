//============================================================================
// Example 11: Tri-State Buffer and Bidirectional Bus
// Description: Demonstrates tri-state logic and inout ports
//============================================================================

// Simple tri-state buffer
module tristate_buffer (
    input  wire       data_in,
    input  wire       enable,
    output wire       data_out
);
    // When enable=1, drive data_out with data_in
    // When enable=0, data_out is high-impedance (Z)
    assign data_out = enable ? data_in : 1'bz;
endmodule

// Bidirectional I/O port
module bidir_io (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       oe,         // Output enable
    input  wire [7:0] data_out,   // Data to drive
    output reg  [7:0] data_in,    // Data received
    inout  wire [7:0] bidir_port  // Bidirectional port
);
    // Drive the bidirectional port when output is enabled
    assign bidir_port = oe ? data_out : 8'hzz;
    
    // Always read from the bidirectional port
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            data_in <= 8'h00;
        else
            data_in <= bidir_port;
    end
endmodule

// Bus controller with multiple devices
module bus_controller (
    input  wire       clk,
    input  wire       rst_n,
    
    // Control
    input  wire [1:0] device_select,  // Which device drives bus
    
    // Device interfaces
    input  wire [7:0] device0_data,
    input  wire [7:0] device1_data,
    input  wire [7:0] device2_data,
    output reg  [7:0] bus_data_in,
    
    // Shared bus
    inout  wire [7:0] shared_bus
);
    wire enable0, enable1, enable2;
    
    // Only selected device drives the bus
    assign enable0 = (device_select == 2'b00);
    assign enable1 = (device_select == 2'b01);
    assign enable2 = (device_select == 2'b10);
    
    // Tri-state drivers
    assign shared_bus = enable0 ? device0_data : 8'hzz;
    assign shared_bus = enable1 ? device1_data : 8'hzz;
    assign shared_bus = enable2 ? device2_data : 8'hzz;
    
    // Read from bus
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            bus_data_in <= 8'h00;
        else
            bus_data_in <= shared_bus;
    end
endmodule

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module tristate_tb;
    reg        clk;
    reg        rst_n;
    reg  [1:0] device_select;
    reg  [7:0] device0_data;
    reg  [7:0] device1_data;
    reg  [7:0] device2_data;
    wire [7:0] bus_data_in;
    wire [7:0] shared_bus;
    
    bus_controller dut (
        .clk(clk),
        .rst_n(rst_n),
        .device_select(device_select),
        .device0_data(device0_data),
        .device1_data(device1_data),
        .device2_data(device2_data),
        .bus_data_in(bus_data_in),
        .shared_bus(shared_bus)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $dumpfile("tristate.vcd");
        $dumpvars(0, tristate_tb);
        
        // Initialize
        rst_n = 0;
        device_select = 2'b11;  // None selected
        device0_data = 8'hAA;
        device1_data = 8'hBB;
        device2_data = 8'hCC;
        
        #15 rst_n = 1;
        
        $display("\n=== Tri-State Bus Test ===\n");
        
        // Test each device
        $display("Selecting Device 0 (0xAA)");
        @(posedge clk);
        device_select = 2'b00;
        @(posedge clk);
        @(posedge clk);
        $display("  Bus value: 0x%h (expected 0xAA)", bus_data_in);
        
        $display("\nSelecting Device 1 (0xBB)");
        @(posedge clk);
        device_select = 2'b01;
        @(posedge clk);
        @(posedge clk);
        $display("  Bus value: 0x%h (expected 0xBB)", bus_data_in);
        
        $display("\nSelecting Device 2 (0xCC)");
        @(posedge clk);
        device_select = 2'b10;
        @(posedge clk);
        @(posedge clk);
        $display("  Bus value: 0x%h (expected 0xCC)", bus_data_in);
        
        $display("\nDeselecting all (High-Z)");
        @(posedge clk);
        device_select = 2'b11;
        @(posedge clk);
        @(posedge clk);
        $display("  Bus value: 0x%h (undefined/high-Z)", bus_data_in);
        
        #50;
        $display("\n✓ Tri-state test completed!");
        $finish;
    end
    
    // Monitor bus state
    always @(shared_bus) begin
        if (shared_bus === 8'hzz)
            $display("  [%0t] Bus is HIGH-Z", $time);
        else
            $display("  [%0t] Bus driven with: 0x%h", $time, shared_bus);
    end
endmodule

