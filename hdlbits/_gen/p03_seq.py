"""HDLBits 081-118: Sequential logic (flip-flops, counters, shift regs, CA)."""
from emit import add

H = "https://hdlbits.01xz.net/wiki/"
FF = "03_circuits/02_sequential/01_latches_ff"
CT = "03_circuits/02_sequential/02_counters"
SR = "03_circuits/02_sequential/03_shift_registers"
MC = "03_circuits/02_sequential/04_more_circuits"
S_FF = "Circuits — Sequential Logic — Latches and Flip-Flops"
S_CT = "Circuits — Sequential Logic — Counters"
S_SR = "Circuits — Sequential Logic — Shift Registers"
S_MC = "Circuits — Sequential Logic — More Circuits"

add(
    num=81, section_dir=FF, filename="dff", title="D flip-flop",
    url=H + "Dff", section_name=S_FF,
    statement="Positive-edge D flip-flop: q <= d on posedge clk.",
    code="""
        module top_module (
            input      clk,
            input      d,
            output reg q
        );
            always @(posedge clk)
                q <= d;
        endmodule
    """,
)

add(
    num=82, section_dir=FF, filename="dff8", title="D flip-flops",
    url=H + "Dff8", section_name=S_FF,
    statement="8-bit register: q[7:0] <= d[7:0] on posedge clk.",
    code="""
        module top_module (
            input            clk,
            input      [7:0] d,
            output reg [7:0] q
        );
            always @(posedge clk)
                q <= d;
        endmodule
    """,
)

add(
    num=83, section_dir=FF, filename="dff8r", title="DFF with reset",
    url=H + "Dff8r", section_name=S_FF,
    statement="8-bit register with active-high synchronous reset to 0.",
    code="""
        module top_module (
            input            clk,
            input            reset,
            input      [7:0] d,
            output reg [7:0] q
        );
            always @(posedge clk) begin
                if (reset)
                    q <= 8'd0;
                else
                    q <= d;
            end
        endmodule
    """,
)

add(
    num=84, section_dir=FF, filename="dff8p", title="DFF with reset value",
    url=H + "Dff8p", section_name=S_FF,
    statement="""
        8-bit register clocked on the *negative* edge, with active-high
        synchronous reset that loads 8'h34.
    """,
    code="""
        module top_module (
            input            clk,
            input            reset,
            input      [7:0] d,
            output reg [7:0] q
        );
            always @(negedge clk) begin
                if (reset)
                    q <= 8'h34;
                else
                    q <= d;
            end
        endmodule
    """,
)

add(
    num=85, section_dir=FF, filename="dff8ar", title="DFF with asynchronous reset",
    url=H + "Dff8ar", section_name=S_FF,
    statement="8-bit register with active-high asynchronous reset to 0.",
    code="""
        module top_module (
            input            clk,
            input            areset,
            input      [7:0] d,
            output reg [7:0] q
        );
            always @(posedge clk or posedge areset) begin
                if (areset)
                    q <= 8'd0;
                else
                    q <= d;
            end
        endmodule
    """,
)

add(
    num=86, section_dir=FF, filename="dff16e", title="DFF with byte enable",
    url=H + "Dff16e", section_name=S_FF,
    statement="""
        16-bit register, synchronous reset to 0. Byte enables:
          byteena[1] enables q[15:8], byteena[0] enables q[7:0].
        Unenabled bytes hold their value.
    """,
    code="""
        module top_module (
            input            clk,
            input            resetn,
            input      [1:0] byteena,
            input      [15:0] d,
            output reg [15:0] q
        );
            always @(posedge clk) begin
                if (!resetn)
                    q <= 16'd0;
                else begin
                    if (byteena[1]) q[15:8] <= d[15:8];
                    if (byteena[0]) q[7:0]  <= d[7:0];
                end
            end
        endmodule
    """,
)

add(
    num=87, section_dir=FF, filename="m2014_q4a", title="D Latch",
    url=H + "Exams/m2014_q4a", section_name=S_FF,
    statement="Level-sensitive D latch: when `ena` is 1, q follows d; otherwise q holds.",
    code="""
        module top_module (
            input      d,
            input      ena,
            output reg q
        );
            always @(*) begin
                if (ena)
                    q = d;
            end
        endmodule
    """,
)

add(
    num=88, section_dir=FF, filename="m2014_q4b", title="DFF",
    url=H + "Exams/m2014_q4b", section_name=S_FF,
    statement="Positive-edge DFF with active-high asynchronous reset to 0.",
    code="""
        module top_module (
            input      clk,
            input      d,
            input      ar,
            output reg q
        );
            always @(posedge clk or posedge ar) begin
                if (ar)
                    q <= 1'b0;
                else
                    q <= d;
            end
        endmodule
    """,
)

add(
    num=89, section_dir=FF, filename="m2014_q4c", title="DFF",
    url=H + "Exams/m2014_q4c", section_name=S_FF,
    statement="Positive-edge DFF with active-high *synchronous* reset to 0.",
    code="""
        module top_module (
            input      clk,
            input      d,
            input      r,
            output reg q
        );
            always @(posedge clk) begin
                if (r)
                    q <= 1'b0;
                else
                    q <= d;
            end
        endmodule
    """,
)

add(
    num=90, section_dir=FF, filename="m2014_q4d", title="DFF+gate",
    url=H + "Exams/m2014_q4d", section_name=S_FF,
    statement="""
        XOR the input with the current output and register that on posedge
        clk (a toggle-when-in-is-1 / XOR-feedback DFF):
          q <= q ^ in
        Output is q. Reset is not present on this figure.
    """,
    code="""
        module top_module (
            input      clk,
            input      in,
            output reg out
        );
            always @(posedge clk)
                out <= out ^ in;
        endmodule
    """,
)

add(
    num=91, section_dir=FF, filename="mt2015_muxdff", title="Mux and DFF",
    url=H + "Mt2015_muxdff", section_name=S_FF,
    statement="""
        2:1 mux in front of a DFF. When L=1, load `d`; when L=0, load `w`
        (or the other way: L selects d vs feedback). HDLBits: L=1 chooses r
        (or d), L=0 chooses E ? w : q. This simpler problem is:
          next = L ? r : w;  q <= next
        Ports: clk, L, q_in, r_in, Q? Standard ports:
          clk, w, R, E, L  — that's 2014_q4a.
        This problem (mt2015_muxdff) ports: clk, L, q_in, d_in, Q
          Q <= L ? d_in : q_in
    """,
    code="""
        module top_module (
            input      clk,
            input      L,
            input      q_in,
            input      r_in,
            output reg Q
        );
            always @(posedge clk)
                Q <= L ? r_in : q_in;
        endmodule
    """,
)

add(
    num=92, section_dir=FF, filename="2014_q4a", title="Mux and DFF",
    url=H + "Exams/2014_q4a", section_name=S_FF,
    statement="""
        One cell of a shift register: a DFF whose next value is
          L=1: load R
          L=0, E=1: shift in w
          L=0, E=0: hold q
    """,
    code="""
        module top_module (
            input      clk,
            input      w, R, E, L,
            output reg Q
        );
            always @(posedge clk) begin
                if (L)
                    Q <= R;
                else if (E)
                    Q <= w;
            end
        endmodule
    """,
)

add(
    num=93, section_dir=FF, filename="ece241_2014_q4", title="DFFs and gates",
    url=H + "Exams/ece241_2014_q4", section_name=S_FF,
    statement="""
        Three DFFs with combinational feedback from input x:
          q0 <= q0 ^ x
          q1 <= ~q1 & x
          q2 <= ~q2 | x
        Output z is NOR of the three Qs: z = ~(q0 | q1 | q2)
        No explicit reset; they start at X in simulation unless you care.
        HDLBits typically does not reset them (or they come up 0 in the tester).
    """,
    code="""
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
    """,
)

add(
    num=94, section_dir=FF, filename="ece241_2013_q7", title="Create circuit from truth table",
    url=H + "Exams/ece241_2013_q7", section_name=S_FF,
    statement="""
        Implement a JK flip-flop from a DFF using the characteristic table:
          J K | Q+
          0 0 | Q
          0 1 | 0
          1 0 | 1
          1 1 | ~Q
    """,
    code="""
        module top_module (
            input      clk,
            input      j,
            input      k,
            output reg Q
        );
            always @(posedge clk) begin
                case ({j, k})
                    2'b00: Q <= Q;
                    2'b01: Q <= 1'b0;
                    2'b10: Q <= 1'b1;
                    2'b11: Q <= ~Q;
                endcase
            end
        endmodule
    """,
)

add(
    num=95, section_dir=FF, filename="edgedetect", title="Detect an edge",
    url=H + "Edgedetect", section_name=S_FF,
    statement="""
        For each bit of a 8-bit vector, pulse `pedge` for one cycle when that
        bit has a 0->1 transition.
    """,
    code="""
        module top_module (
            input            clk,
            input      [7:0] in,
            output reg [7:0] pedge
        );
            reg [7:0] in_d;
            always @(posedge clk) begin
                in_d  <= in;
                pedge <= in & ~in_d;
            end
        endmodule
    """,
)

add(
    num=96, section_dir=FF, filename="edgedetect2", title="Detect both edges",
    url=H + "Edgedetect2", section_name=S_FF,
    statement="Pulse `anyedge` for one cycle on any 0->1 or 1->0 transition (8 bits).",
    code="""
        module top_module (
            input            clk,
            input      [7:0] in,
            output reg [7:0] anyedge
        );
            reg [7:0] in_d;
            always @(posedge clk) begin
                in_d    <= in;
                anyedge <= in ^ in_d;
            end
        endmodule
    """,
)

add(
    num=97, section_dir=FF, filename="edgecapture", title="Edge capture register",
    url=H + "Edgecapture", section_name=S_FF,
    statement="""
        32-bit register. For each bit, set the output bit when that input bit
        has a 1->0 transition, and hold it until a synchronous reset.
        Reset is active-high and takes priority.
    """,
    code="""
        module top_module (
            input             clk,
            input             reset,
            input      [31:0] in,
            output reg [31:0] out
        );
            reg [31:0] in_d;
            always @(posedge clk) begin
                in_d <= in;
                if (reset)
                    out <= 32'd0;
                else
                    out <= out | (~in & in_d);
            end
        endmodule
    """,
)

add(
    num=98, section_dir=FF, filename="dualedge", title="Dual-edge triggered flip-flop",
    url=H + "Dualedge", section_name=S_FF,
    statement="""
        A flip-flop that samples `d` on both rising and falling edges of clk.
        Implement with two DFFs (posedge and negedge) and XOR/mux them:
          q = clk ? q_neg : q_pos   (one accepted form)
        or q = q_pos ^ q_neg with carefully chosen next-state equations.
        The mux form: posedge register samples d, negedge register samples d,
        output is clk ? n : p so the most recently sampled value is seen.
    """,
    code="""
        module top_module (
            input      clk,
            input      d,
            output     q
        );
            reg p, n;
            always @(posedge clk)
                p <= d;
            always @(negedge clk)
                n <= d;
            assign q = clk ? p : n;
        endmodule
    """,
)

# Counters
add(
    num=99, section_dir=CT, filename="count15", title="Four-bit binary counter",
    url=H + "Count15", section_name=S_CT,
    statement="4-bit counter, wraps 0..15. Synchronous reset to 0.",
    code="""
        module top_module (
            input            clk,
            input            reset,
            output reg [3:0] q
        );
            always @(posedge clk) begin
                if (reset)
                    q <= 4'd0;
                else
                    q <= q + 4'd1;
            end
        endmodule
    """,
)

add(
    num=100, section_dir=CT, filename="count10", title="Decade counter",
    url=H + "Count10", section_name=S_CT,
    statement="Count 0 through 9, then wrap to 0. Synchronous reset to 0.",
    code="""
        module top_module (
            input            clk,
            input            reset,
            output reg [3:0] q
        );
            always @(posedge clk) begin
                if (reset || q == 4'd9)
                    q <= 4'd0;
                else
                    q <= q + 4'd1;
            end
        endmodule
    """,
)

add(
    num=101, section_dir=CT, filename="count1to10", title="Decade counter again",
    url=H + "Count1to10", section_name=S_CT,
    statement="Count 1 through 10, then wrap to 1. Synchronous reset to 1.",
    code="""
        module top_module (
            input            clk,
            input            reset,
            output reg [3:0] q
        );
            always @(posedge clk) begin
                if (reset || q == 4'd10)
                    q <= 4'd1;
                else
                    q <= q + 4'd1;
            end
        endmodule
    """,
)

add(
    num=102, section_dir=CT, filename="countslow", title="Slow decade counter",
    url=H + "Countslow", section_name=S_CT,
    statement="""
        Decade counter (0-9) that only increments when `slowena` is 1.
        Synchronous reset to 0.
    """,
    code="""
        module top_module (
            input            clk,
            input            slowena,
            input            reset,
            output reg [3:0] q
        );
            always @(posedge clk) begin
                if (reset)
                    q <= 4'd0;
                else if (slowena) begin
                    if (q == 4'd9)
                        q <= 4'd0;
                    else
                        q <= q + 4'd1;
                end
            end
        endmodule
    """,
)

add(
    num=103, section_dir=CT, filename="ece241_2014_q7a", title="Counter 1-12",
    url=H + "Exams/ece241_2014_q7a", section_name=S_CT,
    statement="""
        Count 1 through 12 using a provided 4-bit binary counter with
        enable, load, and load-data ports. You drive:
          c_enable, c_load, c_d[3:0]
        and the provided counter's Q is `q`. Reset (active high, sync)
        loads 1. Wrap from 12 back to 1 by loading 1.
        HDLBits provides `count4`. Local helper: helpers/count4.v.
    """,
    code="""
        module top_module (
            input            clk,
            input            reset,
            input            enable,
            output [3:0]     Q,
            output           c_enable,
            output           c_load,
            output [3:0]     c_d
        );
            count4 the_counter (
                .clk(clk),
                .enable(c_enable),
                .load(c_load),
                .d(c_d),
                .q(Q)
            );
            assign c_enable = enable;
            assign c_load   = reset | (Q == 4'd12 && enable);
            assign c_d      = 4'd1;
        endmodule
    """,
    notes="HDLBits provides `count4`. Local helper: `helpers/count4.v`.",
)

add(
    num=104, section_dir=CT, filename="ece241_2014_q7b", title="Counter 1000",
    url=H + "Exams/ece241_2014_q7b", section_name=S_CT,
    statement="""
        From a 1000 Hz clock, produce a 1 Hz pulse `OneHertz` by cascading
        three decade (0-9) counters. HDLBits provides `bcdcount`
        (enable in, Q[3:0], enable out). Wire them so the next digit
        enables when the previous is at 9 and enabled.
        OneHertz is 1 when all three digits are 9.
    """,
    code="""
        module top_module (
            input  clk,
            input  reset,
            output OneHertz,
            output [2:0] c_enable
        );
            wire [3:0] q0, q1, q2;
            assign c_enable[0] = 1'b1;
            assign c_enable[1] = (q0 == 4'd9);
            assign c_enable[2] = (q0 == 4'd9) && (q1 == 4'd9);
            bcdcount counter0 (.clk(clk), .reset(reset), .enable(c_enable[0]), .Q(q0));
            bcdcount counter1 (.clk(clk), .reset(reset), .enable(c_enable[1]), .Q(q1));
            bcdcount counter2 (.clk(clk), .reset(reset), .enable(c_enable[2]), .Q(q2));
            assign OneHertz = (q0 == 4'd9) && (q1 == 4'd9) && (q2 == 4'd9);
        endmodule
    """,
    notes="HDLBits provides `bcdcount`. Local helper: `helpers/bcdcount.v`.",
)

add(
    num=105, section_dir=CT, filename="countbcd", title="4-digit decimal counter",
    url=H + "Countbcd", section_name=S_CT,
    statement="""
        4-digit BCD counter (0 to 9999) with one enable. Each digit is 4 bits
        packed into q[15:0] (ones in [3:0]). `ena[3:1]` indicates when digits
        1, 2, 3 should increment (ones digit always counts).
        Synchronous reset to 0.
    """,
    code="""
        module top_module (
            input            clk,
            input            reset,
            output [3:1]     ena,
            output reg [15:0] q
        );
            assign ena[1] = (q[3:0]   == 4'd9);
            assign ena[2] = ena[1] && (q[7:4]   == 4'd9);
            assign ena[3] = ena[2] && (q[11:8]  == 4'd9);

            always @(posedge clk) begin
                if (reset)
                    q <= 16'd0;
                else begin
                    q[3:0] <= (q[3:0] == 4'd9) ? 4'd0 : q[3:0] + 4'd1;
                    if (ena[1])
                        q[7:4] <= (q[7:4] == 4'd9) ? 4'd0 : q[7:4] + 4'd1;
                    if (ena[2])
                        q[11:8] <= (q[11:8] == 4'd9) ? 4'd0 : q[11:8] + 4'd1;
                    if (ena[3])
                        q[15:12] <= (q[15:12] == 4'd9) ? 4'd0 : q[15:12] + 4'd1;
                end
            end
        endmodule
    """,
)

add(
    num=106, section_dir=CT, filename="count_clock", title="12-hour clock",
    url=H + "Count_clock", section_name=S_CT,
    statement="""
        12-hour clock: hours (1-12, BCD in hh[7:0]), minutes (00-59, mm[7:0]),
        seconds (00-59, ss[7:0]), plus AM/PM (`pm`).
        Synchronous reset sets 12:00:00 AM.
        `ena` enables counting. Increment seconds, then minutes, then hours.
        After 11:59:59 AM comes 12:00:00 PM, after 11:59:59 PM comes 12:00:00 AM.
        After 12:59:59 the hour becomes 1 (same am/pm).
    """,
    code="""
        module top_module (
            input            clk,
            input            reset,
            input            ena,
            output reg       pm,
            output reg [7:0] hh,
            output reg [7:0] mm,
            output reg [7:0] ss
        );
            wire wrap_ss = (ss == 8'h59);
            wire wrap_mm = wrap_ss && (mm == 8'h59);
            wire wrap_hh = wrap_mm && (hh == 8'h12);

            function [7:0] bcd_inc;
                input [7:0] v;
                begin
                    if (v[3:0] == 4'd9)
                        bcd_inc = {v[7:4] + 4'd1, 4'd0};
                    else
                        bcd_inc = v + 8'd1;
                end
            endfunction

            always @(posedge clk) begin
                if (reset) begin
                    ss <= 8'h00;
                    mm <= 8'h00;
                    hh <= 8'h12;
                    pm <= 1'b0;
                end else if (ena) begin
                    if (wrap_ss) ss <= 8'h00;
                    else         ss <= bcd_inc(ss);

                    if (wrap_ss) begin
                        if (wrap_mm) mm <= 8'h00;
                        else         mm <= bcd_inc(mm);
                    end

                    if (wrap_mm) begin
                        if (hh == 8'h11) begin
                            hh <= 8'h12;
                            pm <= ~pm;
                        end else if (hh == 8'h12) begin
                            hh <= 8'h01;
                        end else begin
                            hh <= bcd_inc(hh);
                        end
                    end
                end
            end
        endmodule
    """,
)

# Shift registers
add(
    num=107, section_dir=SR, filename="shift4", title="4-bit shift register",
    url=H + "Shift4", section_name=S_SR,
    statement="""
        4-bit shift register, shifts toward MSB (q[3] is the last bit out):
          areset (async) to 0
          load: parallel load data[3:0]
          ena: shift in `in` at LSB (q <= {q[2:0], in})
        Load has priority over ena.
    """,
    code="""
        module top_module (
            input            clk,
            input            areset,
            input            load,
            input            ena,
            input      [3:0] data,
            output reg [3:0] q
        );
            always @(posedge clk or posedge areset) begin
                if (areset)
                    q <= 4'd0;
                else if (load)
                    q <= data;
                else if (ena)
                    q <= {1'b0, q[3:1]};
            end
        endmodule
    """,
)

add(
    num=108, section_dir=SR, filename="rotate100", title="Left/right rotator",
    url=H + "Rotate100", section_name=S_SR,
    statement="""
        100-bit rotator. `load` parallel-loads `data`. Otherwise `ena`:
          2'b01: rotate right by 1
          2'b10: rotate left by 1
          other: hold
    """,
    code="""
        module top_module (
            input             clk,
            input             load,
            input      [1:0]  ena,
            input      [99:0] data,
            output reg [99:0] q
        );
            always @(posedge clk) begin
                if (load)
                    q <= data;
                else begin
                    case (ena)
                        2'b01: q <= {q[0], q[99:1]};
                        2'b10: q <= {q[98:0], q[99]};
                        default: q <= q;
                    endcase
                end
            end
        endmodule
    """,
)

add(
    num=109, section_dir=SR, filename="shift18", title="Left/right arithmetic shift by 1 or 8",
    url=H + "Shift18", section_name=S_SR,
    statement="""
        64-bit arithmetic shifter. `load` loads `data`. When `ena`:
          amount=00: shift left 1
          amount=01: shift left 8
          amount=10: arithmetic shift right 1
          amount=11: arithmetic shift right 8
    """,
    code="""
        module top_module (
            input             clk,
            input             load,
            input             ena,
            input      [1:0]  amount,
            input      [63:0] data,
            output reg [63:0] q
        );
            always @(posedge clk) begin
                if (load)
                    q <= data;
                else if (ena) begin
                    case (amount)
                        2'b00: q <= q << 1;
                        2'b01: q <= q << 8;
                        2'b10: q <= {q[63], q[63:1]};
                        2'b11: q <= {{8{q[63]}}, q[63:8]};
                    endcase
                end
            end
        endmodule
    """,
)

add(
    num=110, section_dir=SR, filename="lfsr5", title="5-bit LFSR",
    url=H + "Lfsr5", section_name=S_SR,
    statement="""
        5-bit Galois LFSR. Bit numbering q[4:0] corresponds to positions 5..1
        in the figure. XOR tap at position 3 (q[2]). Synchronous reset to 1.
        q <= {0 xor q[0], q[4], q[3] xor q[0], q[2], q[1]} with Galois
        form: shift toward MSB, feedback into LSB, XOR into tap.
        Fibonacci equivalent used here: q <= {q[3:0], q[4] ^ q[2]}.
    """,
    code="""
        module top_module (
            input            clk,
            input            reset,
            output reg [4:0] q
        );
            always @(posedge clk) begin
                if (reset)
                    q <= 5'h1;
                else
                    q <= {q[0], q[4], q[3] ^ q[0], q[2], q[1]};
            end
        endmodule
    """,
)

add(
    num=111, section_dir=SR, filename="mt2015_lfsr", title="3-bit LFSR",
    url=H + "Mt2015_lfsr", section_name=S_SR,
    statement="""
        3-bit LFSR with parallel load. Ports match the exam (SW/KEY/LEDR):
          clk = KEY[0], L = KEY[1], R = SW[2:0], Q = LEDR[2:0]
        When L=1, load SW. Otherwise:
          q[2] <= q[1]
          q[1] <= q[0]
          q[0] <= q[2] ^ q[1]
    """,
    code="""
        module top_module (
            input  [2:0] SW,
            input  [1:0] KEY,
            output [2:0] LEDR
        );
            wire clk = KEY[0];
            wire L   = KEY[1];
            reg  [2:0] Q;
            always @(posedge clk) begin
                if (L)
                    Q <= SW;
                else
                    Q <= {Q[1], Q[0], Q[2] ^ Q[1]};
            end
            assign LEDR = Q;
        endmodule
    """,
)

add(
    num=112, section_dir=SR, filename="lfsr32", title="32-bit LFSR",
    url=H + "Lfsr32", section_name=S_SR,
    statement="""
        32-bit Galois LFSR with taps at 32, 22, 2, 1. Synchronous reset to 1.
        Fibonacci form: q <= {q[30:0], q[31]^q[21]^q[1]^q[0]}.
    """,
    code="""
        module top_module (
            input             clk,
            input             reset,
            output reg [31:0] q
        );
            always @(posedge clk) begin
                if (reset)
                    q <= 32'h1;
                else
                    q <= {q[30:0], q[31] ^ q[21] ^ q[1] ^ q[0]};
            end
        endmodule
    """,
)

add(
    num=113, section_dir=SR, filename="m2014_q4k", title="Shift register",
    url=H + "Exams/m2014_q4k", section_name=S_SR,
    statement="""
        4-bit shift register, active-low synchronous reset. Shift in `in` at
        the LSB; `out` is the MSB. resetn=0 clears to 0.
    """,
    code="""
        module top_module (
            input      clk,
            input      resetn,
            input      in,
            output     out
        );
            reg [3:0] q;
            always @(posedge clk) begin
                if (!resetn)
                    q <= 4'd0;
                else
                    q <= {q[2:0], in};
            end
            assign out = q[3];
        endmodule
    """,
)

add(
    num=114, section_dir=SR, filename="2014_q4b", title="Shift register",
    url=H + "Exams/2014_q4b", section_name=S_SR,
    statement="""
        4-bit shift register built from the mux+DFF cell of 2014_q4a.
        FPGA-board ports: KEY[0]=clk, KEY[1]=E, KEY[2]=L, KEY[3]=w,
        SW[3:0]=R, LEDR[3:0]=Q. Chain w into Q[0], Q[0] into Q[1], ...
    """,
    code="""
        module top_module (
            input  [3:0] SW,
            input  [3:0] KEY,
            output [3:0] LEDR
        );
            muxdff u0 (.clk(KEY[0]), .w(KEY[3]),   .R(SW[0]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[0]));
            muxdff u1 (.clk(KEY[0]), .w(LEDR[0]),  .R(SW[1]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[1]));
            muxdff u2 (.clk(KEY[0]), .w(LEDR[1]),  .R(SW[2]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[2]));
            muxdff u3 (.clk(KEY[0]), .w(LEDR[2]),  .R(SW[3]), .E(KEY[1]), .L(KEY[2]), .Q(LEDR[3]));
        endmodule

        module muxdff (
            input      clk,
            input      w, R, E, L,
            output reg Q
        );
            always @(posedge clk) begin
                if (L)
                    Q <= R;
                else if (E)
                    Q <= w;
            end
        endmodule
    """,
)

add(
    num=115, section_dir=SR, filename="ece241_2013_q12", title="3-input LUT",
    url=H + "Exams/ece241_2013_q12", section_name=S_SR,
    statement="""
        8-bit shift register (shifts in S when enable=1) feeding an 8-to-1
        mux addressed by {A,B,C}. Output Z is the selected bit of the register.
        Q[0] is the oldest bit (first shifted in appears at Q[0] after 1 cycle
        — actually S enters Q[0], then moves toward Q[7]).
        Z = Q[{A,B,C}].
    """,
    code="""
        module top_module (
            input      clk,
            input      enable,
            input      S,
            input      A, B, C,
            output     Z
        );
            reg [7:0] Q;
            always @(posedge clk) begin
                if (enable)
                    Q <= {Q[6:0], S};
            end
            assign Z = Q[{A, B, C}];
        endmodule
    """,
)

add(
    num=116, section_dir=MC, filename="rule90", title="Rule 90",
    url=H + "Rule90", section_name=S_MC,
    statement="""
        512-cell elementary cellular automaton, Rule 90: next[i] = left XOR right.
        `load` parallel-loads `data`. Neighbours past the ends are 0.
        Advance one generation each clock when not loading.
    """,
    code="""
        module top_module (
            input             clk,
            input             load,
            input      [511:0] data,
            output reg [511:0] q
        );
            always @(posedge clk) begin
                if (load)
                    q <= data;
                else
                    q <= {1'b0, q[511:1]} ^ {q[510:0], 1'b0};
            end
        endmodule
    """,
)

add(
    num=117, section_dir=MC, filename="rule110", title="Rule 110",
    url=H + "Rule110", section_name=S_MC,
    statement="""
        512-cell Rule 110 automaton. For neighbourhood ABC (left,cell,right)
        the next bit is 1 for 110, 101, 011, 010, 001 (and 0 for 111, 100, 000).
        `load` loads `data`. End neighbours are 0.
    """,
    code="""
        module top_module (
            input              clk,
            input              load,
            input      [511:0] data,
            output reg [511:0] q
        );
            wire [511:0] left  = {1'b0, q[511:1]};
            wire [511:0] right = {q[510:0], 1'b0};
            always @(posedge clk) begin
                if (load)
                    q <= data;
                else
                    q <= (q ^ right) | (q & ~left);
            end
        endmodule
    """,
)

add(
    num=118, section_dir=MC, filename="conwaylife", title="Conway's Game of Life 16x16",
    url=H + "Conwaylife", section_name=S_MC,
    statement="""
        16x16 Game of Life with wrap-around (torus). `load` loads q from data.
        Each cell: 2 neighbours and live -> stay; 3 neighbours -> born/stay;
        otherwise die. q is packed 256 bits, row-major (q[15:0] is row 0).
    """,
    code="""
        module top_module (
            input              clk,
            input              load,
            input      [255:0] data,
            output reg [255:0] q
        );
            integer r, c, dr, dc, nr, nc, nlive;
            always @(posedge clk) begin
                if (load)
                    q <= data;
                else begin
                    for (r = 0; r < 16; r = r + 1) begin
                        for (c = 0; c < 16; c = c + 1) begin
                            nlive = 0;
                            for (dr = -1; dr <= 1; dr = dr + 1) begin
                                for (dc = -1; dc <= 1; dc = dc + 1) begin
                                    if (dr != 0 || dc != 0) begin
                                        nr = (r + dr + 16) % 16;
                                        nc = (c + dc + 16) % 16;
                                        nlive = nlive + q[nr*16 + nc];
                                    end
                                end
                            end
                            if (nlive == 3)
                                q[r*16 + c] <= 1'b1;
                            else if (nlive == 2)
                                q[r*16 + c] <= q[r*16 + c];
                            else
                                q[r*16 + c] <= 1'b0;
                        end
                    end
                end
            end
        endmodule
    """,
)
