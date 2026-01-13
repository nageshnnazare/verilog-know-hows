//============================================================================
// Example 8: Simple FIFO (First-In-First-Out) Buffer
// Description: 8-entry, 8-bit synchronous FIFO
//============================================================================

module fifo_8x8 (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       wr_en,
    input  wire       rd_en,
    input  wire [7:0] data_in,
    output reg  [7:0] data_out,
    output wire       full,
    output wire       empty
);

    // FIFO memory
    reg [7:0] mem [0:7];
    
    // Read and write pointers (4 bits to detect full/empty)
    reg [3:0] wr_ptr, rd_ptr;
    
    // Full when write pointer wraps and catches read pointer
    assign full  = (wr_ptr[2:0] == rd_ptr[2:0]) && (wr_ptr[3] != rd_ptr[3]);
    
    // Empty when pointers are equal
    assign empty = (wr_ptr == rd_ptr);
    
    // Write operation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wr_ptr <= 4'h0;
        end else if (wr_en && !full) begin
            mem[wr_ptr[2:0]] <= data_in;
            wr_ptr <= wr_ptr + 1;
        end
    end
    
    // Read operation
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            rd_ptr <= 4'h0;
            data_out <= 8'h00;
        end else if (rd_en && !empty) begin
            data_out <= mem[rd_ptr[2:0]];
            rd_ptr <= rd_ptr + 1;
        end
    end

endmodule

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module fifo_8x8_tb;
    reg        clk;
    reg        rst_n;
    reg        wr_en;
    reg        rd_en;
    reg  [7:0] data_in;
    wire [7:0] data_out;
    wire       full;
    wire       empty;
    
    integer i;
    integer error_count;
    
    fifo_8x8 dut (
        .clk(clk),
        .rst_n(rst_n),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $dumpfile("fifo.vcd");
        $dumpvars(0, fifo_8x8_tb);
        
        error_count = 0;
        
        // Initialize
        rst_n = 0;
        wr_en = 0;
        rd_en = 0;
        data_in = 8'h00;
        
        #15 rst_n = 1;
        
        $display("\n=== FIFO Test ===\n");
        
        // Test 1: Check empty flag
        @(posedge clk);
        if (empty && !full)
            $display("✓ Test 1 PASSED: FIFO is empty after reset");
        else begin
            $display("✗ Test 1 FAILED: Empty flag incorrect");
            error_count = error_count + 1;
        end
        
        // Test 2: Write data to FIFO
        $display("\nTest 2: Writing 8 values to FIFO");
        for (i = 0; i < 8; i = i + 1) begin
            @(posedge clk);
            wr_en = 1;
            data_in = i * 16;  // Write 0x00, 0x10, 0x20, ...
            $display("Writing: 0x%h", data_in);
        end
        @(posedge clk) wr_en = 0;
        
        // Test 3: Check full flag
        if (full && !empty)
            $display("✓ Test 3 PASSED: FIFO is full");
        else begin
            $display("✗ Test 3 FAILED: Full flag incorrect");
            error_count = error_count + 1;
        end
        
        // Test 4: Try to write when full (should be ignored)
        $display("\nTest 4: Attempting write when full (should be ignored)");
        @(posedge clk);
        wr_en = 1;
        data_in = 8'hFF;
        @(posedge clk);
        wr_en = 0;
        if (full)
            $display("✓ Test 4 PASSED: Write ignored when full");
        
        // Test 5: Read all data
        $display("\nTest 5: Reading all values from FIFO");
        rd_en = 1;
        for (i = 0; i < 8; i = i + 1) begin
            @(posedge clk);
            #1;  // Wait for output
            $display("Read: 0x%h (expected 0x%h)", data_out, i * 16);
            if (data_out != i * 16) begin
                $display("✗ Data mismatch!");
                error_count = error_count + 1;
            end
        end
        @(posedge clk) rd_en = 0;
        
        // Test 6: Check empty flag
        @(posedge clk);
        if (empty && !full)
            $display("✓ Test 6 PASSED: FIFO is empty after reading all");
        else begin
            $display("✗ Test 6 FAILED: Empty flag incorrect");
            error_count = error_count + 1;
        end
        
        // Test 7: Simultaneous read/write
        $display("\nTest 7: Simultaneous read and write");
        @(posedge clk);
        wr_en = 1;
        data_in = 8'hAA;
        @(posedge clk);
        wr_en = 0;
        
        @(posedge clk);
        wr_en = 1;
        rd_en = 1;
        data_in = 8'hBB;
        @(posedge clk);
        #1;
        if (data_out == 8'hAA)
            $display("✓ Test 7 PASSED: Simultaneous operations work");
        else begin
            $display("✗ Test 7 FAILED: Unexpected data");
            error_count = error_count + 1;
        end
        
        #50;
        
        if (error_count == 0)
            $display("\n✓ ALL FIFO TESTS PASSED!");
        else
            $display("\n✗ %0d TEST(S) FAILED", error_count);
        
        $finish;
    end
endmodule

