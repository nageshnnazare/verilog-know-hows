//==============================================================================
// HDLBits 094 — Create circuit from truth table
// Official problem: https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q7
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Implement a JK flip-flop from a DFF using the characteristic table:
//   J K | Q+
//   0 0 | Q
//   0 1 | 0
//   1 0 | 1
//   1 1 | ~Q
//

module top_module (
    input      clk,
    input      j,
    input      k,
    output reg Q
);
    always @(posedge clk) begin
        case ({j, k})
            2'b00: Q <= Q;
            2'b01: Q <= 1'b0;
            2'b10: Q <= 1'b1;
            2'b11: Q <= ~Q;
        endcase
    end
endmodule
