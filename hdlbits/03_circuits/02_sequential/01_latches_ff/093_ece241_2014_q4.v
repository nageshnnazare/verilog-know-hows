//==============================================================================
// HDLBits 093 — DFFs and gates
// Official problem: https://hdlbits.01xz.net/wiki/Exams/ece241_2014_q4
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Three DFFs with combinational feedback from input x:
//   q0 <= q0 ^ x
//   q1 <= ~q1 & x
//   q2 <= ~q2 | x
// Output z is NOR of the three Qs: z = ~(q0 | q1 | q2)
// No explicit reset; they start at X in simulation unless you care.
// HDLBits typically does not reset them (or they come up 0 in the tester).
//

module top_module (
    input      clk,
    input      x,
    output     z
);
    reg q0, q1, q2;
    always @(posedge clk) begin
        q0 <= q0 ^ x;
        q1 <= ~q1 & x;
        q2 <= ~q2 | x;
    end
    assign z = ~(q0 | q1 | q2);
endmodule
