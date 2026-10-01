//==============================================================================
// HDLBits 171 — Sequential circuit 8
// Official problem: https://hdlbits.01xz.net/wiki/Sim/circuit8
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Sequential with clock named `clock`. p is a latch of `a` while clock
// is high (transparent when clock=1). q is a negative-edge register
// of p (or of a). Standard:
//   always @(*) if (clock) p = a;
//   always @(negedge clock) q <= p;
//

module top_module (
    input      clock,
    input      a,
    output reg p,
    output reg q
);
    always @(*) begin
        if (clock)
            p = a;
    end
    always @(negedge clock)
        q <= p;
endmodule
