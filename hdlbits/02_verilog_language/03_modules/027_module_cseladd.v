//==============================================================================
// HDLBits 027 — Carry-select adder
// Official problem: https://hdlbits.01xz.net/wiki/Module_cseladd
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Build a 32-bit carry-select adder from three `add16` instances:
//   - add the lower 16 bits (cin=0) to get sum[15:0] and a carry
//   - add the upper 16 bits twice, once with cin=0 and once with cin=1
//   - mux the two upper sums using the lower carry
//

module top_module (
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] sum
);
    wire        cout_lo;
    wire [15:0] sum_cin0, sum_cin1;
    add16 lo (
        .a(a[15:0]), .b(b[15:0]), .cin(1'b0),
        .sum(sum[15:0]), .cout(cout_lo)
    );
    add16 hi0 (
        .a(a[31:16]), .b(b[31:16]), .cin(1'b0),
        .sum(sum_cin0), .cout()
    );
    add16 hi1 (
        .a(a[31:16]), .b(b[31:16]), .cin(1'b1),
        .sum(sum_cin1), .cout()
    );
    assign sum[31:16] = cout_lo ? sum_cin1 : sum_cin0;
endmodule
