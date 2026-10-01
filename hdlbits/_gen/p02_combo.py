"""HDLBits 044-080: Combinational Logic."""
from emit import add

H = "https://hdlbits.01xz.net/wiki/"
BG = "03_circuits/01_combinational/01_basic_gates"
MX = "03_circuits/01_combinational/02_multiplexers"
AR = "03_circuits/01_combinational/03_arithmetic"
KM = "03_circuits/01_combinational/04_karnaugh_maps"
S_BG = "Circuits — Combinational Logic — Basic Gates"
S_MX = "Circuits — Combinational Logic — Multiplexers"
S_AR = "Circuits — Combinational Logic — Arithmetic Circuits"
S_KM = "Circuits — Combinational Logic — Karnaugh Map to Circuit"

add(
    num=44, section_dir=BG, filename="m2014_q4h", title="Wire",
    url=H + "Exams/m2014_q4h", section_name=S_BG,
    statement="Connect output `out` directly to input `in`.",
    code="""
        module top_module (
            input  in,
            output out
        );
            assign out = in;
        endmodule
    """,
)

add(
    num=45, section_dir=BG, filename="m2014_q4i", title="GND",
    url=H + "Exams/m2014_q4i", section_name=S_BG,
    statement="Drive output `out` to constant 0 (ground).",
    code="""
        module top_module (
            output out
        );
            assign out = 1'b0;
        endmodule
    """,
)

add(
    num=46, section_dir=BG, filename="m2014_q4e", title="NOR",
    url=H + "Exams/m2014_q4e", section_name=S_BG,
    statement="2-input NOR: `out = ~(in1 | in2)`.",
    code="""
        module top_module (
            input  in1,
            input  in2,
            output out
        );
            assign out = ~(in1 | in2);
        endmodule
    """,
)

add(
    num=47, section_dir=BG, filename="m2014_q4f", title="Another gate",
    url=H + "Exams/m2014_q4f", section_name=S_BG,
    statement="AND of `in1` with the inversion of `in2`: `out = in1 & ~in2`.",
    code="""
        module top_module (
            input  in1,
            input  in2,
            output out
        );
            assign out = in1 & ~in2;
        endmodule
    """,
)

add(
    num=48, section_dir=BG, filename="m2014_q4g", title="Two gates",
    url=H + "Exams/m2014_q4g", section_name=S_BG,
    statement="""
        The exam figure is an AND of in2 and in3, then XOR with in1:
          out = in1 ^ (in2 & in3)
    """,
    code="""
        module top_module (
            input  in1,
            input  in2,
            input  in3,
            output out
        );
            assign out = (~(in1 ^ in2)) ^ in3;
        endmodule
    """,
)

add(
    num=49, section_dir=BG, filename="gates", title="More logic gates",
    url=H + "Gates", section_name=S_BG,
    statement="""
        Given `a` and `b`, produce all of:
          out_and, out_or, out_xor, out_nand, out_nor, out_xnor, out_anotb
        where `out_anotb` is a AND NOT b.
    """,
    code="""
        module top_module (
            input  a, b,
            output out_and,
            output out_or,
            output out_xor,
            output out_nand,
            output out_nor,
            output out_xnor,
            output out_anotb
        );
            assign out_and  = a & b;
            assign out_or   = a | b;
            assign out_xor  = a ^ b;
            assign out_nand = ~(a & b);
            assign out_nor  = ~(a | b);
            assign out_xnor = ~(a ^ b);
            assign out_anotb = a & ~b;
        endmodule
    """,
)

add(
    num=50, section_dir=BG, filename="chip7420", title="7420 chip",
    url=H + "7420", section_name=S_BG,
    statement="""
        The 7420 is two independent 4-input NAND gates:
          p1y = NAND(p1a,p1b,p1c,p1d)
          p2y = NAND(p2a,p2b,p2c,p2d)
    """,
    code="""
        module top_module (
            input  p1a, p1b, p1c, p1d,
            output p1y,
            input  p2a, p2b, p2c, p2d,
            output p2y
        );
            assign p1y = ~(p1a & p1b & p1c & p1d);
            assign p2y = ~(p2a & p2b & p2c & p2d);
        endmodule
    """,
)

add(
    num=51, section_dir=BG, filename="truthtable1", title="Truth tables",
    url=H + "Truthtable1", section_name=S_BG,
    statement="""
        Implement the 3-input function f(x3,x2,x1) whose 1-minterms are
        2, 3, 5 and 7 (binary 010, 011, 101, 111).
        Simplified: f = (~x3 & x2) | (x3 & x1)
    """,
    code="""
        module top_module (
            input  x3,
            input  x2,
            input  x1,
            output f
        );
            assign f = (~x3 & x2) | (x3 & x1);
        endmodule
    """,
)

add(
    num=52, section_dir=BG, filename="mt2015_eq2", title="Two-bit equality",
    url=H + "Mt2015_eq2", section_name=S_BG,
    statement="Output `z` is 1 iff 2-bit vectors `a` and `b` are equal.",
    code="""
        module top_module (
            input  [1:0] a,
            input  [1:0] b,
            output       z
        );
            assign z = (a == b);
        endmodule
    """,
)

add(
    num=53, section_dir=BG, filename="mt2015_q4a", title="Simple circuit A",
    url=H + "Mt2015_q4a", section_name=S_BG,
    statement="""
        Circuit A from the exam figure implements
          z = (x ^ y) & x
        which is the same as x & ~y.
    """,
    code="""
        module top_module (
            input  x,
            input  y,
            output z
        );
            assign z = (x ^ y) & x;
        endmodule
    """,
)

add(
    num=54, section_dir=BG, filename="mt2015_q4b", title="Simple circuit B",
    url=H + "Mt2015_q4b", section_name=S_BG,
    statement="Circuit B is an XNOR of x and y: z = ~(x ^ y).",
    code="""
        module top_module (
            input  x,
            input  y,
            output z
        );
            assign z = ~(x ^ y);
        endmodule
    """,
)

add(
    num=55, section_dir=BG, filename="mt2015_q4", title="Combine circuits A and B",
    url=H + "Mt2015_q4", section_name=S_BG,
    statement="""
        Instantiate two copies of circuit A and two of circuit B, all driven
        by (x, y). Combine them as:
          z = (A1 | B1) ^ (A2 & B2)
        Write A and B as submodules in the same file.
    """,
    code="""
        module top_module (
            input  x,
            input  y,
            output z
        );
            wire a1, b1, a2, b2;
            mt2015_q4_a ua1 (.x(x), .y(y), .z(a1));
            mt2015_q4_b ub1 (.x(x), .y(y), .z(b1));
            mt2015_q4_a ua2 (.x(x), .y(y), .z(a2));
            mt2015_q4_b ub2 (.x(x), .y(y), .z(b2));
            assign z = (a1 | b1) ^ (a2 & b2);
        endmodule

        module mt2015_q4_a (
            input  x,
            input  y,
            output z
        );
            assign z = (x ^ y) & x;
        endmodule

        module mt2015_q4_b (
            input  x,
            input  y,
            output z
        );
            assign z = ~(x ^ y);
        endmodule
    """,
)

add(
    num=56, section_dir=BG, filename="ringer", title="Ring or vibrate?",
    url=H + "Ringer", section_name=S_BG,
    statement="""
        Phone ringer/vibrator:
          ringer = ring & ~vibrate_mode
          motor  = ring &  vibrate_mode
        Exactly one of ringer/motor is on when `ring` is 1, selected by mode.
    """,
    code="""
        module top_module (
            input  ring,
            input  vibrate_mode,
            output ringer,
            output motor
        );
            assign ringer = ring & ~vibrate_mode;
            assign motor  = ring &  vibrate_mode;
        endmodule
    """,
)

add(
    num=57, section_dir=BG, filename="thermostat", title="Thermostat",
    url=H + "Thermostat", section_name=S_BG,
    statement="""
        Heating/cooling thermostat:
          mode=1 is heating: heater = too_cold
          mode=0 is cooling: aircon = too_hot
          fan is on if heater or aircon is on, or if fan_on is requested.
    """,
    code="""
        module top_module (
            input  too_cold,
            input  too_hot,
            input  mode,
            input  fan_on,
            output heater,
            output aircon,
            output fan
        );
            assign heater = mode & too_cold;
            assign aircon = ~mode & too_hot;
            assign fan    = heater | aircon | fan_on;
        endmodule
    """,
)

add(
    num=58, section_dir=BG, filename="popcount3", title="3-bit population count",
    url=H + "Popcount3", section_name=S_BG,
    statement="Count the number of 1s in `in[2:0]`. Output is 2 bits (0..3).",
    code="""
        module top_module (
            input  [2:0] in,
            output [1:0] out
        );
            assign out = in[0] + in[1] + in[2];
        endmodule
    """,
)

add(
    num=59, section_dir=BG, filename="gatesv", title="Gates and vectors",
    url=H + "Gatesv", section_name=S_BG,
    statement="""
        For 4-bit `in[3:0]`:
          out_both[2:0]      = in[2:0] & in[3:1]   (each bit AND neighbour)
          out_any[3:1]       = in[3:1] | in[2:0]
          out_different[3:0] = in ^ {in[0], in[3:1]}
        (out_different[3] compares in[3] with in[0], wrapping around.)
    """,
    code="""
        module top_module (
            input  [3:0] in,
            output [2:0] out_both,
            output [3:1] out_any,
            output [3:0] out_different
        );
            assign out_both      = in[2:0] & in[3:1];
            assign out_any       = in[3:1] | in[2:0];
            assign out_different = in ^ {in[0], in[3:1]};
        endmodule
    """,
)

add(
    num=60, section_dir=BG, filename="gatesv100", title="Even longer vectors",
    url=H + "Gatesv100", section_name=S_BG,
    statement="Same neighbour-AND / neighbour-OR / wrap-XOR as Gatesv, but 100 bits.",
    code="""
        module top_module (
            input  [99:0] in,
            output [98:0] out_both,
            output [99:1] out_any,
            output [99:0] out_different
        );
            assign out_both      = in[98:0] & in[99:1];
            assign out_any       = in[99:1] | in[98:0];
            assign out_different = in ^ {in[0], in[99:1]};
        endmodule
    """,
)

# Multiplexers
add(
    num=61, section_dir=MX, filename="mux2to1", title="2-to-1 multiplexer",
    url=H + "Mux2to1", section_name=S_MX,
    statement="1-bit 2:1 mux. `sel=0` chooses `a`, `sel=1` chooses `b`.",
    code="""
        module top_module (
            input  a, b, sel,
            output out
        );
            assign out = sel ? b : a;
        endmodule
    """,
)

add(
    num=62, section_dir=MX, filename="mux2to1v", title="2-to-1 bus multiplexer",
    url=H + "Mux2to1v", section_name=S_MX,
    statement="100-bit 2:1 mux. `sel=0` chooses `a[99:0]`, else `b`.",
    code="""
        module top_module (
            input  [99:0] a, b,
            input         sel,
            output [99:0] out
        );
            assign out = sel ? b : a;
        endmodule
    """,
)

add(
    num=63, section_dir=MX, filename="mux9to1v", title="9-to-1 multiplexer",
    url=H + "Mux9to1v", section_name=S_MX,
    statement="""
        16-bit 9:1 mux. `sel` is 4 bits choosing a[15:0] through i[15:0]
        for sel=0..8. For sel=9..15 output 16'hffff.
    """,
    code="""
        module top_module (
            input  [15:0] a, b, c, d, e, f, g, h, i,
            input  [3:0]  sel,
            output reg [15:0] out
        );
            always @(*) begin
                case (sel)
                    4'd0: out = a;
                    4'd1: out = b;
                    4'd2: out = c;
                    4'd3: out = d;
                    4'd4: out = e;
                    4'd5: out = f;
                    4'd6: out = g;
                    4'd7: out = h;
                    4'd8: out = i;
                    default: out = 16'hffff;
                endcase
            end
        endmodule
    """,
)

add(
    num=64, section_dir=MX, filename="mux256to1", title="256-to-1 multiplexer",
    url=H + "Mux256to1", section_name=S_MX,
    statement="256:1 mux of 1-bit inputs packed in `in[255:0]`, selected by `sel[7:0]`.",
    code="""
        module top_module (
            input  [255:0] in,
            input  [7:0]   sel,
            output         out
        );
            assign out = in[sel];
        endmodule
    """,
)

add(
    num=65, section_dir=MX, filename="mux256to1v", title="256-to-1 4-bit multiplexer",
    url=H + "Mux256to1v", section_name=S_MX,
    statement="""
        256:1 mux of 4-bit words packed in `in[1023:0]`.
        out = in[sel*4+3 : sel*4].
    """,
    code="""
        module top_module (
            input  [1023:0] in,
            input  [7:0]    sel,
            output [3:0]    out
        );
            assign out = in[sel*4 +: 4];
        endmodule
    """,
)

# Arithmetic
add(
    num=66, section_dir=AR, filename="hadd", title="Half adder",
    url=H + "Hadd", section_name=S_AR,
    statement="Half adder: {cout, sum} = a + b.",
    code="""
        module top_module (
            input  a, b,
            output cout, sum
        );
            assign {cout, sum} = a + b;
        endmodule
    """,
)

add(
    num=67, section_dir=AR, filename="fadd", title="Full adder",
    url=H + "Fadd", section_name=S_AR,
    statement="Full adder: {cout, sum} = a + b + cin.",
    code="""
        module top_module (
            input  a, b, cin,
            output cout, sum
        );
            assign {cout, sum} = a + b + cin;
        endmodule
    """,
)

add(
    num=68, section_dir=AR, filename="adder3", title="3-bit binary adder",
    url=H + "Adder3", section_name=S_AR,
    statement="""
        3-bit ripple-carry adder. Inputs a[2:0], b[2:0], cin.
        Outputs cout and sum[2:0]. You may instantiate full adders or add directly.
    """,
    code="""
        module top_module (
            input  [2:0] a, b,
            input        cin,
            output [2:0] cout,
            output [2:0] sum
        );
            full_adder fa0 (.a(a[0]), .b(b[0]), .cin(cin),     .cout(cout[0]), .sum(sum[0]));
            full_adder fa1 (.a(a[1]), .b(b[1]), .cin(cout[0]), .cout(cout[1]), .sum(sum[1]));
            full_adder fa2 (.a(a[2]), .b(b[2]), .cin(cout[1]), .cout(cout[2]), .sum(sum[2]));
        endmodule

        module full_adder (
            input  a, b, cin,
            output cout, sum
        );
            assign {cout, sum} = a + b + cin;
        endmodule
    """,
)

add(
    num=69, section_dir=AR, filename="m2014_q4j", title="Adder",
    url=H + "Exams/m2014_q4j", section_name=S_AR,
    statement="Add two 4-bit numbers x and y. Output is 5-bit `sum` (includes carry out).",
    code="""
        module top_module (
            input  [3:0] x,
            input  [3:0] y,
            output [4:0] sum
        );
            assign sum = x + y;
        endmodule
    """,
)

add(
    num=70, section_dir=AR, filename="ece241_2014_q1c", title="Signed addition overflow",
    url=H + "Exams/ece241_2014_q1c", section_name=S_AR,
    statement="""
        8-bit signed adder: s = a + b. Overflow is 1 when the two operands
        have the same sign and the result has the opposite sign:
          overflow = a[7]&b[7]&~s[7] | ~a[7]&~b[7]&s[7]
    """,
    code="""
        module top_module (
            input  [7:0] a,
            input  [7:0] b,
            output [7:0] s,
            output       overflow
        );
            assign s = a + b;
            assign overflow = (a[7] & b[7] & ~s[7]) | (~a[7] & ~b[7] & s[7]);
        endmodule
    """,
)

add(
    num=71, section_dir=AR, filename="adder100", title="100-bit binary adder",
    url=H + "Adder100", section_name=S_AR,
    statement="100-bit adder: {cout, sum} = a + b + cin.",
    code="""
        module top_module (
            input  [99:0] a, b,
            input         cin,
            output        cout,
            output [99:0] sum
        );
            assign {cout, sum} = a + b + cin;
        endmodule
    """,
)

add(
    num=72, section_dir=AR, filename="bcdadd4", title="4-digit BCD adder",
    url=H + "Bcdadd4", section_name=S_AR,
    statement="""
        4-digit BCD adder from four `bcd_fadd` instances (HDLBits provides
        that module). a and b are 16-bit BCD (4 digits). Produce 16-bit sum
        and a carry-out.
    """,
    code="""
        module top_module (
            input  [15:0] a, b,
            input         cin,
            output        cout,
            output [15:0] sum
        );
            wire [3:0] c;
            bcd_fadd d0 (.a(a[3:0]),   .b(b[3:0]),   .cin(cin),  .cout(c[0]), .sum(sum[3:0]));
            bcd_fadd d1 (.a(a[7:4]),   .b(b[7:4]),   .cin(c[0]), .cout(c[1]), .sum(sum[7:4]));
            bcd_fadd d2 (.a(a[11:8]),  .b(b[11:8]),  .cin(c[1]), .cout(c[2]), .sum(sum[11:8]));
            bcd_fadd d3 (.a(a[15:12]), .b(b[15:12]), .cin(c[2]), .cout(c[3]), .sum(sum[15:12]));
            assign cout = c[3];
        endmodule
    """,
    notes="HDLBits provides `bcd_fadd`. Local helper: `helpers/bcd_fadd.v`.",
)

# Karnaugh maps
add(
    num=73, section_dir=KM, filename="kmap1", title="3-variable",
    url=H + "Kmap1", section_name=S_KM,
    statement="""
        Implement the 3-variable K-map (a across the top, bc down the side):

                  a=0   a=1
            bc=00  0     1
            bc=01  1     1
            bc=11  1     1
            bc=10  1     1

        Only minterm 000 is 0, so out = a | b | c.
    """,
    code="""
        module top_module (
            input  a, b, c,
            output out
        );
            assign out = a | b | c;
        endmodule
    """,
)

add(
    num=74, section_dir=KM, filename="kmap2", title="4-variable",
    url=H + "Kmap2", section_name=S_KM,
    statement="""
        4-variable K-map (ab rows, cd columns):

                   cd=00  01  11  10
            ab=00    0     1   1   1
            ab=01    0     0   0   0
            ab=11    1     1   1   1
            ab=10    1     1   0   1

        One SOP covering:
          out = (~a & ~b & (c | d)) | (a & b) | (a & ~b & ~(c & d))
    """,
    code="""
        module top_module (
            input  a, b, c, d,
            output out
        );
            assign out = (~a & ~b & (c | d))
                       | (a & b)
                       | (a & ~b & ~(c & d));
        endmodule
    """,
)

add(
    num=75, section_dir=KM, filename="kmap3", title="4-variable (don't-cares)",
    url=H + "Kmap3", section_name=S_KM,
    statement="""
        4-variable K-map with don't-cares. One covering that matches the
        official map (don't-cares taken as 1 only where they help, never
        covering a required 0) is:

          out = a ? (c | d) : (~b & c)

        Compare the K-map image on HDLBits if you regroup.
    """,
    code="""
        module top_module (
            input  a, b, c, d,
            output out
        );
            assign out = a ? (c | d) : (~b & c);
        endmodule
    """,
)

add(
    num=76, section_dir=KM, filename="kmap4", title="4-variable (XOR of all)",
    url=H + "Kmap4", section_name=S_KM,
    statement="""
        The K-map is a checkerboard: flipping any one input always inverts
        the output. That function is XOR of all four variables
        (odd parity): out = a ^ b ^ c ^ d.
    """,
    code="""
        module top_module (
            input  a, b, c, d,
            output out
        );
            assign out = a ^ b ^ c ^ d;
        endmodule
    """,
)

add(
    num=77, section_dir=KM, filename="ece241_2013_q2", title="Minimum SOP and POS",
    url=H + "Exams/ece241_2013_q2", section_name=S_KM,
    statement="""
        A 4-input function is 1 for minterms 2, 7, 15; 0 for
        0,1,4,5,6,9,10,13,14; don't-care for the rest (3,8,11,12).

        Minimum SOP (cover 2,7,15 using don't-cares):
          out_sop = (c & d) | (~a & ~b & c)
        Minimum POS:
          out_pos = c & (~a | ~b | d) & (~b | ~c | d)   (one accepted form)
        Equivalently implement POS from the 0-maxterms.
    """,
    code="""
        module top_module (
            input  a, b, c, d,
            output out_sop,
            output out_pos
        );
            assign out_sop = (c & d) | (~a & ~b & c);
            assign out_pos = c & (~b | d) & (~a | b | d);
        endmodule
    """,
)

add(
    num=78, section_dir=KM, filename="m2014_q3", title="Karnaugh map",
    url=H + "Exams/m2014_q3", section_name=S_KM,
    statement="""
        Implement f(x[4:1]) from the exam K-map. A standard simplified form is:
          f = (~x[1] & x[3]) | (x[2] & x[3] & x[4]) | (~x[2] & ~x[4])
        Check the official figure if you want to regroup; any equivalent
        Boolean function is accepted.
    """,
    code="""
        module top_module (
            input  [4:1] x,
            output       f
        );
            assign f = (~x[1] & x[3])
                     | (x[2] & x[3] & x[4])
                     | (~x[2] & ~x[4]);
        endmodule
    """,
)

add(
    num=79, section_dir=KM, filename="2012_q1g", title="Karnaugh map",
    url=H + "Exams/2012_q1g", section_name=S_KM,
    statement="""
        Another exam K-map on x[4:1]. A common simplified SOP:
          f = (~x[2] & ~x[4]) | (~x[1] & x[3]) | (x[2] & x[3] & x[4])
        This is similar to m2014_q3 with a different covering of the 1s.
    """,
    code="""
        module top_module (
            input  [4:1] x,
            output       f
        );
            assign f = (~x[2] & ~x[4])
                     | (~x[1] & x[3])
                     | (x[2] & x[3] & x[4]);
        endmodule
    """,
)

add(
    num=80, section_dir=KM, filename="ece241_2014_q3", title="K-map implemented with a multiplexer",
    url=H + "Exams/ece241_2014_q3", section_name=S_KM,
    statement="""
        Implement the K-map using a 4:1 mux whose select is {a,b} (given
        as part of the top-level on HDLBits — you only drive mux_in[3:0],
        the four data inputs of the mux, as functions of c and d).

        One accepted programming of the mux data inputs:
          mux_in[0] = c | d      // ab=00
          mux_in[1] = 1'b0       // ab=01
          mux_in[2] = ~d         // ab=11
          mux_in[3] = c & d      // ab=10
        (Gray-code order of ab: 00, 01, 11, 10 corresponding to mux_in 0,1,2,3
        on some figures — HDLBits numbers mux_in[0] for ab=00, [1] for 01,
        [2] for 11, [3] for 10.)
    """,
    code="""
        module top_module (
            input        c,
            input        d,
            output [3:0] mux_in
        );
            assign mux_in[0] = c | d;
            assign mux_in[1] = 1'b0;
            assign mux_in[2] = ~d;
            assign mux_in[3] = c & d;
        endmodule
    """,
)
