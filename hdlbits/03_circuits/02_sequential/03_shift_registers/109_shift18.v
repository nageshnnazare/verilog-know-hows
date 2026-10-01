//==============================================================================
// HDLBits 109 — Left/right arithmetic shift by 1 or 8
// Official problem: https://hdlbits.01xz.net/wiki/Shift18
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 64-bit arithmetic shifter. `load` loads `data`. When `ena`:
//   amount=00: shift left 1
//   amount=01: shift left 8
//   amount=10: arithmetic shift right 1
//   amount=11: arithmetic shift right 8
//

module top_module (
    input             clk,
    input             load,
    input             ena,
    input      [1:0]  amount,
    input      [63:0] data,
    output reg [63:0] q
);
    always @(posedge clk) begin
        if (load)
            q <= data;
        else if (ena) begin
            case (amount)
                2'b00: q <= q << 1;
                2'b01: q <= q << 8;
                2'b10: q <= {q[63], q[63:1]};
                2'b11: q <= {{8{q[63]}}, q[63:8]};
            endcase
        end
    end
endmodule
