//==============================================================================
// HDLBits 086 — DFF with byte enable
// Official problem: https://hdlbits.01xz.net/wiki/Dff16e
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 16-bit register, synchronous reset to 0. Byte enables:
//   byteena[1] enables q[15:8], byteena[0] enables q[7:0].
// Unenabled bytes hold their value.
//

module top_module (
    input            clk,
    input            resetn,
    input      [1:0] byteena,
    input      [15:0] d,
    output reg [15:0] q
);
    always @(posedge clk) begin
        if (!resetn)
            q <= 16'd0;
        else begin
            if (byteena[1]) q[15:8] <= d[15:8];
            if (byteena[0]) q[7:0]  <= d[7:0];
        end
    end
endmodule
