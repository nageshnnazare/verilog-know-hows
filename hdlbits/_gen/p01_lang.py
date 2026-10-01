"""HDLBits 001-043: Getting Started + Verilog Language."""
from emit import add

H = "https://hdlbits.01xz.net/wiki/"

# ---------------------------------------------------------------------------
# Getting Started
# ---------------------------------------------------------------------------
add(
    num=1,
    section_dir="01_getting_started",
    filename="step_one",
    title="Getting Started (Step one)",
    url=H + "Step_one",
    section_name="Getting Started",
    statement="""
        Build a circuit with no inputs and one output named `one`.
        The output must always drive logic 1 (high).
    """,
    code="""
        module top_module (
            output one
        );
            assign one = 1'b1;
        endmodule
    """,
)

add(
    num=2,
    section_dir="01_getting_started",
    filename="zero",
    title="Output Zero",
    url=H + "Zero",
    section_name="Getting Started",
    statement="""
        Build a circuit with no inputs and one output named `zero`.
        The output must always drive logic 0 (low).
    """,
    code="""
        module top_module (
            output zero
        );
            assign zero = 1'b0;
        endmodule
    """,
)

# ---------------------------------------------------------------------------
# Verilog Language / Basics
# ---------------------------------------------------------------------------
add(
    num=3,
    section_dir="02_verilog_language/01_basics",
    filename="wire",
    title="Simple wire",
    url=H + "Wire",
    section_name="Verilog Language — Basics",
    statement="""
        Create a module with one input `in` and one output `out`.
        Connect `out` directly to `in` (a wire).
    """,
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
    num=4,
    section_dir="02_verilog_language/01_basics",
    filename="wire4",
    title="Four wires",
    url=H + "Wire4",
    section_name="Verilog Language — Basics",
    statement="""
        Create a module with three inputs `a`, `b`, `c` and four outputs
        `w`, `x`, `y`, `z`. Connect them as follows:
          w = a,  x = b,  y = b,  z = c
        (`b` fans out to both `x` and `y`).
    """,
    code="""
        module top_module (
            input  a, b, c,
            output w, x, y, z
        );
            assign w = a;
            assign x = b;
            assign y = b;
            assign z = c;
        endmodule
    """,
)

add(
    num=5,
    section_dir="02_verilog_language/01_basics",
    filename="notgate",
    title="Inverter",
    url=H + "Notgate",
    section_name="Verilog Language — Basics",
    statement="""
        Build a NOT gate: `out` is the inversion of `in`.
    """,
    code="""
        module top_module (
            input  in,
            output out
        );
            assign out = ~in;
        endmodule
    """,
)

add(
    num=6,
    section_dir="02_verilog_language/01_basics",
    filename="andgate",
    title="AND gate",
    url=H + "Andgate",
    section_name="Verilog Language — Basics",
    statement="""
        Build a 2-input AND gate: `out = a AND b`.
    """,
    code="""
        module top_module (
            input  a,
            input  b,
            output out
        );
            assign out = a & b;
        endmodule
    """,
)

add(
    num=7,
    section_dir="02_verilog_language/01_basics",
    filename="norgate",
    title="NOR gate",
    url=H + "Norgate",
    section_name="Verilog Language — Basics",
    statement="""
        Build a 2-input NOR gate: `out = NOT (a OR b)`.
    """,
    code="""
        module top_module (
            input  a,
            input  b,
            output out
        );
            assign out = ~(a | b);
        endmodule
    """,
)

add(
    num=8,
    section_dir="02_verilog_language/01_basics",
    filename="xnorgate",
    title="XNOR gate",
    url=H + "Xnorgate",
    section_name="Verilog Language — Basics",
    statement="""
        Build a 2-input XNOR (equality) gate: `out` is 1 when `a` and `b`
        are the same.
    """,
    code="""
        module top_module (
            input  a,
            input  b,
            output out
        );
            assign out = ~(a ^ b);
        endmodule
    """,
)

add(
    num=9,
    section_dir="02_verilog_language/01_basics",
    filename="wire_decl",
    title="Declaring wires",
    url=H + "Wire_decl",
    section_name="Verilog Language — Basics",
    statement="""
        Implement the circuit that computes:
          out   = (a | b) & (c | d)
          out_n = ~out
        Declare an internal wire for the AND result rather than repeating
        the expression.
    """,
    code="""
        module top_module (
            input  a,
            input  b,
            input  c,
            input  d,
            output out,
            output out_n
        );
            wire and_out;
            assign and_out = (a | b) & (c | d);
            assign out     = and_out;
            assign out_n   = ~and_out;
        endmodule
    """,
)

add(
    num=10,
    section_dir="02_verilog_language/01_basics",
    filename="chip7458",
    title="7458 chip",
    url=H + "7458",
    section_name="Verilog Language — Basics",
    statement="""
        Implement the 7458 dual AND-OR chip:
          p1y = (p1a & p1b & p1c) | (p1d & p1e & p1f)
          p2y = (p2a & p2b) | (p2c & p2d)
        You may introduce internal wires for the AND terms.
    """,
    code="""
        module top_module (
            input  p1a, p1b, p1c, p1d, p1e, p1f,
            output p1y,
            input  p2a, p2b, p2c, p2d,
            output p2y
        );
            wire and1a, and1b, and2a, and2b;
            assign and1a = p1a & p1b & p1c;
            assign and1b = p1d & p1e & p1f;
            assign and2a = p2a & p2b;
            assign and2b = p2c & p2d;
            assign p1y = and1a | and1b;
            assign p2y = and2a | and2b;
        endmodule
    """,
)

# ---------------------------------------------------------------------------
# Vectors
# ---------------------------------------------------------------------------
add(
    num=11,
    section_dir="02_verilog_language/02_vectors",
    filename="vector0",
    title="Vectors",
    url=H + "Vector0",
    section_name="Verilog Language — Vectors",
    statement="""
        Input `vec[2:0]` is a 3-bit vector. Drive `outv` with the same
        vector, and also split it onto scalar outputs `o2`, `o1`, `o0`
        (o2 is the MSB).
    """,
    code="""
        module top_module (
            input  wire [2:0] vec,
            output wire [2:0] outv,
            output wire       o2,
            output wire       o1,
            output wire       o0
        );
            assign outv = vec;
            assign o2   = vec[2];
            assign o1   = vec[1];
            assign o0   = vec[0];
        endmodule
    """,
)

add(
    num=12,
    section_dir="02_verilog_language/02_vectors",
    filename="vector1",
    title="Vectors in more detail",
    url=H + "Vector1",
    section_name="Verilog Language — Vectors",
    statement="""
        Split a 16-bit input into a high byte `out_hi` (bits [15:8]) and
        a low byte `out_lo` (bits [7:0]).
    """,
    code="""
        module top_module (
            input  wire [15:0] in,
            output wire [7:0]  out_hi,
            output wire [7:0]  out_lo
        );
            assign out_hi = in[15:8];
            assign out_lo = in[7:0];
        endmodule
    """,
)

add(
    num=13,
    section_dir="02_verilog_language/02_vectors",
    filename="vector2",
    title="Vector part select",
    url=H + "Vector2",
    section_name="Verilog Language — Vectors",
    statement="""
        Reverse the four bytes of a 32-bit word:
          out[31:24] = in[7:0]
          out[23:16] = in[15:8]
          out[15:8]  = in[23:16]
          out[7:0]   = in[31:24]
    """,
    code="""
        module top_module (
            input  [31:0] in,
            output [31:0] out
        );
            assign out[31:24] = in[7:0];
            assign out[23:16] = in[15:8];
            assign out[15:8]  = in[23:16];
            assign out[7:0]   = in[31:24];
        endmodule
    """,
)

add(
    num=14,
    section_dir="02_verilog_language/02_vectors",
    filename="vectorgates",
    title="Bitwise operators",
    url=H + "Vectorgates",
    section_name="Verilog Language — Vectors",
    statement="""
        Given 3-bit vectors `a` and `b`:
          out_or_bitwise = a | b          (bitwise OR)
          out_or_logical = a || b         (logical OR, 1-bit)
          out_not        = {~b, ~a}       (concatenation of inversions, 6 bits)
    """,
    code="""
        module top_module (
            input  [2:0] a,
            input  [2:0] b,
            output [2:0] out_or_bitwise,
            output       out_or_logical,
            output [5:0] out_not
        );
            assign out_or_bitwise = a | b;
            assign out_or_logical = a || b;
            assign out_not        = {~b, ~a};
        endmodule
    """,
)

add(
    num=15,
    section_dir="02_verilog_language/02_vectors",
    filename="gates4",
    title="Four-input gates",
    url=H + "Gates4",
    section_name="Verilog Language — Vectors",
    statement="""
        Build 4-input AND, OR, and XOR gates on vector `in[3:0]`.
        Reduction operators (`&in`, `|in`, `^in`) are the natural fit.
    """,
    code="""
        module top_module (
            input  [3:0] in,
            output       out_and,
            output       out_or,
            output       out_xor
        );
            assign out_and = &in;
            assign out_or  = |in;
            assign out_xor = ^in;
        endmodule
    """,
)

add(
    num=16,
    section_dir="02_verilog_language/02_vectors",
    filename="vector3",
    title="Vector concatenation operator",
    url=H + "Vector3",
    section_name="Verilog Language — Vectors",
    statement="""
        Concatenate six 5-bit inputs `{a,b,c,d,e,f}` (30 bits) into four
        8-bit outputs `{w,x,y,z}` (32 bits). The extra two bits are `2'b11`
        appended on the LSB side:
          {w, x, y, z} = {a, b, c, d, e, f, 2'b11}
    """,
    code="""
        module top_module (
            input  [4:0] a, b, c, d, e, f,
            output [7:0] w, x, y, z
        );
            assign {w, x, y, z} = {a, b, c, d, e, f, 2'b11};
        endmodule
    """,
)

add(
    num=17,
    section_dir="02_verilog_language/02_vectors",
    filename="vectorr",
    title="Vector reversal 1",
    url=H + "Vectorr",
    section_name="Verilog Language — Vectors",
    statement="""
        Reverse the bit order of an 8-bit vector:
          out[7] = in[0], out[6] = in[1], ..., out[0] = in[7]
    """,
    code="""
        module top_module (
            input  [7:0] in,
            output [7:0] out
        );
            assign out = {in[0], in[1], in[2], in[3], in[4], in[5], in[6], in[7]};
        endmodule
    """,
)

add(
    num=18,
    section_dir="02_verilog_language/02_vectors",
    filename="vector4",
    title="Replication operator",
    url=H + "Vector4",
    section_name="Verilog Language — Vectors",
    statement="""
        Sign-extend an 8-bit number to 32 bits using the replication
        operator: `{ {24{in[7]}}, in }`.
    """,
    code="""
        module top_module (
            input  [7:0]  in,
            output [31:0] out
        );
            assign out = {{24{in[7]}}, in};
        endmodule
    """,
)

add(
    num=19,
    section_dir="02_verilog_language/02_vectors",
    filename="vector5",
    title="More replication",
    url=H + "Vector5",
    section_name="Verilog Language — Vectors",
    statement="""
        Given five inputs a,b,c,d,e, compute a 25-bit output that is the
        pairwise XNOR of every pair (including a signal with itself).
        One compact form:
          out = ~{ {5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}} }
                ^ { 5{a,b,c,d,e} }
        Each 5-bit group compares one input against {a,b,c,d,e}.
    """,
    code="""
        module top_module (
            input        a, b, c, d, e,
            output [24:0] out
        );
            assign out = ~{{5{a}}, {5{b}}, {5{c}}, {5{d}}, {5{e}}} ^ {5{a, b, c, d, e}};
        endmodule
    """,
)

# ---------------------------------------------------------------------------
# Modules: Hierarchy
# ---------------------------------------------------------------------------
add(
    num=20,
    section_dir="02_verilog_language/03_modules",
    filename="module",
    title="Modules",
    url=H + "Module",
    section_name="Verilog Language — Modules: Hierarchy",
    statement="""
        Instantiate the provided module `mod_a` (ports `in1`, `in2`, `out`)
        once. Connect `in1` to `a`, `in2` to `b`, and `out` to `out`.
        HDLBits supplies `mod_a`; a local helper is in hdlbits/helpers/mod_a.v.
    """,
    code="""
        module top_module (
            input  a,
            input  b,
            output out
        );
            mod_a inst (
                .in1(a),
                .in2(b),
                .out(out)
            );
        endmodule
    """,
    notes="HDLBits provides `mod_a`. For local simulation compile with `helpers/mod_a.v`.",
)

add(
    num=21,
    section_dir="02_verilog_language/03_modules",
    filename="module_pos",
    title="Connecting ports by position",
    url=H + "Module_pos",
    section_name="Verilog Language — Modules: Hierarchy",
    statement="""
        Instantiate `mod_a` whose ports, in declaration order, are
        `out1`, `out2`, `in1`, `in2`, `in3`, `in4`. Connect by position:
          out1->out1, out2->out2, in1->a, in2->b, in3->c, in4->d
    """,
    code="""
        module top_module (
            input  a,
            input  b,
            input  c,
            input  d,
            output out1,
            output out2
        );
            mod_a inst (out1, out2, a, b, c, d);
        endmodule
    """,
    notes="HDLBits provides this `mod_a` (6-port version). Local helper: `helpers/mod_a_6port.v`.",
)

add(
    num=22,
    section_dir="02_verilog_language/03_modules",
    filename="module_name",
    title="Connecting ports by name",
    url=H + "Module_name",
    section_name="Verilog Language — Modules: Hierarchy",
    statement="""
        Same `mod_a` as the previous problem, but connect ports by name:
          .out1(out1), .out2(out2), .in1(a), .in2(b), .in3(c), .in4(d)
    """,
    code="""
        module top_module (
            input  a,
            input  b,
            input  c,
            input  d,
            output out1,
            output out2
        );
            mod_a inst (
                .out1(out1),
                .out2(out2),
                .in1(a),
                .in2(b),
                .in3(c),
                .in4(d)
            );
        endmodule
    """,
    notes="Use `helpers/mod_a_6port.v` for local simulation.",
)

add(
    num=23,
    section_dir="02_verilog_language/03_modules",
    filename="module_shift",
    title="Three modules",
    url=H + "Module_shift",
    section_name="Verilog Language — Modules: Hierarchy",
    statement="""
        You are given `my_dff` (a positive-edge D flip-flop: clk, d, q).
        Instantiate three of them in a chain to make a 3-cycle delay:
          d -> dff1 -> dff2 -> dff3 -> q
    """,
    code="""
        module top_module (
            input  clk,
            input  d,
            output q
        );
            wire q1, q2;
            my_dff d1 (.clk(clk), .d(d),  .q(q1));
            my_dff d2 (.clk(clk), .d(q1), .q(q2));
            my_dff d3 (.clk(clk), .d(q2), .q(q));
        endmodule
    """,
    notes="HDLBits provides `my_dff`. Local helper: `helpers/my_dff.v`.",
)

add(
    num=24,
    section_dir="02_verilog_language/03_modules",
    filename="module_shift8",
    title="Modules and vectors",
    url=H + "Module_shift8",
    section_name="Verilog Language — Modules: Hierarchy",
    statement="""
        You are given `my_dff8` (8-bit DFF). Build a 4-deep pipeline of
        8-bit registers. Input `sel[1:0]` muxes among:
          0: d (0 delay), 1: after 1 DFF, 2: after 2 DFFs, 3: after 3 DFFs.
    """,
    code="""
        module top_module (
            input        clk,
            input  [7:0] d,
            input  [1:0] sel,
            output reg [7:0] q
        );
            wire [7:0] a, b, c;
            my_dff8 d1 (.clk(clk), .d(d), .q(a));
            my_dff8 d2 (.clk(clk), .d(a), .q(b));
            my_dff8 d3 (.clk(clk), .d(b), .q(c));
            always @(*) begin
                case (sel)
                    2'd0: q = d;
                    2'd1: q = a;
                    2'd2: q = b;
                    2'd3: q = c;
                endcase
            end
        endmodule
    """,
    notes="HDLBits provides `my_dff8`. Local helper: `helpers/my_dff8.v`.",
)

add(
    num=25,
    section_dir="02_verilog_language/03_modules",
    filename="module_add",
    title="Adder 1",
    url=H + "Module_add",
    section_name="Verilog Language — Modules: Hierarchy",
    statement="""
        You are given `add16` (16-bit adder with carry in/out). Build a
        32-bit adder by instantiating two `add16` modules. The low half
        has cin=0; its cout feeds the high half's cin. Ignore the upper cout.
    """,
    code="""
        module top_module (
            input  [31:0] a,
            input  [31:0] b,
            output [31:0] sum
        );
            wire cout_lo;
            add16 lo (
                .a(a[15:0]),
                .b(b[15:0]),
                .cin(1'b0),
                .sum(sum[15:0]),
                .cout(cout_lo)
            );
            add16 hi (
                .a(a[31:16]),
                .b(b[31:16]),
                .cin(cout_lo),
                .sum(sum[31:16]),
                .cout()
            );
        endmodule
    """,
    notes="HDLBits provides `add16`. Local helper: `helpers/add16.v`.",
)

add(
    num=26,
    section_dir="02_verilog_language/03_modules",
    filename="module_fadd",
    title="Adder 2",
    url=H + "Module_fadd",
    section_name="Verilog Language — Modules: Hierarchy",
    statement="""
        Build a 32-bit adder from two provided `add16` modules (same as
        Adder 1) and also implement a 1-bit full adder `add1` (a, b, cin
        -> sum, cout). HDLBits uses your `add1` inside its `add16`.
    """,
    code="""
        module top_module (
            input  [31:0] a,
            input  [31:0] b,
            output [31:0] sum
        );
            wire cout_lo;
            add16 lo (
                .a(a[15:0]),
                .b(b[15:0]),
                .cin(1'b0),
                .sum(sum[15:0]),
                .cout(cout_lo)
            );
            add16 hi (
                .a(a[31:16]),
                .b(b[31:16]),
                .cin(cout_lo),
                .sum(sum[31:16]),
                .cout()
            );
        endmodule

        module add1 (
            input  a,
            input  b,
            input  cin,
            output sum,
            output cout
        );
            assign sum  = a ^ b ^ cin;
            assign cout = (a & b) | (a & cin) | (b & cin);
        endmodule
    """,
    notes="HDLBits provides `add16` and asks you to write `add1`. Local helper: `helpers/add16.v`.",
)

add(
    num=27,
    section_dir="02_verilog_language/03_modules",
    filename="module_cseladd",
    title="Carry-select adder",
    url=H + "Module_cseladd",
    section_name="Verilog Language — Modules: Hierarchy",
    statement="""
        Build a 32-bit carry-select adder from three `add16` instances:
          - add the lower 16 bits (cin=0) to get sum[15:0] and a carry
          - add the upper 16 bits twice, once with cin=0 and once with cin=1
          - mux the two upper sums using the lower carry
    """,
    code="""
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
    """,
    notes="HDLBits provides `add16`. Local helper: `helpers/add16.v`.",
)

add(
    num=28,
    section_dir="02_verilog_language/03_modules",
    filename="module_addsub",
    title="Adder-subtractor",
    url=H + "Module_addsub",
    section_name="Verilog Language — Modules: Hierarchy",
    statement="""
        Build a 32-bit adder-subtractor using two `add16` modules.
        When `sub` is 0, compute a+b. When `sub` is 1, compute a-b by
        inverting `b` and setting the low-half carry-in to 1 (two's complement).
    """,
    code="""
        module top_module (
            input         sub,
            input  [31:0] a,
            input  [31:0] b,
            output [31:0] sum
        );
            wire [31:0] b_xor;
            wire        cout_lo;
            assign b_xor = b ^ {32{sub}};
            add16 lo (
                .a(a[15:0]), .b(b_xor[15:0]), .cin(sub),
                .sum(sum[15:0]), .cout(cout_lo)
            );
            add16 hi (
                .a(a[31:16]), .b(b_xor[31:16]), .cin(cout_lo),
                .sum(sum[31:16]), .cout()
            );
        endmodule
    """,
    notes="HDLBits provides `add16`. Local helper: `helpers/add16.v`.",
)

# ---------------------------------------------------------------------------
# Procedures
# ---------------------------------------------------------------------------
add(
    num=29,
    section_dir="02_verilog_language/04_procedures",
    filename="alwaysblock1",
    title="Always blocks (combinational)",
    url=H + "Alwaysblock1",
    section_name="Verilog Language — Procedures",
    statement="""
        Build a 2-input AND gate twice: once with a continuous assignment
        (`out_assign`) and once with a combinational `always` block
        (`out_alwaysblock`). Both must compute a AND b.
    """,
    code="""
        module top_module (
            input  a,
            input  b,
            output     out_assign,
            output reg out_alwaysblock
        );
            assign out_assign = a & b;
            always @(*) begin
                out_alwaysblock = a & b;
            end
        endmodule
    """,
)

add(
    num=30,
    section_dir="02_verilog_language/04_procedures",
    filename="alwaysblock2",
    title="Always blocks (clocked)",
    url=H + "Alwaysblock2",
    section_name="Verilog Language — Procedures",
    statement="""
        Build an XOR three ways:
          out_assign       — continuous assignment (combinational)
          out_alwayscomb   — combinational always block (blocking `=`)
          out_alwaysff     — clocked always block, XOR registered on
                             posedge clk (non-blocking `<=`)
    """,
    code="""
        module top_module (
            input      clk,
            input      a,
            input      b,
            output     out_assign,
            output reg out_always_comb,
            output reg out_always_ff
        );
            assign out_assign = a ^ b;
            always @(*) begin
                out_always_comb = a ^ b;
            end
            always @(posedge clk) begin
                out_always_ff <= a ^ b;
            end
        endmodule
    """,
)

add(
    num=31,
    section_dir="02_verilog_language/04_procedures",
    filename="always_if",
    title="If statement",
    url=H + "Always_if",
    section_name="Verilog Language — Procedures",
    statement="""
        A 2-to-1 mux selects between two AND-like results:
          If `sel_b1` and `sel_b2` are both 1, choose `b`; otherwise choose `a`.
        Implement this with an `assign` (out_assign) and with an always-if
        (out_always).
    """,
    code="""
        module top_module (
            input      a,
            input      b,
            input      sel_b1,
            input      sel_b2,
            output     out_assign,
            output reg out_always
        );
            assign out_assign = (sel_b1 & sel_b2) ? b : a;
            always @(*) begin
                if (sel_b1 & sel_b2)
                    out_always = b;
                else
                    out_always = a;
            end
        endmodule
    """,
)

add(
    num=32,
    section_dir="02_verilog_language/04_procedures",
    filename="always_if2",
    title="If statement latches",
    url=H + "Always_if2",
    section_name="Verilog Language — Procedures",
    statement="""
        Fix a combinational always block that accidentally infers a latch
        because `out` is not assigned in every branch. The intended function
        is a mux: if `cpu_overheated` then `shut_off_computer = 1` else 0;
        if `arrived` then `keep_driving = ~gas_tank_empty` else 0.
        Always assign both outputs in all cases.
    """,
    code="""
        module top_module (
            input      cpu_overheated,
            output reg shut_off_computer,
            input      arrived,
            input      gas_tank_empty,
            output reg keep_driving
        );
            always @(*) begin
                if (cpu_overheated)
                    shut_off_computer = 1'b1;
                else
                    shut_off_computer = 1'b0;
            end

            always @(*) begin
                if (~arrived)
                    keep_driving = ~gas_tank_empty;
                else
                    keep_driving = 1'b0;
            end
        endmodule
    """,
)

add(
    num=33,
    section_dir="02_verilog_language/04_procedures",
    filename="always_case",
    title="Case statement",
    url=H + "Always_case",
    section_name="Verilog Language — Procedures",
    statement="""
        Build a 6-to-1 multiplexer. `sel` is 3 bits selecting among data0..data5.
        For sel=0..5 output the corresponding data input; for sel=6 or 7
        output 0. Use a case statement.
    """,
    code="""
        module top_module (
            input  [2:0] sel,
            input  [3:0] data0,
            input  [3:0] data1,
            input  [3:0] data2,
            input  [3:0] data3,
            input  [3:0] data4,
            input  [3:0] data5,
            output reg [3:0] out
        );
            always @(*) begin
                case (sel)
                    3'd0: out = data0;
                    3'd1: out = data1;
                    3'd2: out = data2;
                    3'd3: out = data3;
                    3'd4: out = data4;
                    3'd5: out = data5;
                    default: out = 4'd0;
                endcase
            end
        endmodule
    """,
)

add(
    num=34,
    section_dir="02_verilog_language/04_procedures",
    filename="always_case2",
    title="Priority encoder",
    url=H + "Always_case2",
    section_name="Verilog Language — Procedures",
    statement="""
        Build a 4-bit priority encoder: given `in[3:0]`, `pos` is the index
        of the first (least-significant) 1-bit. If `in` is 0, `pos` is 0
        (this version does not have a valid flag).
    """,
    code="""
        module top_module (
            input  [3:0] in,
            output reg [1:0] pos
        );
            always @(*) begin
                casez (in)
                    4'bzzz1: pos = 2'd0;
                    4'bzz10: pos = 2'd1;
                    4'bz100: pos = 2'd2;
                    4'b1000: pos = 2'd3;
                    default: pos = 2'd0;
                endcase
            end
        endmodule
    """,
)

add(
    num=35,
    section_dir="02_verilog_language/04_procedures",
    filename="always_casez",
    title="Priority encoder with casez",
    url=H + "Always_casez",
    section_name="Verilog Language — Procedures",
    statement="""
        Build an 8-bit priority encoder using `casez`. Output `pos[2:0]` is
        the index of the least-significant 1 in `in[7:0]`. If none are 1,
        output 0.
    """,
    code="""
        module top_module (
            input  [7:0] in,
            output reg [2:0] pos
        );
            always @(*) begin
                casez (in)
                    8'bzzzzzzz1: pos = 3'd0;
                    8'bzzzzzz10: pos = 3'd1;
                    8'bzzzzz100: pos = 3'd2;
                    8'bzzzz1000: pos = 3'd3;
                    8'bzzz10000: pos = 3'd4;
                    8'bzz100000: pos = 3'd5;
                    8'bz1000000: pos = 3'd6;
                    8'b10000000: pos = 3'd7;
                    default:     pos = 3'd0;
                endcase
            end
        endmodule
    """,
)

add(
    num=36,
    section_dir="02_verilog_language/04_procedures",
    filename="always_nolatches",
    title="Avoiding latches",
    url=H + "Always_nolatches",
    section_name="Verilog Language — Procedures",
    statement="""
        A combinational circuit recognizes a few 16-bit scancodes:
          16'he06b -> item0, 16'hfc70? actually:
          16'he06b: item[0]
          16'hfc70: no — HDLBits uses:
          16'he06b -> 0, 16'h713d -> 1, 16'h7272 -> 2, 16'he070 -> 3? 
        Standard mapping:
          16'he06b : item0 = 1
          16'h713d : item1 = 1
          16'h7272 : item2 = 1
          16'he070 : item3 = 1
        All other codes produce 0. Assign a default of 0 before the case
        so no latch is inferred.
    """,
    code="""
        module top_module (
            input      [15:0] scancode,
            output reg        left,
            output reg        down,
            output reg        right,
            output reg        up
        );
            always @(*) begin
                left  = 1'b0;
                down  = 1'b0;
                right = 1'b0;
                up    = 1'b0;
                case (scancode)
                    16'he06b: left  = 1'b1;
                    16'he072: down  = 1'b1;
                    16'he074: right = 1'b1;
                    16'he075: up    = 1'b1;
                endcase
            end
        endmodule
    """,
)

# ---------------------------------------------------------------------------
# More Verilog Features
# ---------------------------------------------------------------------------
add(
    num=37,
    section_dir="02_verilog_language/05_more_features",
    filename="conditional",
    title="Conditional ternary operator",
    url=H + "Conditional",
    section_name="Verilog Language — More Verilog Features",
    statement="""
        Given four unsigned 8-bit values a,b,c,d, find the minimum using
        nested ternary operators. Output `min`.
    """,
    code="""
        module top_module (
            input  [7:0] a, b, c, d,
            output [7:0] min
        );
            wire [7:0] min_ab  = (a < b) ? a : b;
            wire [7:0] min_cd  = (c < d) ? c : d;
            assign min = (min_ab < min_cd) ? min_ab : min_cd;
        endmodule
    """,
)

add(
    num=38,
    section_dir="02_verilog_language/05_more_features",
    filename="reduction",
    title="Reduction operators",
    url=H + "Reduction",
    section_name="Verilog Language — More Verilog Features",
    statement="""
        Compute even parity of an 8-bit value: `parity = ^in` (XOR reduction).
        Output 1 when there is an odd number of 1s.
    """,
    code="""
        module top_module (
            input  [7:0] in,
            output       parity
        );
            assign parity = ^in;
        endmodule
    """,
)

add(
    num=39,
    section_dir="02_verilog_language/05_more_features",
    filename="gates100",
    title="Reduction: Even wider gates",
    url=H + "Gates100",
    section_name="Verilog Language — More Verilog Features",
    statement="""
        100-input AND, OR, and XOR of `in[99:0]`.
    """,
    code="""
        module top_module (
            input  [99:0] in,
            output        out_and,
            output        out_or,
            output        out_xor
        );
            assign out_and = &in;
            assign out_or  = |in;
            assign out_xor = ^in;
        endmodule
    """,
)

add(
    num=40,
    section_dir="02_verilog_language/05_more_features",
    filename="vector100r",
    title="Combinational for-loop: Vector reversal 2",
    url=H + "Vector100r",
    section_name="Verilog Language — More Verilog Features",
    statement="""
        Reverse a 100-bit vector using a combinational for-loop inside an
        always block (or generate). out[i] = in[99-i].
    """,
    code="""
        module top_module (
            input  [99:0] in,
            output reg [99:0] out
        );
            integer i;
            always @(*) begin
                for (i = 0; i < 100; i = i + 1)
                    out[i] = in[99 - i];
            end
        endmodule
    """,
)

add(
    num=41,
    section_dir="02_verilog_language/05_more_features",
    filename="popcount255",
    title="Combinational for-loop: 255-bit population count",
    url=H + "Popcount255",
    section_name="Verilog Language — More Verilog Features",
    statement="""
        Count the number of 1s in a 255-bit vector. Output is 8 bits
        (`out[7:0]`). A for-loop adding each bit is acceptable.
    """,
    code="""
        module top_module (
            input  [254:0] in,
            output reg [7:0] out
        );
            integer i;
            always @(*) begin
                out = 8'd0;
                for (i = 0; i < 255; i = i + 1)
                    out = out + in[i];
            end
        endmodule
    """,
)

add(
    num=42,
    section_dir="02_verilog_language/05_more_features",
    filename="adder100i",
    title="Generate for-loop: 100-bit binary adder 2",
    url=H + "Adder100i",
    section_name="Verilog Language — More Verilog Features",
    statement="""
        Build a 100-bit ripple-carry adder from 100 full adders using a
        generate for-loop. Also expose the internal carry chain as
        `cout[99:0]` (cout[i] is the carry out of bit i).
    """,
    code="""
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
    """,
)

add(
    num=43,
    section_dir="02_verilog_language/05_more_features",
    filename="bcdadd100",
    title="Generate for-loop: 100-digit BCD adder",
    url=H + "Bcdadd100",
    section_name="Verilog Language — More Verilog Features",
    statement="""
        You are given `bcd_fadd` (4-bit BCD full adder: a[3:0], b[3:0], cin
        -> cout, sum[3:0]). Instantiate 100 of them with a generate loop to
        add two 100-digit BCD numbers `a[399:0]` and `b[399:0]`.
    """,
    code="""
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
    """,
    notes="HDLBits provides `bcd_fadd`. Local helper: `helpers/bcd_fadd.v`.",
)
