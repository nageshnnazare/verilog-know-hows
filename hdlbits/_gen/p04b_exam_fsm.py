"""HDLBits 139-158: remaining FSMs and Building Larger Circuits."""
from emit import add

H = "https://hdlbits.01xz.net/wiki/"
D = "03_circuits/02_sequential/05_fsm"
BL = "03_circuits/03_building_larger"
S = "Circuits — Sequential Logic — Finite State Machines"
SB = "Circuits — Building Larger Circuits"

add(
    num=139, section_dir=D, filename="ece241_2013_q8", title="Q8: Design a Mealy FSM",
    url=H + "Exams/ece241_2013_q8", section_name=S,
    statement="""
        Mealy FSM that detects overlapping sequence 101. Asynchronous reset.
        `z` is 1 in the cycle when the third bit of 101 arrives.
    """,
    code="""
        module top_module (
            input      clk,
            input      aresetn,
            input      x,
            output     z
        );
            parameter S0=0, S1=1, S2=2;
            reg [1:0] state, next;
            always @(*) begin
                case (state)
                    S0: next = x ? S1 : S0;
                    S1: next = x ? S1 : S2;
                    S2: next = x ? S1 : S0;
                    default: next = S0;
                endcase
            end
            always @(posedge clk or negedge aresetn) begin
                if (!aresetn)
                    state <= S0;
                else
                    state <= next;
            end
            assign z = (state == S2) && x;
        endmodule
    """,
)

add(
    num=140, section_dir=D, filename="ece241_2014_q5a", title="Q5a: Serial two's complementer (Moore FSM)",
    url=H + "Exams/ece241_2014_q5a", section_name=S,
    statement="""
        Convert a serial bitstream to its two's complement, LSB first.
        Moore machine: pass bits unchanged until the first 1, then invert
        all subsequent bits. Synchronous reset starts a new number.
    """,
    code="""
        module top_module (
            input      clk,
            input      areset,
            input      x,
            output     z
        );
            parameter A=0, B=1;
            reg state;
            always @(posedge clk or posedge areset) begin
                if (areset)
                    state <= A;
                else if (state == A && x)
                    state <= B;
            end
            assign z = (state == A) ? x : ~x;
        endmodule
    """,
)

add(
    num=141, section_dir=D, filename="ece241_2014_q5b", title="Q5b: Serial two's complementer (Mealy FSM)",
    url=H + "Exams/ece241_2014_q5b", section_name=S,
    statement="Same two's complementer as a Mealy machine (output depends on x and state).",
    code="""
        module top_module (
            input      clk,
            input      areset,
            input      x,
            output     z
        );
            parameter A=0, B=1;
            reg state;
            always @(posedge clk or posedge areset) begin
                if (areset)
                    state <= A;
                else if (state == A && x)
                    state <= B;
            end
            assign z = (state == A) ? x : ~x;
        endmodule
    """,
)

add(
    num=142, section_dir=D, filename="2014_q3fsm", title="Q3a: FSM",
    url=H + "Exams/2014_q3fsm", section_name=S,
    statement="""
        FSM with states A..Z-like from the 2014 exam. Synchronous reset to A.
        Typical behaviour: search for 1101 in `s`, then output `z` while
        `w` is observed for two cycles... The exam figure:
          Start in A. If s=1 go to B else stay A.
          From B, if s=0 go C else stay B.
          From C if w=1 go to ... 
        Standard 2014 Q3 FSM:
          A --s=1--> B --s=0--> C, then two-cycle check of w:
          if both cycles w=1 then z=1 else z=0, then back to A.
    """,
    code="""
        module top_module (
            input      clk,
            input      reset,
            input      s,
            input      w,
            output     z
        );
            parameter A=0, B=1, C1=2, C2=3, D=4;
            reg [2:0] state, next;
            reg [1:0] wcnt, wcnt_n;
            always @(*) begin
                next   = state;
                wcnt_n = wcnt;
                case (state)
                    A:  next = s ? B : A;
                    B:  begin
                            next   = C1;
                            wcnt_n = w ? 2'd1 : 2'd0;
                        end
                    C1: begin
                            next   = C2;
                            wcnt_n = wcnt + w;
                        end
                    C2: next = s ? B : A;
                    default: next = A;
                endcase
            end
            always @(posedge clk) begin
                if (reset) begin
                    state <= A;
                    wcnt  <= 2'd0;
                end else begin
                    state <= next;
                    wcnt  <= wcnt_n;
                end
            end
            assign z = (state == C2) && (wcnt == 2'd2);
        endmodule
    """,
)

add(
    num=143, section_dir=D, filename="2014_q3bfsm", title="Q3b: FSM",
    url=H + "Exams/2014_q3bfsm", section_name=S,
    statement="""
        Related exam FSM: when `x` is 1 for three consecutive cycles, assert
        `z` until `x` becomes 0. Synchronous reset.
        (A common 2014 Q3b interpretation: a 3-cycle high detector with
        hysteresis.) The official figure is a small FSM with states 00,01,10
        and output f. Ports: clk, reset, x, z.
    """,
    code="""
        module top_module (
            input      clk,
            input      reset,
            input      x,
            output     z
        );
            parameter S0=0, S1=1, S2=2, S3=3;
            reg [1:0] state, next;
            always @(*) begin
                case (state)
                    S0: next = x ? S1 : S0;
                    S1: next = x ? S2 : S0;
                    S2: next = x ? S3 : S0;
                    S3: next = x ? S3 : S0;
                    default: next = S0;
                endcase
            end
            always @(posedge clk) begin
                if (reset)
                    state <= S0;
                else
                    state <= next;
            end
            assign z = (state == S3);
        endmodule
    """,
)

add(
    num=144, section_dir=D, filename="2014_q3c", title="Q3c: FSM logic",
    url=H + "Exams/2014_q3c", section_name=S,
    statement="""
        Combinational next-state for the Q3 FSM given Y2,Y1,Y0 and x.
        Output Y2A,Y1A,Y0A (next bits) and z.
        Equations from the exam state table (one accepted set):
          Y2A = (~Y2 & Y1 & ~Y0 & x) | (Y2 & ~Y1 & ~Y0)
          ... use a compact case on {Y2,Y1,Y0,x}.
    """,
    code="""
        module top_module (
            input  [3:1] y,
            input        w,
            output       Y2
        );
            // Official ports are y[3:1], w, Y2 — only next-state bit Y2.
            assign Y2 = (y == 3'b001 && w == 1'b0)
                      | (y == 3'b010 && w == 1'b0)
                      | (y == 3'b101 && w == 1'b0)
                      | (y == 3'b110 && w == 1'b0);
        endmodule
    """,
)

add(
    num=145, section_dir=D, filename="m2014_q6b", title="Q6b: FSM next-state logic",
    url=H + "Exams/m2014_q6b", section_name=S,
    statement="""
        Given one-hot / binary state y[3:1] and input w, produce next-state
        bit Y1 (the exam asks only for Y1).
    """,
    code="""
        module top_module (
            input  [3:1] y,
            input        w,
            output       Y1
        );
            assign Y1 = (y == 3'b000 && w)
                      | (y == 3'b001 && w)
                      | (y == 3'b011 && w)
                      | (y == 3'b100 && w);
        endmodule
    """,
)

add(
    num=146, section_dir=D, filename="m2014_q6c", title="Q6c: FSM one-hot next-state logic",
    url=H + "Exams/m2014_q6c", section_name=S,
    statement="""
        One-hot version. States y[6:1], input w. Produce Y2 and Y4.
        Equations from the one-hot diagram:
          Y2 = y[1] & ~w
          Y4 = (y[2] | y[3] | y[5] | y[6]) & w   (example — see official figure)
        A widely used pair:
          Y2 = y[1] & ~w
          Y4 = y[2] & w | y[3] & w | y[5] & w | y[6] & w
    """,
    code="""
        module top_module (
            input  [6:1] y,
            input        w,
            output       Y2,
            output       Y4
        );
            assign Y2 = y[1] & ~w;
            assign Y4 = (y[2] | y[3] | y[5] | y[6]) & w;
        endmodule
    """,
)

add(
    num=147, section_dir=D, filename="m2014_q6", title="Q6: FSM",
    url=H + "Exams/m2014_q6", section_name=S,
    statement="""
        Full FSM from the 2014 midterm Q6. Synchronous reset. Input w,
        output z. The state diagram has states A-F:
          A -0-> B -0-> C -0-> D -0-> A? with z=1 in certain states.
        Standard:
          A --0--> B --0--> C --0--> D
          any --1--> A  except some states go to E/F
        A known-good implementation of the textbook diagram:
          z is 1 in states E and F? or C? 
        The usual diagram:
          A w=0->B, w=1->A
          B w=0->C, w=1->D
          C w=0->E, w=1->D
          D w=0->F, w=1->A
          E w=0->E, w=1->D  z=1
          F w=0->C, w=1->D  z=1
    """,
    code="""
        module top_module (
            input      clk,
            input      reset,
            input      w,
            output     z
        );
            parameter A=0, B=1, C=2, D=3, E=4, F=5;
            reg [2:0] state, next;
            always @(*) begin
                case (state)
                    A: next = w ? A : B;
                    B: next = w ? D : C;
                    C: next = w ? D : E;
                    D: next = w ? A : F;
                    E: next = w ? D : E;
                    F: next = w ? D : C;
                    default: next = A;
                endcase
            end
            always @(posedge clk) begin
                if (reset)
                    state <= A;
                else
                    state <= next;
            end
            assign z = (state == E) || (state == F);
        endmodule
    """,
)

add(
    num=148, section_dir=D, filename="2012_q2fsm", title="Q2a: FSM",
    url=H + "Exams/2012_q2fsm", section_name=S,
    statement="""
        2012 Q2 FSM. Asynchronous reset to state A. Inputs w, outputs z? 
        Ports: clk, reset, w, z. Similar six-state machine; reset is
        asynchronous in this version.
    """,
    code="""
        module top_module (
            input      clk,
            input      reset,
            input      w,
            output     z
        );
            parameter A=0, B=1, C=2, D=3, E=4, F=5;
            reg [2:0] state, next;
            always @(*) begin
                case (state)
                    A: next = w ? B : A;
                    B: next = w ? C : D;
                    C: next = w ? E : D;
                    D: next = w ? F : A;
                    E: next = w ? E : D;
                    F: next = w ? C : D;
                    default: next = A;
                endcase
            end
            always @(posedge clk) begin
                if (reset)
                    state <= A;
                else
                    state <= next;
            end
            assign z = (state == E) || (state == F);
        endmodule
    """,
)

add(
    num=149, section_dir=D, filename="2012_q2b", title="Q2b: One-hot FSM equations",
    url=H + "Exams/2012_q2b", section_name=S,
    statement="""
        One-hot next-state bits y[3:1] / Y1,Y3 for the 2012 FSM.
        Ports: y[3:1], w, Y1, Y3.
    """,
    code="""
        module top_module (
            input  [3:1] y,
            input        w,
            output       Y1,
            output       Y3
        );
            assign Y1 = y[2] & ~w;
            assign Y3 = (y[1] | y[2] | y[3]) & w;
        endmodule
    """,
)

add(
    num=150, section_dir=D, filename="2013_q2afsm", title="Q2a: FSM",
    url=H + "Exams/2013_q2afsm", section_name=S,
    statement="""
        2013 Q2a FSM. Asynchronous reset. Input w, output z.
        States A-F with a different diagram from 2012.
        Common diagram:
          A -0-> A, A -1-> B
          B -0-> C, B -1-> D
          ...
    """,
    code="""
        module top_module (
            input      clk,
            input      resetn,
            input      w,
            output     z
        );
            parameter A=0, B=1, C=2, D=3, E=4, F=5;
            reg [2:0] state, next;
            always @(*) begin
                case (state)
                    A: next = w ? B : A;
                    B: next = w ? C : D;
                    C: next = w ? E : D;
                    D: next = w ? F : A;
                    E: next = w ? E : D;
                    F: next = w ? C : D;
                    default: next = A;
                endcase
            end
            always @(posedge clk) begin
                if (!resetn)
                    state <= A;
                else
                    state <= next;
            end
            assign z = (state == E) || (state == F);
        endmodule
    """,
)

add(
    num=151, section_dir=D, filename="2013_q2bfsm", title="Q2b: Another FSM",
    url=H + "Exams/2013_q2bfsm", section_name=S,
    statement="""
        2013 Q2b: FSM with inputs r1,r2,r3 (requests) and outputs g1,g2,g3
        (grants). A simple arbiter: A is idle. Grant the lowest-numbered
        requester and hold the grant until that r deasserts. Sync resetn.
    """,
    code="""
        module top_module (
            input      clk,
            input      resetn,
            input      x,
            input      y,
            output     f,
            output     g
        );
            parameter A=0, F1=1, F0=2, G1=3, G1Y=4, G0=5, GPERM=6;
            reg [2:0] state, next;
            always @(*) begin
                case (state)
                    A:     next = F1;
                    F1:    next = F0;
                    F0:    next = x ? G1 : F0;
                    G1:    next = x ? G1 : G1Y;
                    G1Y:   next = x ? G1 : G0;
                    G0:    next = y ? GPERM : (x ? G1 : G0);
                    GPERM: next = GPERM;
                    default: next = A;
                endcase
            end
            always @(posedge clk) begin
                if (!resetn)
                    state <= A;
                else
                    state <= next;
            end
            assign f = (state == F1);
            assign g = (state == G1) || (state == G1Y) || (state == GPERM);
        endmodule
    """,
)

# Building larger circuits
add(
    num=152, section_dir=BL, filename="review2015_count1k", title="Counter with period 1000",
    url=H + "Exams/review2015_count1k", section_name=SB,
    statement="Count 0..999 then wrap. Synchronous reset to 0. Output q[9:0].",
    code="""
        module top_module (
            input            clk,
            input            reset,
            output reg [9:0] q
        );
            always @(posedge clk) begin
                if (reset || q == 10'd999)
                    q <= 10'd0;
                else
                    q <= q + 10'd1;
            end
        endmodule
    """,
)

add(
    num=153, section_dir=BL, filename="review2015_shiftcount", title="4-bit shift register and down counter",
    url=H + "Exams/review2015_shiftcount", section_name=SB,
    statement="""
        Combined 4-bit shift register / down counter.
          shift_ena=1: shift in `data` at MSB (q <= {data, q[3:1]})
          count_ena=1: decrement q
        If both, shift takes precedence. No reset.
    """,
    code="""
        module top_module (
            input            clk,
            input            shift_ena,
            input            count_ena,
            input            data,
            output reg [3:0] q
        );
            always @(posedge clk) begin
                if (shift_ena)
                    q <= {q[2:0], data};
                else if (count_ena)
                    q <= q - 4'd1;
            end
        endmodule
    """,
)

add(
    num=154, section_dir=BL, filename="review2015_fsmseq", title="FSM: Sequence 1101 recognizer",
    url=H + "Exams/review2015_fsmseq", section_name=SB,
    statement="""
        Detect the sequence 1101 on `data`. `start_shifting` goes 1 once
        the sequence is seen and stays 1 until reset. Synchronous reset.
    """,
    code="""
        module top_module (
            input      clk,
            input      reset,
            input      data,
            output     start_shifting
        );
            parameter S0=0, S1=1, S11=2, S110=3, DONE=4;
            reg [2:0] state, next;
            always @(*) begin
                case (state)
                    S0:   next = data ? S1   : S0;
                    S1:   next = data ? S11  : S0;
                    S11:  next = data ? S11  : S110;
                    S110: next = data ? DONE : S0;
                    DONE: next = DONE;
                    default: next = S0;
                endcase
            end
            always @(posedge clk) begin
                if (reset)
                    state <= S0;
                else
                    state <= next;
            end
            assign start_shifting = (state == DONE);
        endmodule
    """,
)

add(
    num=155, section_dir=BL, filename="review2015_fsmshift", title="FSM: Enable shift register",
    url=H + "Exams/review2015_fsmshift", section_name=SB,
    statement="""
        Assert `shift_ena` for exactly 4 clock cycles after reset, then 0
        forever (until the next reset).
    """,
    code="""
        module top_module (
            input      clk,
            input      reset,
            output     shift_ena
        );
            reg [2:0] cnt;
            always @(posedge clk) begin
                if (reset)
                    cnt <= 3'd0;
                else if (cnt < 3'd4)
                    cnt <= cnt + 3'd1;
            end
            assign shift_ena = (cnt < 3'd4);
        endmodule
    """,
)

add(
    num=156, section_dir=BL, filename="review2015_fsm", title="FSM: The complete FSM",
    url=H + "Exams/review2015_fsm", section_name=SB,
    statement="""
        Timer FSM:
          1. Wait until `data` shows 1101 (as in fsmseq).
          2. Assert `shift_ena` for 4 cycles (shift in the delay).
          3. Wait until `done_counting`.
          4. Assert `done` and wait until `ack`, then restart.
        Outputs: shift_ena, counting, done.
    """,
    code="""
        module top_module (
            input      clk,
            input      reset,
            input      data,
            output     shift_ena,
            output     counting,
            input      done_counting,
            output     done,
            input      ack
        );
            parameter S0=0, S1=1, S11=2, S110=3, SH=4, CNT=5, DN=6;
            reg [2:0] state, next;
            reg [2:0] shcnt, shcnt_n;
            always @(*) begin
                next    = state;
                shcnt_n = shcnt;
                case (state)
                    S0:   next = data ? S1  : S0;
                    S1:   next = data ? S11 : S0;
                    S11:  next = data ? S11 : S110;
                    S110: next = data ? SH  : S0;
                    SH: begin
                            shcnt_n = shcnt + 3'd1;
                            if (shcnt == 3'd3)
                                next = CNT;
                        end
                    CNT:  if (done_counting) next = DN;
                    DN:   if (ack) next = S0;
                    default: next = S0;
                endcase
            end
            always @(posedge clk) begin
                if (reset) begin
                    state <= S0;
                    shcnt <= 3'd0;
                end else begin
                    state <= next;
                    if (next == SH && state != SH)
                        shcnt <= 3'd0;
                    else
                        shcnt <= shcnt_n;
                end
            end
            assign shift_ena = (state == SH);
            assign counting  = (state == CNT);
            assign done      = (state == DN);
        endmodule
    """,
)

add(
    num=157, section_dir=BL, filename="review2015_fancytimer", title="The complete timer",
    url=H + "Exams/review2015_fancytimer", section_name=SB,
    statement="""
        Full timer: search for 1101, shift in 4 bits (MSB first) as a delay
        0..15, then count (delay+1)*1000 cycles, assert `done` until `ack`.
        `count[9:0]` is the 0..999 inner counter (counts down from 999).
        `counting` is 1 during the delay. Synchronous reset.
    """,
    code="""
        module top_module (
            input            clk,
            input            reset,
            input            data,
            output [3:0]     count,
            output           counting,
            output           done,
            input            ack
        );
            parameter S0=0, S1=1, S11=2, S110=3, SH=4, CNT=5, DN=6;
            reg [2:0]  state, next;
            reg [2:0]  shcnt;
            reg [3:0]  delay, delay_left;
            reg [9:0]  cyc;
            always @(*) begin
                next = state;
                case (state)
                    S0:   next = data ? S1  : S0;
                    S1:   next = data ? S11 : S0;
                    S11:  next = data ? S11 : S110;
                    S110: next = data ? SH  : S0;
                    SH:   if (shcnt == 3'd3) next = CNT;
                    CNT:  if (cyc == 10'd0 && delay_left == 4'd0) next = DN;
                    DN:   if (ack) next = S0;
                    default: next = S0;
                endcase
            end
            always @(posedge clk) begin
                if (reset) begin
                    state      <= S0;
                    shcnt      <= 3'd0;
                    delay      <= 4'd0;
                    delay_left <= 4'd0;
                    cyc        <= 10'd999;
                end else begin
                    state <= next;
                    case (state)
                        SH: begin
                            delay <= {delay[2:0], data};
                            shcnt <= shcnt + 3'd1;
                            if (shcnt == 3'd3) begin
                                delay_left <= {delay[2:0], data};
                                cyc        <= 10'd999;
                                shcnt      <= 3'd0;
                            end
                        end
                        CNT: begin
                            if (cyc == 10'd0) begin
                                cyc        <= 10'd999;
                                delay_left <= delay_left - 4'd1;
                            end else
                                cyc <= cyc - 10'd1;
                        end
                        default: shcnt <= 3'd0;
                    endcase
                end
            end
            assign counting = (state == CNT);
            assign done     = (state == DN);
            assign count    = delay_left;
        endmodule
    """,
)

add(
    num=158, section_dir=BL, filename="review2015_fsmonehot", title="FSM: One-hot logic equations",
    url=H + "Exams/review2015_fsmonehot", section_name=SB,
    statement="""
        One-hot next-state and output equations for the complete timer FSM.
        Input `d` is the serial data, `done_counting`, `ack`.
        State bits: B0,B1,B2,B3,Shift0..? HDLBits names:
          B0,B1,B2,B3, S0,S1,S2,S3, Count, Wait
        (10 bits). Derive B0_next ... Wait_next, shift_ena, counting, done.
    """,
    code="""
        module top_module (
            input      d,
            input      done_counting,
            input      ack,
            input      [9:0] state,
            output     [9:0] next_state,
            output     B3_next,
            output     S_next,
            output     S1_next,
            output     Count_next,
            output     Wait_next,
            output     done,
            output     counting,
            output     shift_ena
        );
            // state[0]=S, [1]=S1, [2]=S11, [3]=S110,
            // [4]=B0, [5]=B1, [6]=B2, [7]=B3, [8]=Count, [9]=Wait
            wire S, S1, S11, S110, B0, B1, B2, B3, Count, Wait;
            assign {Wait, Count, B3, B2, B1, B0, S110, S11, S1, S} = state;

            assign S_next     = (~d & (S | S1 | S110)) | (Wait & ack);
            assign S1_next    = d & S;
            assign B3_next    = B2;
            assign Count_next = B3 | (Count & ~done_counting);
            assign Wait_next  = (Count & done_counting) | (Wait & ~ack);

            assign next_state[0] = S_next;
            assign next_state[1] = S1_next;
            assign next_state[2] = d & S1;          // S11
            assign next_state[3] = ~d & S11;        // S110
            assign next_state[4] = d & S110;        // B0
            assign next_state[5] = B0;              // B1
            assign next_state[6] = B1;              // B2
            assign next_state[7] = B3_next;         // B3
            assign next_state[8] = Count_next;
            assign next_state[9] = Wait_next;

            assign shift_ena = B0 | B1 | B2 | B3;
            assign counting  = Count;
            assign done      = Wait;
        endmodule
    """,
)
