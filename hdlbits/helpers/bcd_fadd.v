// 4-bit BCD full adder (sums 0..9 plus carry).
module bcd_fadd (
    input  [3:0] a,
    input  [3:0] b,
    input        cin,
    output       cout,
    output [3:0] sum
);
    wire [4:0] raw = a + b + cin;
    assign {cout, sum} = (raw > 5'd9) ? (raw + 5'd6) : raw;
endmodule
