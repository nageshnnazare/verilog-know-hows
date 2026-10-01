//==============================================================================
// HDLBits 016 — Vector concatenation operator
// Official problem: https://hdlbits.01xz.net/wiki/Vector3
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Concatenate six 5-bit inputs `{a,b,c,d,e,f}` (30 bits) into four
// 8-bit outputs `{w,x,y,z}` (32 bits). The extra two bits are `2'b11`
// appended on the LSB side:
//   {w, x, y, z} = {a, b, c, d, e, f, 2'b11}
//

module top_module (
    input  [4:0] a, b, c, d, e, f,
    output [7:0] w, x, y, z
);
    assign {w, x, y, z} = {a, b, c, d, e, f, 2'b11};
endmodule
