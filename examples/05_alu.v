//============================================================================
// Example 5: Simple ALU (Arithmetic Logic Unit)
// Description: 8-bit ALU with multiple operations
//============================================================================

module alu_8bit (
    input  wire [7:0]  a,
    input  wire [7:0]  b,
    input  wire [3:0]  opcode,
    output reg  [7:0]  result,
    output wire        zero,
    output wire        negative,
    output wire        overflow
);

    // Opcodes
    localparam OP_ADD  = 4'h0;
    localparam OP_SUB  = 4'h1;
    localparam OP_AND  = 4'h2;
    localparam OP_OR   = 4'h3;
    localparam OP_XOR  = 4'h4;
    localparam OP_NOT  = 4'h5;
    localparam OP_SLL  = 4'h6;  // Shift left logical
    localparam OP_SRL  = 4'h7;  // Shift right logical
    localparam OP_INC  = 4'h8;  // Increment
    localparam OP_DEC  = 4'h9;  // Decrement
    
    reg [8:0] temp_result;  // 9 bits for overflow detection
    
    always @(*) begin
        temp_result = 9'h000;
        case (opcode)
            OP_ADD:  temp_result = {1'b0, a} + {1'b0, b};
            OP_SUB:  temp_result = {1'b0, a} - {1'b0, b};
            OP_AND:  result = a & b;
            OP_OR:   result = a | b;
            OP_XOR:  result = a ^ b;
            OP_NOT:  result = ~a;
            OP_SLL:  result = a << b[2:0];
            OP_SRL:  result = a >> b[2:0];
            OP_INC:  temp_result = {1'b0, a} + 1;
            OP_DEC:  temp_result = {1'b0, a} - 1;
            default: result = 8'h00;
        endcase
        
        // Extract result for add/sub operations
        if (opcode == OP_ADD || opcode == OP_SUB || 
            opcode == OP_INC || opcode == OP_DEC)
            result = temp_result[7:0];
    end
    
    // Status flags
    assign zero     = (result == 8'h00);
    assign negative = result[7];
    assign overflow = temp_result[8];  // Carry/borrow bit
    
endmodule

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module alu_8bit_tb;
    reg  [7:0] a, b;
    reg  [3:0] opcode;
    wire [7:0] result;
    wire       zero, negative, overflow;
    
    alu_8bit dut (
        .a(a), .b(b), .opcode(opcode),
        .result(result), .zero(zero), .negative(negative), .overflow(overflow)
    );
    
    // Task to test an operation
    task test_op;
        input [7:0] in_a, in_b;
        input [3:0] op;
        input [63:0] op_name;  // String for operation name
        begin
            a = in_a;
            b = in_b;
            opcode = op;
            #10;
            $display("%s: %d (0x%h) op %d (0x%h) = %d (0x%h) | Z=%b N=%b V=%b",
                     op_name, in_a, in_a, in_b, in_b, result, result,
                     zero, negative, overflow);
        end
    endtask
    
    initial begin
        $dumpfile("alu_8bit.vcd");
        $dumpvars(0, alu_8bit_tb);
        
        $display("=== ALU Test ===");
        $display("Operation: a op b = result | Flags (Zero, Negative, oVerflow)");
        $display("=================================================================");
        
        // Test ADD
        test_op(8'd15, 8'd10, 4'h0, "ADD");
        test_op(8'd200, 8'd100, 4'h0, "ADD");  // Overflow
        
        // Test SUB
        test_op(8'd20, 8'd5, 4'h1, "SUB");
        test_op(8'd5, 8'd10, 4'h1, "SUB");  // Negative result
        
        // Test AND
        test_op(8'hF0, 8'h0F, 4'h2, "AND");
        
        // Test OR
        test_op(8'hF0, 8'h0F, 4'h3, "OR");
        
        // Test XOR
        test_op(8'hAA, 8'h55, 4'h4, "XOR");
        
        // Test NOT
        test_op(8'hAA, 8'h00, 4'h5, "NOT");
        
        // Test Shift Left
        test_op(8'h01, 8'd3, 4'h6, "SLL");
        
        // Test Shift Right
        test_op(8'h80, 8'd3, 4'h7, "SRL");
        
        // Test INC
        test_op(8'd10, 8'd0, 4'h8, "INC");
        
        // Test DEC
        test_op(8'd10, 8'd0, 4'h9, "DEC");
        
        // Test zero flag
        $display("\n--- Testing Zero Flag ---");
        test_op(8'd5, 8'd5, 4'h1, "SUB");  // Should produce zero
        
        #50;
        $display("\n✓ ALU test completed!");
        $finish;
    end
endmodule

