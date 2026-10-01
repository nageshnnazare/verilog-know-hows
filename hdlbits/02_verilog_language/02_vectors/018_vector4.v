//==============================================================================
// HDLBits 018 — Replication operator
// Official problem: https://hdlbits.01xz.net/wiki/Vector4
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Sign-extend an 8-bit number to 32 bits using the replication
// operator: `{ {24{in[7]}}, in }`.
//

module top_module (
    input  [7:0]  in,
    output [31:0] out
);
    assign out = {{24{in[7]}}, in};
endmodule
