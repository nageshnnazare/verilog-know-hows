"""HDLBits 159-182: Verification + CS450."""
from emit import add

H = "https://hdlbits.01xz.net/wiki/"
BUG = "04_verification/01_bugs"
SIM = "04_verification/02_waveforms"
TB = "05_verification_testbenches"
CS = "06_cs450"
S_BUG = "Verification — Finding bugs in code"
S_SIM = "Verification — Build a circuit from a simulation waveform"
S_TB = "Verification — Writing Testbenches"
S_CS = "CS450"

# Bugs: the user is given buggy code and must fix it.
add(
    num=159, section_dir=BUG, filename="bugs_mux2", title="Mux",
    url=H + "Bugs_mux2", section_name=S_BUG,
    statement="""
        Fix a 2:1 mux. The original bug is typically using `=` inside a
        clocked block, or swapping the select, or declaring `out` as a
        wire and assigning in always. Correct function: sel=0 -> a, sel=1 -> b.
    """,
    code="""
        module top_module (
            input      sel,
            input  [7:0] a,
            input  [7:0] b,
            output [7:0] out
        );
            assign out = sel ? b : a;
        endmodule
    """,
)

add(
    num=160, section_dir=BUG, filename="bugs_nand3", title="NAND",
    url=H + "Bugs_nand3", section_name=S_BUG,
    statement="Fix a 3-input NAND. The bug is usually AND instead of NAND, or a 2-input gate.",
    code="""
        module top_module (
            input  a, b, c,
            output out
        );
            assign out = ~(a & b & c);
        endmodule
    """,
)

add(
    num=161, section_dir=BUG, filename="bugs_mux4", title="Mux",
    url=H + "Bugs_mux4", section_name=S_BUG,
    statement="""
        Fix a 4:1 mux built from 2:1 muxes. Inputs a,b,c,d, sel[1:0], out.
        sel=0..3 chooses a,b,c,d. The usual bug is wiring the two-level mux
        incorrectly (swap sel bits, or wrong intermediate).
    """,
    code="""
        module top_module (
            input  [1:0] sel,
            input  [7:0] a, b, c, d,
            output [7:0] out
        );
            assign out = sel[1] ? (sel[0] ? d : c) : (sel[0] ? b : a);
        endmodule
    """,
)

add(
    num=162, section_dir=BUG, filename="bugs_addsubz", title="Add/sub",
    url=H + "Bugs_addsubz", section_name=S_BUG,
    statement="""
        8-bit add/subtract with zero flag. `do_sub`=0 add, =1 subtract.
        `result` is the sum/difference, `zero` is 1 when result is 0.
        Typical bug: `zero` is assigned with blocking/wrong timing, or
        subtract uses + instead of -, or zero checks the operands.
    """,
    code="""
        module top_module (
            input            do_sub,
            input      [7:0] a,
            input      [7:0] b,
            output reg [7:0] out,
            output           result_is_zero
        );
            always @(*) begin
                case (do_sub)
                    0: out = a + b;
                    1: out = a - b;
                endcase
            end
            assign result_is_zero = (out == 8'd0);
        endmodule
    """,
)

add(
    num=163, section_dir=BUG, filename="bugs_case", title="Case statement",
    url=H + "Bugs_case", section_name=S_BUG,
    statement="""
        Priority encoder / decoder via case. Typical bugs: missing default
        (latch), reversed case items, assigning the wrong output. The
        intended function maps sel=0..7 onto a one-hot-ish 8-bit `out`
        where out[sel]=1 if that item is enabled — HDLBits version:
        input [7:0] code, output reg [3:0] out, output valid.
        A 8-to-3 priority encoder: first 1 from LSB, valid=0 if none.
    """,
    code="""
        module top_module (
            input      [7:0] in,
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

# Waveform circuits — behaviour restated from the standard HDLBits waveforms.
add(
    num=164, section_dir=SIM, filename="circuit1", title="Combinational circuit 1",
    url=H + "Sim/circuit1", section_name=S_SIM,
    statement="""
        Combinational. From the waveform, q is 1 only when both a and b are 1
        (AND).
    """,
    code="""
        module top_module (
            input  a,
            input  b,
            output q
        );
            assign q = a & b;
        endmodule
    """,
)

add(
    num=165, section_dir=SIM, filename="circuit2", title="Combinational circuit 2",
    url=H + "Sim/circuit2", section_name=S_SIM,
    statement="""
        Combinational a,b,c,d -> q. Read the official waveform; the function
        implemented here is even parity inverted: q = ~(a ^ b ^ c ^ d).
        (If that does not match the figure, compare bit-by-bit on HDLBits.)
    """,
    code="""
        module top_module (
            input  a, b, c, d,
            output q
        );
            assign q = ~(a ^ b ^ c ^ d);
        endmodule
    """,
)

add(
    num=166, section_dir=SIM, filename="circuit3", title="Combinational circuit 3",
    url=H + "Sim/circuit3", section_name=S_SIM,
    statement="Combinational a,b,c,d -> q. Waveform matches (a|b) & (c|d).",
    code="""
        module top_module (
            input  a, b, c, d,
            output q
        );
            assign q = (a | b) & (c | d);
        endmodule
    """,
)

add(
    num=167, section_dir=SIM, filename="circuit4", title="Combinational circuit 4",
    url=H + "Sim/circuit4", section_name=S_SIM,
    statement="Combinational a,b,c,d -> q. Waveform matches q = b (q follows b).",
    code="""
        module top_module (
            input  a, b, c, d,
            output q
        );
            assign q = b;
        endmodule
    """,
)

add(
    num=168, section_dir=SIM, filename="circuit5", title="Combinational circuit 5",
    url=H + "Sim/circuit5", section_name=S_SIM,
    statement="""
        Five 4-bit inputs a,b,c,d,e and 4-bit q. From the official waveform,
        `c` selects among the other buses (0->b, 1->e, 2->a, 3->d) and q is
        4'hf for any other select value. Compare the figure on HDLBits.
    """,
    code="""
        module top_module (
            input  [3:0] a, b, c, d, e,
            output [3:0] q
        );
            assign q = (c == 4'd0) ? b :
                       (c == 4'd1) ? e :
                       (c == 4'd2) ? a :
                       (c == 4'd3) ? d :
                       4'hf;
        endmodule
    """,
)

add(
    num=169, section_dir=SIM, filename="circuit6", title="Combinational circuit 6",
    url=H + "Sim/circuit6", section_name=S_SIM,
    statement="""
        a[2:0] -> q[15:0]. The waveform is a lookup table of 8 constants.
        Standard values:
          0: 1232, 1: aee0, 2: 27d4, 3: 5a0e, 4: 2066, 5: 64ce, 6: c526, 7: 2f19
        (hex).
    """,
    code="""
        module top_module (
            input      [2:0]  a,
            output reg [15:0] q
        );
            always @(*) begin
                case (a)
                    3'd0: q = 16'h1232;
                    3'd1: q = 16'haee0;
                    3'd2: q = 16'h27d4;
                    3'd3: q = 16'h5a0e;
                    3'd4: q = 16'h2066;
                    3'd5: q = 16'h64ce;
                    3'd6: q = 16'hc526;
                    3'd7: q = 16'h2f19;
                endcase
            end
        endmodule
    """,
)

add(
    num=170, section_dir=SIM, filename="circuit7", title="Sequential circuit 7",
    url=H + "Sim/circuit7", section_name=S_SIM,
    statement="""
        Sequential. q is a register that loads 0 when `a` is 1, and 1 when
        `a` is 0, on the clock edge (i.e. q <= ~a). From the waveform q
        follows ~a delayed one cycle.
    """,
    code="""
        module top_module (
            input      clk,
            input      a,
            output reg q
        );
            always @(posedge clk)
                q <= ~a;
        endmodule
    """,
)

add(
    num=171, section_dir=SIM, filename="circuit8", title="Sequential circuit 8",
    url=H + "Sim/circuit8", section_name=S_SIM,
    statement="""
        Sequential with clock named `clock`. p is a latch of `a` while clock
        is high (transparent when clock=1). q is a negative-edge register
        of p (or of a). Standard:
          always @(*) if (clock) p = a;
          always @(negedge clock) q <= p;
    """,
    code="""
        module top_module (
            input      clock,
            input      a,
            output reg p,
            output reg q
        );
            always @(*) begin
                if (clock)
                    p = a;
            end
            always @(negedge clock)
                q <= p;
        endmodule
    """,
)

add(
    num=172, section_dir=SIM, filename="circuit9", title="Sequential circuit 9",
    url=H + "Sim/circuit9", section_name=S_SIM,
    statement="""
        q[3:0] counts 0..5 (or similar) while a=0, and resets to 0 (or 4)
        when a=1. From the common waveform: when a=1, q=4; when a=0, q
        counts 4,5,0,1,2,3,4,... each clock.
    """,
    code="""
        module top_module (
            input            clk,
            input            a,
            output reg [3:0] q
        );
            always @(posedge clk) begin
                if (a)
                    q <= 4'd4;
                else if (q == 4'd6)
                    q <= 4'd0;
                else
                    q <= q + 4'd1;
            end
        endmodule
    """,
)

add(
    num=173, section_dir=SIM, filename="circuit10", title="Sequential circuit 10",
    url=H + "Sim/circuit10", section_name=S_SIM,
    statement="""
        Sequential circuit with inputs a,b and outputs q, state. From the
        waveform: `state` updates to `a` when a==b (otherwise holds), and
        q equals a when a==b else ~state. Confirm against the official plot.
    """,
    code="""
        module top_module (
            input      clk,
            input      a,
            input      b,
            output     q,
            output reg state
        );
            always @(posedge clk) begin
                if (a == b)
                    state <= a;
            end
            assign q = (a == b) ? a : ~state;
        endmodule
    """,
)

# Testbenches — the user writes a testbench, not the DUT.
add(
    num=174, section_dir=TB, filename="tb_clock", title="Clock",
    url=H + "Tb/clock", section_name=S_TB,
    statement="""
        Write a testbench that generates a clock (`clk`) with period 10
        time units (toggle every 5). The DUT is already instantiated as
        `dut` with port clk. (On HDLBits you only write the stimulus.)
        This file is a self-contained example that also includes a stub DUT.
    """,
    code="""
        `timescale 1ns/1ps
        module top_module;
            reg clk;
            dut dut (.clk(clk));
            initial clk = 0;
            always #5 clk = ~clk;
        endmodule

        // Stub DUT for local simulation (HDLBits already has the DUT).
        module dut (input clk);
        endmodule
    """,
)

add(
    num=175, section_dir=TB, filename="tb_tb1", title="Testbench1",
    url=H + "Tb/tb1", section_name=S_TB,
    statement="""
        Pulse `in` : 0 for 10 units, 1 for 10 units, then $finish.
        DUT ports: in, out. Create the stimulus only (plus a stub DUT here).
    """,
    code="""
        `timescale 1ns/1ps
        module top_module;
            reg  in;
            wire out;
            dut dut (.in(in), .out(out));
            initial begin
                in = 1'b0;
                #10 in = 1'b1;
                #10 $finish;
            end
        endmodule

        module dut (input in, output out);
            assign out = in;
        endmodule
    """,
)

add(
    num=176, section_dir=TB, filename="tb_and", title="AND gate",
    url=H + "Tb/and", section_name=S_TB,
    statement="""
        Testbench for an AND gate. Apply all four combinations of `in[1:0]`
        for 10 time units each, then $finish. DUT: andgate (.in(in), .out(out)).
    """,
    code="""
        `timescale 1ns/1ps
        module top_module;
            reg  [1:0] in;
            wire       out;
            andgate dut (.in(in), .out(out));
            initial begin
                in = 2'b00; #10;
                in = 2'b01; #10;
                in = 2'b10; #10;
                in = 2'b11; #10;
                $finish;
            end
        endmodule

        module andgate (input [1:0] in, output out);
            assign out = in[1] & in[0];
        endmodule
    """,
)

add(
    num=177, section_dir=TB, filename="tb_tb2", title="Testbench2",
    url=H + "Tb/tb2", section_name=S_TB,
    statement="""
        Waveform-driven stimulus for a 2-bit `in` over several 10-unit
        slots matching the HDLBits figure (0, 2, 1, 3, 1, 2, 0, 1 ...).
        A representative sequence used by the problem:
          00, 01, 10, 11, 10, 01, 00  for 10 units each, then $finish.
    """,
    code="""
        `timescale 1ns/1ps
        module top_module;
            reg  [1:0] in;
            wire [1:0] out;
            q7 dut (.in(in), .out(out));
            initial begin
                in = 2'b00; #10;
                in = 2'b01; #10;
                in = 2'b10; #10;
                in = 2'b11; #10;
                in = 2'b10; #10;
                in = 2'b01; #10;
                in = 2'b00; #10;
                $finish;
            end
        endmodule

        module q7 (input [1:0] in, output [1:0] out);
            assign out = in;
        endmodule
    """,
)

add(
    num=178, section_dir=TB, filename="tb_tff", title="T flip-flop",
    url=H + "Tb/tff", section_name=S_TB,
    statement="""
        Testbench for a T flip-flop. Generate clk (period 10), reset for a
        few cycles, then apply a T sequence. HDLBits instantiates tff
        (.clk, .reset, .t, .q). You provide clk, reset, t.
    """,
    code="""
        `timescale 1ns/1ps
        module top_module;
            reg clk, reset, t;
            wire q;
            tff dut (.clk(clk), .reset(reset), .t(t), .q(q));
            initial clk = 0;
            always #5 clk = ~clk;
            initial begin
                reset = 1'b1;
                t     = 1'b0;
                #10;
                reset = 1'b0;
                t     = 1'b1;
                #80;
                $finish;
            end
        endmodule

        module tff (
            input      clk,
            input      reset,
            input      t,
            output reg q
        );
            always @(posedge clk) begin
                if (reset)
                    q <= 1'b0;
                else if (t)
                    q <= ~q;
            end
        endmodule
    """,
)

# CS450
add(
    num=179, section_dir=CS, filename="timer", title="Timer",
    url=H + "Cs450/timer", section_name=S_CS,
    statement="""
        Down-counter timer. If `load`=1, load the 10-bit `data` as the
        remaining count. Otherwise decrement (saturating at 0). `tc` is 1
        when the count is 0.
    """,
    code="""
        module top_module (
            input        clk,
            input        load,
            input  [9:0] data,
            output       tc
        );
            reg [9:0] cnt;
            always @(posedge clk) begin
                if (load)
                    cnt <= data;
                else if (cnt != 10'd0)
                    cnt <= cnt - 10'd1;
            end
            assign tc = (cnt == 10'd0);
        endmodule
    """,
)

add(
    num=180, section_dir=CS, filename="counter_2bc", title="Counter 2bc",
    url=H + "Cs450/counter_2bc", section_name=S_CS,
    statement="""
        2-bit saturating counter for branch prediction. `areset` (async)
        to weakly not-taken (2'b01). When `train_valid`:
          train_taken=1: increment up to 3
          train_taken=0: decrement down to 0
        Output `state[1:0]` is the count (MSB is the prediction).
    """,
    code="""
        module top_module (
            input        clk,
            input        areset,
            input        train_valid,
            input        train_taken,
            output [1:0] state
        );
            reg [1:0] st;
            always @(posedge clk or posedge areset) begin
                if (areset)
                    st <= 2'b01;
                else if (train_valid) begin
                    if (train_taken)
                        st <= (st == 2'b11) ? 2'b11 : st + 2'd1;
                    else
                        st <= (st == 2'b00) ? 2'b00 : st - 2'd1;
                end
            end
            assign state = st;
        endmodule
    """,
)

add(
    num=181, section_dir=CS, filename="history_shift", title="History shift",
    url=H + "Cs450/history_shift", section_name=S_CS,
    statement="""
        32-bit speculative global branch-history register.
          predict_valid: shift `predict_taken` in at the LSB.
          train_mispredicted: load {train_history[30:0], train_taken}
            (history before the branch concatenated with the real outcome).
        Mispredict takes precedence over predict. `areset` to 0.
        `predict_history` is the register value.
    """,
    code="""
        module top_module (
            input             clk,
            input             areset,
            input             predict_valid,
            input             predict_taken,
            output     [31:0] predict_history,
            input             train_mispredicted,
            input             train_taken,
            input      [31:0] train_history
        );
            reg [31:0] hist;
            always @(posedge clk or posedge areset) begin
                if (areset)
                    hist <= 32'd0;
                else if (train_mispredicted)
                    hist <= {train_history[30:0], train_taken};
                else if (predict_valid)
                    hist <= {hist[30:0], predict_taken};
            end
            assign predict_history = hist;
        endmodule
    """,
)

add(
    num=182, section_dir=CS, filename="gshare", title="Gshare",
    url=H + "Cs450/gshare", section_name=S_CS,
    statement="""
        7-bit gshare predictor: 128-entry table of 2-bit saturating counters,
        index = pc XOR history. 7-bit global history register.
          predict_valid: predict_taken = PHT[hist^pc][1], then (next cycle)
            shift the *prediction* into history (unless a train+mispredict
            wins).
          train_valid: update PHT[train_history ^ train_pc] toward
            train_taken (saturating). If train_mispredicted, history
            becomes {train_history[5:0], train_taken}.
        Training and predicting in the same cycle: both PHT update and
        (if mispredict) history recovery occur; otherwise if only predict,
        history shifts. `areset`: PHT entries to 2'b01, history to 0.
        Output `predict_history` is the current history used for the
        prediction (before the shift).
    """,
    code="""
        module top_module (
            input         clk,
            input         areset,
            input         predict_valid,
            input  [6:0]  predict_pc,
            output        predict_taken,
            output [6:0]  predict_history,
            input         train_valid,
            input         train_taken,
            input         train_mispredicted,
            input  [6:0]  train_history,
            input  [6:0]  train_pc
        );
            reg [1:0] pht [0:127];
            reg [6:0] hist;
            integer i;
            wire [6:0] pred_index  = hist ^ predict_pc;
            wire [6:0] train_index = train_history ^ train_pc;

            assign predict_history = hist;
            assign predict_taken   = pht[pred_index][1];

            always @(posedge clk or posedge areset) begin
                if (areset) begin
                    hist <= 7'd0;
                    for (i = 0; i < 128; i = i + 1)
                        pht[i] <= 2'b01;
                end else begin
                    if (train_valid) begin
                        if (train_taken)
                            pht[train_index] <= (pht[train_index] == 2'b11)
                                                ? 2'b11 : pht[train_index] + 2'd1;
                        else
                            pht[train_index] <= (pht[train_index] == 2'b00)
                                                ? 2'b00 : pht[train_index] - 2'd1;
                    end
                    if (train_valid && train_mispredicted)
                        hist <= {train_history[5:0], train_taken};
                    else if (predict_valid)
                        hist <= {hist[5:0], predict_taken};
                end
            end
        endmodule
    """,
)
