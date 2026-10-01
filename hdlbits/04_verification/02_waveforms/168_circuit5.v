//==============================================================================
// HDLBits 168 — Combinational circuit 5
// Official problem: https://hdlbits.01xz.net/wiki/Sim/circuit5
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Five 4-bit inputs a,b,c,d,e and 4-bit q. From the official waveform,
// `c` selects among the other buses (0->b, 1->e, 2->a, 3->d) and q is
// 4'hf for any other select value. Compare the figure on HDLBits.
//

module top_module (
    input  [3:0] a, b, c, d, e,
    output [3:0] q
);
    assign q = (c == 4'd0) ? b :
               (c == 4'd1) ? e :
               (c == 4'd2) ? a :
               (c == 4'd3) ? d :
               4'hf;
endmodule
