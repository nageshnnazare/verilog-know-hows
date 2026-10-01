//==============================================================================
// HDLBits 163 — Case statement
// Official problem: https://hdlbits.01xz.net/wiki/Bugs_case
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Priority encoder / decoder via case. Typical bugs: missing default
// (latch), reversed case items, assigning the wrong output. The
// intended function maps sel=0..7 onto a one-hot-ish 8-bit `out`
// where out[sel]=1 if that item is enabled — HDLBits version:
// input [7:0] code, output reg [3:0] out, output valid.
// A 8-to-3 priority encoder: first 1 from LSB, valid=0 if none.
//

module top_module (
    input      [7:0] in,
    output reg [2:0] pos
);
    always @(*) begin
        casez (in)
            8'bzzzzzzz1: pos = 3'd0;
            8'bzzzzzz10: pos = 3'd1;
            8'bzzzzz100: pos = 3'd2;
            8'bzzzz1000: pos = 3'd3;
            8'bzzz10000: pos = 3'd4;
            8'bzz100000: pos = 3'd5;
            8'bz1000000: pos = 3'd6;
            8'b10000000: pos = 3'd7;
            default:     pos = 3'd0;
        endcase
    end
endmodule
