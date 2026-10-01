//==============================================================================
// HDLBits 170 — Sequential circuit 7
// Official problem: https://hdlbits.01xz.net/wiki/Sim/circuit7
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Sequential. q is a register that loads 0 when `a` is 1, and 1 when
// `a` is 0, on the clock edge (i.e. q <= ~a). From the waveform q
// follows ~a delayed one cycle.
//

module top_module (
    input      clk,
    input      a,
    output reg q
);
    always @(posedge clk)
        q <= ~a;
endmodule
