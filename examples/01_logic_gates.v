//============================================================================
// Example 1: Basic Logic Gates
// Description: Implementation of all basic logic gates
//============================================================================

module logic_gates (
    input  wire a,
    input  wire b,
    output wire and_out,
    output wire or_out,
    output wire not_out,
    output wire nand_out,
    output wire nor_out,
    output wire xor_out,
    output wire xnor_out
);

    assign and_out  = a & b;
    assign or_out   = a | b;
    assign not_out  = ~a;
    assign nand_out = ~(a & b);
    assign nor_out  = ~(a | b);
    assign xor_out  = a ^ b;
    assign xnor_out = ~(a ^ b);

endmodule

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module logic_gates_tb;
    reg a, b;
    wire and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out;
    
    logic_gates dut (
        .a(a), .b(b),
        .and_out(and_out), .or_out(or_out), .not_out(not_out),
        .nand_out(nand_out), .nor_out(nor_out),
        .xor_out(xor_out), .xnor_out(xnor_out)
    );
    
    initial begin
        $display("Time\ta\tb\tAND\tOR\tNOT\tNAND\tNOR\tXOR\tXNOR");
        $display("========================================================");
        
        a = 0; b = 0; #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", 
                 $time, a, b, and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out);
        
        a = 0; b = 1; #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", 
                 $time, a, b, and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out);
        
        a = 1; b = 0; #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", 
                 $time, a, b, and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out);
        
        a = 1; b = 1; #10;
        $display("%0t\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b\t%b", 
                 $time, a, b, and_out, or_out, not_out, nand_out, nor_out, xor_out, xnor_out);
        
        $finish;
    end
endmodule

