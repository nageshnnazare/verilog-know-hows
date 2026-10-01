//==============================================================================
// HDLBits 107 — 4-bit shift register
// Official problem: https://hdlbits.01xz.net/wiki/Shift4
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 4-bit shift register, shifts toward MSB (q[3] is the last bit out):
//   areset (async) to 0
//   load: parallel load data[3:0]
//   ena: shift in `in` at LSB (q <= {q[2:0], in})
// Load has priority over ena.
//

module top_module (
    input            clk,
    input            areset,
    input            load,
    input            ena,
    input      [3:0] data,
    output reg [3:0] q
);
    always @(posedge clk or posedge areset) begin
        if (areset)
            q <= 4'd0;
        else if (load)
            q <= data;
        else if (ena)
            q <= {1'b0, q[3:1]};
    end
endmodule
