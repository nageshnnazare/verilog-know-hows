//==============================================================================
// HDLBits 043 — Generate for-loop: 100-digit BCD adder
// Official problem: https://hdlbits.01xz.net/wiki/Bcdadd100
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// You are given `bcd_fadd` (4-bit BCD full adder: a[3:0], b[3:0], cin
// -> cout, sum[3:0]). Instantiate 100 of them with a generate loop to
// add two 100-digit BCD numbers `a[399:0]` and `b[399:0]`.
//

module top_module (
    input  [399:0] a, b,
    input          cin,
    output         cout,
    output [399:0] sum
);
    wire [99:0] carry;
    genvar i;
    generate
        for (i = 0; i < 100; i = i + 1) begin : bcd
            if (i == 0) begin
                bcd_fadd u (
                    .a(a[3:0]),
                    .b(b[3:0]),
                    .cin(cin),
                    .cout(carry[0]),
                    .sum(sum[3:0])
                );
            end else begin
                bcd_fadd u (
                    .a(a[i*4+3:i*4]),
                    .b(b[i*4+3:i*4]),
                    .cin(carry[i-1]),
                    .cout(carry[i]),
                    .sum(sum[i*4+3:i*4])
                );
            end
        end
    endgenerate
    assign cout = carry[99];
endmodule
