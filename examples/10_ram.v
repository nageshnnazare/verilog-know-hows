//============================================================================
// Example 10: Single-Port RAM
// Description: Synchronous RAM with read/write capability
//============================================================================

module ram_single_port #(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 8,
    parameter DEPTH = 256
)(
    input  wire                    clk,
    input  wire                    we,      // Write enable
    input  wire [ADDR_WIDTH-1:0]   addr,
    input  wire [DATA_WIDTH-1:0]   data_in,
    output reg  [DATA_WIDTH-1:0]   data_out
);

    // Memory array
    reg [DATA_WIDTH-1:0] ram [0:DEPTH-1];
    
    // RAM operation
    always @(posedge clk) begin
        if (we)
            ram[addr] <= data_in;
        data_out <= ram[addr];
    end

endmodule

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module ram_single_port_tb;
    reg        clk;
    reg        we;
    reg  [7:0] addr;
    reg  [7:0] data_in;
    wire [7:0] data_out;
    
    integer i;
    integer errors;
    
    ram_single_port #(
        .DATA_WIDTH(8),
        .ADDR_WIDTH(8),
        .DEPTH(256)
    ) dut (
        .clk(clk),
        .we(we),
        .addr(addr),
        .data_in(data_in),
        .data_out(data_out)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $dumpfile("ram.vcd");
        $dumpvars(0, ram_single_port_tb);
        
        errors = 0;
        we = 0;
        addr = 8'h00;
        data_in = 8'h00;
        
        #10;
        
        $display("\n=== RAM Test ===\n");
        
        // Test 1: Write sequential pattern
        $display("Test 1: Writing sequential pattern");
        we = 1;
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            addr = i;
            data_in = i * 16;
            $display("  Writing 0x%h to address 0x%h", data_in, addr);
        end
        
        // Test 2: Read back and verify
        $display("\nTest 2: Reading and verifying");
        @(posedge clk);
        we = 0;
        
        for (i = 0; i < 16; i = i + 1) begin
            @(posedge clk);
            addr = i;
            @(posedge clk);  // Wait for read
            #1;  // Small delay for output
            $display("  Read 0x%h from address 0x%h (expected 0x%h)", 
                     data_out, i, i * 16);
            if (data_out != i * 16) begin
                $display("    ✗ ERROR: Data mismatch!");
                errors = errors + 1;
            end
        end
        
        // Test 3: Checkerboard pattern
        $display("\nTest 3: Checkerboard pattern");
        we = 1;
        for (i = 0; i < 32; i = i + 1) begin
            @(posedge clk);
            addr = i;
            if (i[0])
                data_in = 8'h55;
            else
                data_in = 8'hAA;
        end
        
        // Verify checkerboard
        @(posedge clk);
        we = 0;
        for (i = 0; i < 32; i = i + 1) begin
            @(posedge clk);
            addr = i;
            @(posedge clk);
            #1;
            if (i[0] && data_out != 8'h55) begin
                $display("  ✗ ERROR at address 0x%h", i);
                errors = errors + 1;
            end else if (!i[0] && data_out != 8'hAA) begin
                $display("  ✗ ERROR at address 0x%h", i);
                errors = errors + 1;
            end
        end
        
        if (errors == 0)
            $display("\n✓ All tests passed!");
        else
            $display("\n✗ %0d errors found", errors);
        
        #100;
        $finish;
    end
endmodule

