//==============================================================================
// HDLBits 095 — Detect an edge
// Official problem: https://hdlbits.01xz.net/wiki/Edgedetect
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// For each bit of a 8-bit vector, pulse `pedge` for one cycle when that
// bit has a 0->1 transition.
//

module top_module (
    input            clk,
    input      [7:0] in,
    output reg [7:0] pedge
);
    reg [7:0] in_d;
    always @(posedge clk) begin
        in_d  <= in;
        pedge <= in & ~in_d;
    end
endmodule
