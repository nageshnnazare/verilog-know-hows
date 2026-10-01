//==============================================================================
// HDLBits 063 — 9-to-1 multiplexer
// Official problem: https://hdlbits.01xz.net/wiki/Mux9to1v
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 16-bit 9:1 mux. `sel` is 4 bits choosing a[15:0] through i[15:0]
// for sel=0..8. For sel=9..15 output 16'hffff.
//

module top_module (
    input  [15:0] a, b, c, d, e, f, g, h, i,
    input  [3:0]  sel,
    output reg [15:0] out
);
    always @(*) begin
        case (sel)
            4'd0: out = a;
            4'd1: out = b;
            4'd2: out = c;
            4'd3: out = d;
            4'd4: out = e;
            4'd5: out = f;
            4'd6: out = g;
            4'd7: out = h;
            4'd8: out = i;
            default: out = 16'hffff;
        endcase
    end
endmodule
