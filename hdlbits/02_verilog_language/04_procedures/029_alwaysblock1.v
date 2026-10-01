//==============================================================================
// HDLBits 029 — Always blocks (combinational)
// Official problem: https://hdlbits.01xz.net/wiki/Alwaysblock1
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build a 2-input AND gate twice: once with a continuous assignment
// (`out_assign`) and once with a combinational `always` block
// (`out_alwaysblock`). Both must compute a AND b.
//

module top_module (
    input  a,
    input  b,
    output     out_assign,
    output reg out_alwaysblock
);
    assign out_assign = a & b;
    always @(*) begin
        out_alwaysblock = a & b;
    end
endmodule
