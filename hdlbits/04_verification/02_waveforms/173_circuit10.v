//==============================================================================
// HDLBits 173 — Sequential circuit 10
// Official problem: https://hdlbits.01xz.net/wiki/Sim/circuit10
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Sequential circuit with inputs a,b and outputs q, state. From the
// waveform: `state` updates to `a` when a==b (otherwise holds), and
// q equals a when a==b else ~state. Confirm against the official plot.
//

module top_module (
    input      clk,
    input      a,
    input      b,
    output     q,
    output reg state
);
    always @(posedge clk) begin
        if (a == b)
            state <= a;
    end
    assign q = (a == b) ? a : ~state;
endmodule
