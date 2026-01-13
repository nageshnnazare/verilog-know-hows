//============================================================================
// Example 4: 8-bit Shift Register (SISO and PISO)
// Description: Serial-in serial-out and parallel-in serial-out shift registers
//============================================================================

// Serial-In Serial-Out (SISO)
module shift_register_siso (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       serial_in,
    output wire       serial_out
);
    reg [7:0] shift_reg;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            shift_reg <= 8'h00;
        else
            shift_reg <= {shift_reg[6:0], serial_in};
    end
    
    assign serial_out = shift_reg[7];
endmodule

// Parallel-In Serial-Out (PISO)
module shift_register_piso (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       load,
    input  wire [7:0] parallel_in,
    output wire       serial_out
);
    reg [7:0] shift_reg;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            shift_reg <= 8'h00;
        else if (load)
            shift_reg <= parallel_in;
        else
            shift_reg <= {shift_reg[6:0], 1'b0};
    end
    
    assign serial_out = shift_reg[7];
endmodule

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module shift_register_tb;
    reg        clk;
    reg        rst_n;
    reg        serial_in;
    reg        load;
    reg  [7:0] parallel_in;
    wire       siso_out;
    wire       piso_out;
    
    shift_register_siso dut_siso (
        .clk(clk),
        .rst_n(rst_n),
        .serial_in(serial_in),
        .serial_out(siso_out)
    );
    
    shift_register_piso dut_piso (
        .clk(clk),
        .rst_n(rst_n),
        .load(load),
        .parallel_in(parallel_in),
        .serial_out(piso_out)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $dumpfile("shift_register.vcd");
        $dumpvars(0, shift_register_tb);
        
        // Initialize
        rst_n = 0;
        serial_in = 0;
        load = 0;
        parallel_in = 8'h00;
        
        #15 rst_n = 1;
        
        $display("=== Testing SISO Shift Register ===");
        $display("Shifting in: 10110011");
        
        // Shift in the pattern: 1-0-1-1-0-0-1-1
        @(posedge clk) serial_in = 1;
        @(posedge clk) serial_in = 0;
        @(posedge clk) serial_in = 1;
        @(posedge clk) serial_in = 1;
        @(posedge clk) serial_in = 0;
        @(posedge clk) serial_in = 0;
        @(posedge clk) serial_in = 1;
        @(posedge clk) serial_in = 1;
        
        $display("Shifted in complete. Now shifting out...");
        
        // Shift out (input zeros)
        serial_in = 0;
        repeat(8) begin
            @(posedge clk);
            $display("Time %0t: siso_out = %b", $time, siso_out);
        end
        
        $display("\n=== Testing PISO Shift Register ===");
        
        // Load parallel data
        @(posedge clk) begin
            load = 1;
            parallel_in = 8'b10110011;
        end
        $display("Loaded: %b", parallel_in);
        
        @(posedge clk) load = 0;
        
        // Shift out serially
        $display("Shifting out...");
        repeat(8) begin
            @(posedge clk);
            $display("Time %0t: piso_out = %b", $time, piso_out);
        end
        
        #50;
        $display("\n✓ Shift register test completed!");
        $finish;
    end
endmodule

