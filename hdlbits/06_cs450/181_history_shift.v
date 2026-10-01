//==============================================================================
// HDLBits 181 — History shift
// Official problem: https://hdlbits.01xz.net/wiki/Cs450/history_shift
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 32-bit speculative global branch-history register.
//   predict_valid: shift `predict_taken` in at the LSB.
//   train_mispredicted: load {train_history[30:0], train_taken}
//     (history before the branch concatenated with the real outcome).
// Mispredict takes precedence over predict. `areset` to 0.
// `predict_history` is the register value.
//

module top_module (
    input             clk,
    input             areset,
    input             predict_valid,
    input             predict_taken,
    output     [31:0] predict_history,
    input             train_mispredicted,
    input             train_taken,
    input      [31:0] train_history
);
    reg [31:0] hist;
    always @(posedge clk or posedge areset) begin
        if (areset)
            hist <= 32'd0;
        else if (train_mispredicted)
            hist <= {train_history[30:0], train_taken};
        else if (predict_valid)
            hist <= {hist[30:0], predict_taken};
    end
    assign predict_history = hist;
endmodule
