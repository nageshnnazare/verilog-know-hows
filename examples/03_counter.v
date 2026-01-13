//============================================================================
// Example 3: 8-bit Counter with Enable and Load
// Description: Demonstrates sequential logic and control signals
//============================================================================

module counter_8bit (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       enable,
    input  wire       load,
    input  wire [7:0] load_value,
    output reg  [7:0] count
);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            count <= 8'h00;
        else if (load)
            count <= load_value;
        else if (enable)
            count <= count + 1;
    end

endmodule

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module counter_8bit_tb;
    reg        clk;
    reg        rst_n;
    reg        enable;
    reg        load;
    reg  [7:0] load_value;
    wire [7:0] count;
    
    counter_8bit dut (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .load(load),
        .load_value(load_value),
        .count(count)
    );
    
    // Clock generation: 100MHz (10ns period)
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $dumpfile("counter_8bit.vcd");
        $dumpvars(0, counter_8bit_tb);
        
        // Initialize
        rst_n = 0;
        enable = 0;
        load = 0;
        load_value = 8'h00;
        
        $display("Time\trst_n\tenable\tload\tload_val\tcount");
        $display("==================================================");
        
        // Release reset
        #15 rst_n = 1;
        
        // Enable counting
        @(posedge clk) enable = 1;
        $display("%0t\t%b\t%b\t%b\t%h\t\t%h", $time, rst_n, enable, load, load_value, count);
        
        // Count for a few cycles
        repeat(10) begin
            @(posedge clk);
            $display("%0t\t%b\t%b\t%b\t%h\t\t%h", $time, rst_n, enable, load, load_value, count);
        end
        
        // Test load functionality
        @(posedge clk) begin
            load = 1;
            load_value = 8'h50;
        end
        $display("%0t\t%b\t%b\t%b\t%h\t\t%h (LOAD)", $time, rst_n, enable, load, load_value, count);
        
        @(posedge clk) load = 0;
        
        // Continue counting
        repeat(5) begin
            @(posedge clk);
            $display("%0t\t%b\t%b\t%b\t%h\t\t%h", $time, rst_n, enable, load, load_value, count);
        end
        
        // Test disable
        @(posedge clk) enable = 0;
        $display("%0t\t%b\t%b\t%b\t%h\t\t%h (DISABLED)", $time, rst_n, enable, load, load_value, count);
        
        repeat(3) begin
            @(posedge clk);
            $display("%0t\t%b\t%b\t%b\t%h\t\t%h", $time, rst_n, enable, load, load_value, count);
        end
        
        $display("\n✓ Counter test completed successfully!");
        $finish;
    end
    
    // Timeout
    initial begin
        #1000;
        $display("✗ Test timeout!");
        $finish;
    end
endmodule

