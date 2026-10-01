//==============================================================================
// HDLBits 113 — Shift register
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q4k
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 4-bit shift register, active-low synchronous reset. Shift in `in` at
// the LSB; `out` is the MSB. resetn=0 clears to 0.
//

module top_module (
    input      clk,
    input      resetn,
    input      in,
    output     out
);
    reg [3:0] q;
    always @(posedge clk) begin
        if (!resetn)
            q <= 4'd0;
        else
            q <= {q[2:0], in};
    end
    assign out = q[3];
endmodule
