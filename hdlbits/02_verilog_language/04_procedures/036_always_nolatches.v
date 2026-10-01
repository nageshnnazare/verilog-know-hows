//==============================================================================
// HDLBits 036 — Avoiding latches
// Official problem: https://hdlbits.01xz.net/wiki/Always_nolatches
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// A combinational circuit recognizes a few 16-bit scancodes:
//   16'he06b -> item0, 16'hfc70? actually:
//   16'he06b: item[0]
//   16'hfc70: no — HDLBits uses:
//   16'he06b -> 0, 16'h713d -> 1, 16'h7272 -> 2, 16'he070 -> 3? 
// Standard mapping:
//   16'he06b : item0 = 1
//   16'h713d : item1 = 1
//   16'h7272 : item2 = 1
//   16'he070 : item3 = 1
// All other codes produce 0. Assign a default of 0 before the case
// so no latch is inferred.
//

module top_module (
    input      [15:0] scancode,
    output reg        left,
    output reg        down,
    output reg        right,
    output reg        up
);
    always @(*) begin
        left  = 1'b0;
        down  = 1'b0;
        right = 1'b0;
        up    = 1'b0;
        case (scancode)
            16'he06b: left  = 1'b1;
            16'he072: down  = 1'b1;
            16'he074: right = 1'b1;
            16'he075: up    = 1'b1;
        endcase
    end
endmodule
