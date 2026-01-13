//============================================================================
// Example 7: Sequence Detector FSM (detects "101")
// Description: Moore machine that detects the binary pattern "101"
//============================================================================

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
                    next_state = GOT_1;
                else
                    next_state = GOT_10;
            end
            
            GOT_10: begin
                if (data_in)
                    next_state = GOT_101;
                else
                    next_state = IDLE;
            end
            
            GOT_101: begin
                if (data_in)
                    next_state = GOT_1;
                else
                    next_state = GOT_10;
            end
            
            default: next_state = IDLE;
        endcase
    end
    
    // Output logic (Moore - depends only on state)
    always @(*) begin
        detected = (state == GOT_101);
    end

endmodule

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module sequence_detector_101_tb;
    reg  clk;
    reg  rst_n;
    reg  data_in;
    wire detected;
    
    integer error_count;
    
    sequence_detector_101 dut (
        .clk(clk),
        .rst_n(rst_n),
        .data_in(data_in),
        .detected(detected)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Task to send a bit
    task send_bit;
        input bit_val;
        begin
            @(posedge clk) data_in = bit_val;
            #1;  // Small delay for signal to propagate
            $display("Time %0t: Sent %b, State output: detected=%b", 
                     $time, bit_val, detected);
        end
    endtask
    
    initial begin
        $dumpfile("sequence_detector.vcd");
        $dumpvars(0, sequence_detector_101_tb);
        
        error_count = 0;
        
        // Initialize
        rst_n = 0;
        data_in = 0;
        
        #15 rst_n = 1;
        
        $display("\n=== Sequence Detector (101) Test ===\n");
        
        // Test 1: Send exact sequence 101
        $display("Test 1: Sending sequence 1-0-1");
        send_bit(1);
        send_bit(0);
        send_bit(1);
        @(posedge clk);
        #1;
        if (detected)
            $display("✓ Test 1 PASSED: Sequence detected");
        else begin
            $display("✗ Test 1 FAILED: Should detect 101");
            error_count = error_count + 1;
        end
        
        // Test 2: Send non-matching sequence
        $display("\nTest 2: Sending sequence 1-1-0 (should NOT detect)");
        send_bit(1);
        send_bit(1);
        send_bit(0);
        @(posedge clk);
        #1;
        if (!detected)
            $display("✓ Test 2 PASSED: Correctly did not detect");
        else begin
            $display("✗ Test 2 FAILED: False detection");
            error_count = error_count + 1;
        end
        
        // Test 3: Overlapping sequences
        $display("\nTest 3: Sending 1-0-1-0-1 (overlapping)");
        send_bit(1);
        send_bit(0);
        send_bit(1);
        @(posedge clk);
        #1;
        if (detected)
            $display("✓ First 101 detected");
        else begin
            $display("✗ First 101 not detected");
            error_count = error_count + 1;
        end
        
        send_bit(0);
        send_bit(1);
        @(posedge clk);
        #1;
        if (detected)
            $display("✓ Second overlapping 101 detected");
        else begin
            $display("✗ Second 101 not detected");
            error_count = error_count + 1;
        end
        
        // Test 4: Multiple 1's before pattern
        $display("\nTest 4: Sending 1-1-1-0-1");
        send_bit(1);
        send_bit(1);
        send_bit(1);
        send_bit(0);
        send_bit(1);
        @(posedge clk);
        #1;
        if (detected)
            $display("✓ Detected 101 after multiple 1's");
        else begin
            $display("✗ Should have detected 101");
            error_count = error_count + 1;
        end
        
        #50;
        
        if (error_count == 0)
            $display("\n✓ ALL TESTS PASSED!");
        else
            $display("\n✗ %0d TEST(S) FAILED", error_count);
        
        $finish;
    end
endmodule

