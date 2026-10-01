//==============================================================================
// HDLBits 115 — 3-input LUT
// Official problem: https://hdlbits.01xz.net/wiki/Exams/ece241_2013_q12
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 8-bit shift register (shifts in S when enable=1) feeding an 8-to-1
// mux addressed by {A,B,C}. Output Z is the selected bit of the register.
// Q[0] is the oldest bit (first shifted in appears at Q[0] after 1 cycle
// — actually S enters Q[0], then moves toward Q[7]).
// Z = Q[{A,B,C}].
//

module top_module (
    input      clk,
    input      enable,
    input      S,
    input      A, B, C,
    output     Z
);
    reg [7:0] Q;
    always @(posedge clk) begin
        if (enable)
            Q <= {Q[6:0], S};
    end
    assign Z = Q[{A, B, C}];
endmodule
