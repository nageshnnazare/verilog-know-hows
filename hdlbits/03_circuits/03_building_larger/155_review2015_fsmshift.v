//==============================================================================
// HDLBits 155 — FSM: Enable shift register
// Official problem: https://hdlbits.01xz.net/wiki/Exams/review2015_fsmshift
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Assert `shift_ena` for exactly 4 clock cycles after reset, then 0
// forever (until the next reset).
//

module top_module (
    input      clk,
    input      reset,
    output     shift_ena
);
    reg [2:0] cnt;
    always @(posedge clk) begin
        if (reset)
            cnt <= 3'd0;
        else if (cnt < 3'd4)
            cnt <= cnt + 3'd1;
    end
    assign shift_ena = (cnt < 3'd4);
endmodule
