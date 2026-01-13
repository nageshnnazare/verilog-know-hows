//============================================================================
// Example 12: Signed Arithmetic
// Description: Demonstrates signed number operations and overflow detection
//============================================================================

module signed_alu (
    input  wire signed [7:0]  a,
    input  wire signed [7:0]  b,
    input  wire [2:0]         opcode,
    output reg  signed [7:0]  result,
    output reg                overflow,
    output reg                zero,
    output reg                negative
);

    localparam OP_ADD = 3'b000;
    localparam OP_SUB = 3'b001;
    localparam OP_MUL = 3'b010;
    localparam OP_ABS = 3'b011;
    localparam OP_NEG = 3'b100;
    localparam OP_CMP = 3'b101;  // Compare (sets flags)
    
    reg signed [8:0] temp_result;  // 9 bits for overflow detection
    
    always @(*) begin
        overflow = 1'b0;
        temp_result = 9'sh000;
        
        case (opcode)
            OP_ADD: begin
                temp_result = a + b;
                result = temp_result[7:0];
                // Overflow if signs match but result sign differs
                overflow = (a[7] == b[7]) && (result[7] != a[7]);
            end
            
            OP_SUB: begin
                temp_result = a - b;
                result = temp_result[7:0];
                // Overflow if signs differ and result sign matches b
                overflow = (a[7] != b[7]) && (result[7] == b[7]);
            end
            
            OP_MUL: begin
                // Multiply and take lower 8 bits
                result = a * b;
                // Check if result doesn't fit in 8 bits
                overflow = (a * b > 127) || (a * b < -128);
            end
            
            OP_ABS: begin
                if (a < 0)
                    result = -a;
                else
                    result = a;
                // Overflow if a = -128 (can't represent +128)
                overflow = (a == -128);
            end
            
            OP_NEG: begin
                result = -a;
                overflow = (a == -128);
            end
            
            OP_CMP: begin
                // Compare: result = 0 if equal, negative if a<b, positive if a>b
                result = a - b;
            end
            
            default: result = 8'sh00;
        endcase
        
        // Status flags
        zero = (result == 8'sh00);
        negative = result[7];  // MSB is sign bit
    end
endmodule

//============================================================================
// Sign Extension Example
//============================================================================

module sign_extend (
    input  wire signed [7:0]  data_in,   // 8-bit signed
    output wire signed [15:0] data_out   // 16-bit signed
);
    // Sign extend: replicate MSB
    assign data_out = {{8{data_in[7]}}, data_in};
endmodule

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module signed_alu_tb;
    reg  signed [7:0] a, b;
    reg  [2:0]        opcode;
    wire signed [7:0] result;
    wire              overflow, zero, negative;
    
    signed_alu dut (
        .a(a), .b(b), .opcode(opcode),
        .result(result), .overflow(overflow),
        .zero(zero), .negative(negative)
    );
    
    task test_op;
        input signed [7:0] in_a, in_b;
        input [2:0] op;
        input [63:0] op_name;
        begin
            a = in_a;
            b = in_b;
            opcode = op;
            #10;
            $display("%s: %0d op %0d = %0d | OV=%b Z=%b N=%b",
                     op_name, in_a, in_b, result,
                     overflow, zero, negative);
        end
    endtask
    
    initial begin
        $dumpfile("signed_alu.vcd");
        $dumpvars(0, signed_alu_tb);
        
        $display("\n=== Signed Arithmetic Test ===\n");
        $display("Operation | Overflow | Zero | Negative");
        $display("==========================================");
        
        // Test addition
        $display("\n--- Addition ---");
        test_op(8'sd10, 8'sd20, 3'b000, "ADD");      // 10 + 20 = 30
        test_op(8'sd127, 8'sd1, 3'b000, "ADD");      // Overflow! 127+1=-128
        test_op(-8'sd50, -8'sd30, 3'b000, "ADD");    // -50 + -30 = -80
        test_op(-8'sd100, -8'sd50, 3'b000, "ADD");   // Overflow! -100-50=106
        
        // Test subtraction
        $display("\n--- Subtraction ---");
        test_op(8'sd50, 8'sd30, 3'b001, "SUB");      // 50 - 30 = 20
        test_op(8'sd10, 8'sd50, 3'b001, "SUB");      // 10 - 50 = -40
        test_op(8'sd127, -8'sd1, 3'b001, "SUB");     // Overflow! 127-(-1)=-128
        test_op(-8'sd128, 8'sd1, 3'b001, "SUB");     // Overflow! -128-1=127
        
        // Test multiplication
        $display("\n--- Multiplication ---");
        test_op(8'sd5, 8'sd6, 3'b010, "MUL");        // 5 * 6 = 30
        test_op(8'sd10, 8'sd-3, 3'b010, "MUL");      // 10 * -3 = -30
        test_op(8'sd16, 8'sd8, 3'b010, "MUL");       // Overflow! 16*8=128>127
        
        // Test absolute value
        $display("\n--- Absolute Value ---");
        test_op(8'sd50, 8'sd0, 3'b011, "ABS");       // |50| = 50
        test_op(-8'sd50, 8'sd0, 3'b011, "ABS");      // |-50| = 50
        test_op(-8'sd128, 8'sd0, 3'b011, "ABS");     // Overflow! |-128| can't fit
        
        // Test negation
        $display("\n--- Negation ---");
        test_op(8'sd50, 8'sd0, 3'b100, "NEG");       // -50 = -50
        test_op(-8'sd50, 8'sd0, 3'b100, "NEG");      // -(-50) = 50
        test_op(-8'sd128, 8'sd0, 3'b100, "NEG");     // Overflow! -(-128)=128
        
        // Test comparison
        $display("\n--- Comparison (result shows difference) ---");
        test_op(8'sd50, 8'sd50, 3'b101, "CMP");      // Equal: result=0
        test_op(8'sd10, 8'sd50, 3'b101, "CMP");      // Less: result<0
        test_op(8'sd50, 8'sd10, 3'b101, "CMP");      // Greater: result>0
        
        // Test sign extension
        $display("\n--- Sign Extension Test ---");
        reg signed [7:0] small;
        wire signed [15:0] extended;
        sign_extend ext (.data_in(small), .data_out(extended));
        
        small = 8'sd50;
        #10;
        $display("8-bit: %0d (0x%h) → 16-bit: %0d (0x%h)", 
                 small, small, extended, extended);
        
        small = -8'sd50;
        #10;
        $display("8-bit: %0d (0x%h) → 16-bit: %0d (0x%h)", 
                 small, small, extended, extended);
        
        #50;
        $display("\n✓ Signed arithmetic test completed!");
        $finish;
    end
endmodule

