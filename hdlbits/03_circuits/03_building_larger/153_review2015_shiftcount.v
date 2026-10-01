//==============================================================================
// HDLBits 153 — 4-bit shift register and down counter
// Official problem: https://hdlbits.01xz.net/wiki/Exams/review2015_shiftcount
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Combined 4-bit shift register / down counter.
//   shift_ena=1: shift in `data` at MSB (q <= {data, q[3:1]})
//   count_ena=1: decrement q
// If both, shift takes precedence. No reset.
//

module top_module (
    input            clk,
    input            shift_ena,
    input            count_ena,
    input            data,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (shift_ena)
            q <= {q[2:0], data};
        else if (count_ena)
            q <= q - 4'd1;
    end
endmodule
