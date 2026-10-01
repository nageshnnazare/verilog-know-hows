//==============================================================================
// HDLBits 162 — Add/sub
// Official problem: https://hdlbits.01xz.net/wiki/Bugs_addsubz
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 8-bit add/subtract with zero flag. `do_sub`=0 add, =1 subtract.
// `result` is the sum/difference, `zero` is 1 when result is 0.
// Typical bug: `zero` is assigned with blocking/wrong timing, or
// subtract uses + instead of -, or zero checks the operands.
//

module top_module (
    input            do_sub,
    input      [7:0] a,
    input      [7:0] b,
    output reg [7:0] out,
    output           result_is_zero
);
    always @(*) begin
        case (do_sub)
            0: out = a + b;
            1: out = a - b;
        endcase
    end
    assign result_is_zero = (out == 8'd0);
endmodule
