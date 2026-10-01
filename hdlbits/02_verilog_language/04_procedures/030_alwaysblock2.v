//==============================================================================
// HDLBits 030 — Always blocks (clocked)
// Official problem: https://hdlbits.01xz.net/wiki/Alwaysblock2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build an XOR three ways:
//   out_assign       — continuous assignment (combinational)
//   out_alwayscomb   — combinational always block (blocking `=`)
//   out_alwaysff     — clocked always block, XOR registered on
//                      posedge clk (non-blocking `<=`)
//

module top_module (
    input      clk,
    input      a,
    input      b,
    output     out_assign,
    output reg out_always_comb,
    output reg out_always_ff
);
    assign out_assign = a ^ b;
    always @(*) begin
        out_always_comb = a ^ b;
    end
    always @(posedge clk) begin
        out_always_ff <= a ^ b;
    end
endmodule
