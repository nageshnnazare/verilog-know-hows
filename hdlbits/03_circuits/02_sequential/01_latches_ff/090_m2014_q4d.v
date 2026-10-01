//==============================================================================
// HDLBits 090 — DFF+gate
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q4d
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// XOR the input with the current output and register that on posedge
// clk (a toggle-when-in-is-1 / XOR-feedback DFF):
//   q <= q ^ in
// Output is q. Reset is not present on this figure.
//

module top_module (
    input      clk,
    input      in,
    output reg out
);
    always @(posedge clk)
        out <= out ^ in;
endmodule
