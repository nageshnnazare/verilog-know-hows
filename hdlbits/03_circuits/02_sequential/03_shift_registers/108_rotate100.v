//==============================================================================
// HDLBits 108 — Left/right rotator
// Official problem: https://hdlbits.01xz.net/wiki/Rotate100
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 100-bit rotator. `load` parallel-loads `data`. Otherwise `ena`:
//   2'b01: rotate right by 1
//   2'b10: rotate left by 1
//   other: hold
//

module top_module (
    input             clk,
    input             load,
    input      [1:0]  ena,
    input      [99:0] data,
    output reg [99:0] q
);
    always @(posedge clk) begin
        if (load)
            q <= data;
        else begin
            case (ena)
                2'b01: q <= {q[0], q[99:1]};
                2'b10: q <= {q[98:0], q[99]};
                default: q <= q;
            endcase
        end
    end
endmodule
