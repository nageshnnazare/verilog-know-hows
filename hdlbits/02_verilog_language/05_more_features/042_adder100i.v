//==============================================================================
// HDLBits 042 — Generate for-loop: 100-bit binary adder 2
// Official problem: https://hdlbits.01xz.net/wiki/Adder100i
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build a 100-bit ripple-carry adder from 100 full adders using a
// generate for-loop. Also expose the internal carry chain as
// `cout[99:0]` (cout[i] is the carry out of bit i).
//

module top_module (
    input  [99:0] a, b,
    input         cin,
    output [99:0] cout,
    output [99:0] sum
);
    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin : fa
            if (i == 0)
                assign {cout[0], sum[0]} = a[0] + b[0] + cin;
            else
                assign {cout[i], sum[i]} = a[i] + b[i] + cout[i-1];
        end
    endgenerate
endmodule
