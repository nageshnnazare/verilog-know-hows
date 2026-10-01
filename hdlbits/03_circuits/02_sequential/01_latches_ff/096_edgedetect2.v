//==============================================================================
// HDLBits 096 — Detect both edges
// Official problem: https://hdlbits.01xz.net/wiki/Edgedetect2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Pulse `anyedge` for one cycle on any 0->1 or 1->0 transition (8 bits).
//

module top_module (
    input            clk,
    input      [7:0] in,
    output reg [7:0] anyedge
);
    reg [7:0] in_d;
    always @(posedge clk) begin
        in_d    <= in;
        anyedge <= in ^ in_d;
    end
endmodule
