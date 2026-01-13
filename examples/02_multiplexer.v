//============================================================================
// Example 2: 4-to-1 Multiplexer
// Description: Multiplexer with different implementation styles
//============================================================================

// Style 1: Using conditional operator
module mux4to1_conditional (
    input  wire [1:0] sel,
    input  wire [7:0] in0, in1, in2, in3,
    output wire [7:0] out
);
    assign out = (sel == 2'b00) ? in0 :
                 (sel == 2'b01) ? in1 :
                 (sel == 2'b10) ? in2 : in3;
endmodule

// Style 2: Using case statement
module mux4to1_case (
    input  wire [1:0] sel,
    input  wire [7:0] in0, in1, in2, in3,
    output reg  [7:0] out
);
    always @(*) begin
        case (sel)
            2'b00: out = in0;
            2'b01: out = in1;
            2'b10: out = in2;
            2'b11: out = in3;
        endcase
    end
endmodule

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module mux4to1_tb;
    reg  [1:0] sel;
    reg  [7:0] in0, in1, in2, in3;
    wire [7:0] out_cond, out_case;
    
    mux4to1_conditional dut_cond (
        .sel(sel), .in0(in0), .in1(in1), .in2(in2), .in3(in3), .out(out_cond)
    );
    
    mux4to1_case dut_case (
        .sel(sel), .in0(in0), .in1(in1), .in2(in2), .in3(in3), .out(out_case)
    );
    
    initial begin
        $dumpfile("mux4to1.vcd");
        $dumpvars(0, mux4to1_tb);
        
        // Initialize inputs
        in0 = 8'hAA;
        in1 = 8'hBB;
        in2 = 8'hCC;
        in3 = 8'hDD;
        
        $display("Time\tsel\tout_cond\tout_case");
        $display("==================================");
        
        sel = 2'b00; #10;
        $display("%0t\t%b\t%h\t%h", $time, sel, out_cond, out_case);
        
        sel = 2'b01; #10;
        $display("%0t\t%b\t%h\t%h", $time, sel, out_cond, out_case);
        
        sel = 2'b10; #10;
        $display("%0t\t%b\t%h\t%h", $time, sel, out_cond, out_case);
        
        sel = 2'b11; #10;
        $display("%0t\t%b\t%h\t%h", $time, sel, out_cond, out_case);
        
        // Verify both implementations match
        if (out_cond == out_case)
            $display("\n✓ Both implementations produce same results!");
        
        $finish;
    end
endmodule

