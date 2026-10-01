//==============================================================================
// HDLBits 034 — Priority encoder
// Official problem: https://hdlbits.01xz.net/wiki/Always_case2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build a 4-bit priority encoder: given `in[3:0]`, `pos` is the index
// of the first (least-significant) 1-bit. If `in` is 0, `pos` is 0
// (this version does not have a valid flag).
//

module top_module (
    input  [3:0] in,
    output reg [1:0] pos
);
    always @(*) begin
        casez (in)
            4'bzzz1: pos = 2'd0;
            4'bzz10: pos = 2'd1;
            4'bz100: pos = 2'd2;
            4'b1000: pos = 2'd3;
            default: pos = 2'd0;
        endcase
    end
endmodule
