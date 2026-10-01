"""HDLBits 119-151: Finite state machines."""
from emit import add

H = "https://hdlbits.01xz.net/wiki/"
D = "03_circuits/02_sequential/05_fsm"
S = "Circuits — Sequential Logic — Finite State Machines"

add(
    num=119, section_dir=D, filename="fsm1", title="Simple FSM 1 (asynchronous reset)",
    url=H + "Fsm1", section_name=S,
    statement="""
        Two-state Moore FSM. States A (out=0) and B (out=1). Asynchronous
        reset to B. Input `in`: if 1 stay; if 0 go to the other state.
    """,
    code="""
        module top_module (
            input      clk,
            input      areset,
            input      in,
            output     out
        );
            parameter A = 1'b0, B = 1'b1;
            reg state, next;
            always @(*) begin
                case (state)
                    A: next = in ? A : B;
                    B: next = in ? B : A;
                endcase
            end
            always @(posedge clk or posedge areset) begin
                if (areset)
                    state <= B;
                else
                    state <= next;
            end
            assign out = (state == B);
        endmodule
    """,
)

add(
    num=120, section_dir=D, filename="fsm1s", title="Simple FSM 1 (synchronous reset)",
    url=H + "Fsm1s", section_name=S,
    statement="Same as fsm1 but the reset is synchronous (and named `reset`).",
    code="""
        module top_module (
            input      clk,
            input      reset,
            input      in,
            output     out
        );
            parameter A = 1'b0, B = 1'b1;
            reg state, next;
            always @(*) begin
                case (state)
                    A: next = in ? A : B;
                    B: next = in ? B : A;
                endcase
            end
            always @(posedge clk) begin
                if (reset)
                    state <= B;
                else
                    state <= next;
            end
            assign out = (state == B);
        endmodule
    """,
)

add(
    num=121, section_dir=D, filename="fsm2", title="Simple FSM 2 (asynchronous reset)",
    url=H + "Fsm2", section_name=S,
    statement="""
        Two-state Moore FSM. Reset (async) to OFF (out=0).
          OFF: out=0; in=0 stay, in=1 go ON
          ON : out=1; in=1 stay, in=0 go OFF
    """,
    code="""
        module top_module (
            input      clk,
            input      areset,
            input      j,
            input      k,
            output     out
        );
            parameter OFF = 1'b0, ON = 1'b1;
            reg state, next;
            always @(*) begin
                case (state)
                    OFF: next = j ? ON  : OFF;
                    ON : next = k ? OFF : ON;
                endcase
            end
            always @(posedge clk or posedge areset) begin
                if (areset)
                    state <= OFF;
                else
                    state <= next;
            end
            assign out = (state == ON);
        endmodule
    """,
)

add(
    num=122, section_dir=D, filename="fsm2s", title="Simple FSM 2 (synchronous reset)",
    url=H + "Fsm2s", section_name=S,
    statement="Same as fsm2 with synchronous reset. Ports are clk, reset, j, k, out.",
    code="""
        module top_module (
            input      clk,
            input      reset,
            input      j,
            input      k,
            output     out
        );
            parameter OFF = 1'b0, ON = 1'b1;
            reg state, next;
            always @(*) begin
                case (state)
                    OFF: next = j ? ON  : OFF;
                    ON : next = k ? OFF : ON;
                endcase
            end
            always @(posedge clk) begin
                if (reset)
                    state <= OFF;
                else
                    state <= next;
            end
            assign out = (state == ON);
        endmodule
    """,
)

add(
    num=123, section_dir=D, filename="fsm3comb", title="Simple state transitions 3",
    url=H + "Fsm3comb", section_name=S,
    statement="""
        Combinational next-state and output logic for a 4-state FSM
        (A=00,B=01,C=10,D=11):
          A --1--> B --1--> B
          A --0--> A
          B --0--> C --0--> A
          C --1--> D --1--> B
          D --0--> C
        Moore output is 1 only in D.
    """,
    code="""
        module top_module (
            input        in,
            input  [1:0] state,
            output reg [1:0] next_state,
            output       out
        );
            parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;
            always @(*) begin
                case (state)
                    A: next_state = in ? B : A;
                    B: next_state = in ? B : C;
                    C: next_state = in ? D : A;
                    D: next_state = in ? B : C;
                    default: next_state = A;
                endcase
            end
            assign out = (state == D);
        endmodule
    """,
)

add(
    num=124, section_dir=D, filename="fsm3onehot", title="Simple one-hot state transitions 3",
    url=H + "Fsm3onehot", section_name=S,
    statement="""
        Same 4-state FSM as fsm3comb, but state and next_state are one-hot
        [3:0] = {D,C,B,A}. Derive next-state bits as Boolean equations
        (no case on the whole state vector). out1 is Moore (state D),
        out2 is Mealy (state C or D and in=1? HDLBits has out1, out2):
        Standard: out1 = state[3] | state[2] & in? 
        HDLBits fsm3onehot: only `out` which is 1 in D: out = state[3]
        Wait, ports are: in, [3:0] state, [3:0] next_state, out
        out = state[3]
        next_state[0] = ~in & (state[0]|state[2]);
        next_state[1] = in & (state[0]|state[1]|state[3]);
        next_state[2] = ~in & (state[1]|state[3]);
        next_state[3] = in & state[2];
    """,
    code="""
        module top_module (
            input        in,
            input  [3:0] state,
            output [3:0] next_state,
            output       out
        );
            assign next_state[0] = ~in & (state[0] | state[2]);
            assign next_state[1] =  in & (state[0] | state[1] | state[3]);
            assign next_state[2] = ~in & (state[1] | state[3]);
            assign next_state[3] =  in &  state[2];
            assign out = state[3];
        endmodule
    """,
)

add(
    num=125, section_dir=D, filename="fsm3", title="Simple FSM 3 (asynchronous reset)",
    url=H + "Fsm3", section_name=S,
    statement="The full 4-state FSM of fsm3comb, with asynchronous reset to A.",
    code="""
        module top_module (
            input        clk,
            input        in,
            input        areset,
            output       out
        );
            parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;
            reg [1:0] state, next;
            always @(*) begin
                case (state)
                    A: next = in ? B : A;
                    B: next = in ? B : C;
                    C: next = in ? D : A;
                    D: next = in ? B : C;
                    default: next = A;
                endcase
            end
            always @(posedge clk or posedge areset) begin
                if (areset)
                    state <= A;
                else
                    state <= next;
            end
            assign out = (state == D);
        endmodule
    """,
)

add(
    num=126, section_dir=D, filename="fsm3s", title="Simple FSM 3 (synchronous reset)",
    url=H + "Fsm3s", section_name=S,
    statement="Same 4-state FSM with synchronous reset to A.",
    code="""
        module top_module (
            input        clk,
            input        in,
            input        reset,
            output       out
        );
            parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;
            reg [1:0] state, next;
            always @(*) begin
                case (state)
                    A: next = in ? B : A;
                    B: next = in ? B : C;
                    C: next = in ? D : A;
                    D: next = in ? B : C;
                    default: next = A;
                endcase
            end
            always @(posedge clk) begin
                if (reset)
                    state <= A;
                else
                    state <= next;
            end
            assign out = (state == D);
        endmodule
    """,
)

add(
    num=127, section_dir=D, filename="ece241_2013_q4", title="Design a Moore FSM",
    url=H + "Exams/ece241_2013_q4", section_name=S,
    statement="""
        Water-level controller. Sensors s[2:0] (s[0] bottom, s[2] top) are 1
        when water is above that sensor (and sensors below are also 1).
        Outputs fr1,fr2,fr3 are flow-rate valves (1=open). dfr is a faster
        extra valve asserted when the previous level was lower than now
        (water is rising) except immediately after reset.
        Reset (async): all fr on, dfr off, as if the tank were empty.
          above s2: all fr off
          between s1 and s2: fr1
          between s0 and s1: fr1+fr2
          below s0: fr1+fr2+fr3
    """,
    code="""
        module top_module (
            input        clk,
            input        reset,
            input  [2:0] s,
            output       fr3,
            output       fr2,
            output       fr1,
            output       dfr
        );
            parameter A = 2'd0, B = 2'd1, C = 2'd2, D = 2'd3;
            reg [1:0] state, next, prev;
            always @(*) begin
                case (s)
                    3'b000: next = A;
                    3'b001: next = B;
                    3'b011: next = C;
                    3'b111: next = D;
                    default: next = state;
                endcase
            end
            always @(posedge clk) begin
                if (reset) begin
                    state <= A;
                    prev  <= A;
                end else begin
                    prev  <= state;
                    state <= next;
                end
            end
            assign fr1 = (state != D);
            assign fr2 = (state == A) || (state == B);
            assign fr3 = (state == A);
            assign dfr = (state > prev);
        endmodule
    """,
)

add(
    num=128, section_dir=D, filename="lemmings1", title="Lemmings 1",
    url=H + "Lemmings1", section_name=S,
    statement="""
        A walking lemming. Exactly one of `walk_left` / `walk_right` is 1
        while on ground. `bump_left` / `bump_right` reverse direction
        (both bumps also reverse). `ground`=0 means falling: both walk
        outputs are 0; resume the previous direction when ground returns.
        Asynchronous reset: walk left. (Lemmings 1 has no `aaah` port.)
    """,
    code="""
        module top_module (
            input      clk,
            input      areset,
            input      bump_left,
            input      bump_right,
            input      ground,
            output     walk_left,
            output     walk_right
        );
            parameter LEFT = 1'b0, RIGHT = 1'b1;
            parameter WALK = 1'b0, FALL = 1'b1;
            reg dir, next_dir;
            reg mode, next_mode;
            always @(*) begin
                next_dir  = dir;
                next_mode = ground ? WALK : FALL;
                if (ground && mode == WALK) begin
                    if (bump_left && bump_right)
                        next_dir = ~dir;
                    else if (bump_left)
                        next_dir = RIGHT;
                    else if (bump_right)
                        next_dir = LEFT;
                end
            end
            always @(posedge clk or posedge areset) begin
                if (areset) begin
                    dir  <= LEFT;
                    mode <= WALK;
                end else begin
                    dir  <= next_dir;
                    mode <= next_mode;
                end
            end
            assign walk_left  = (mode == WALK) && (dir == LEFT);
            assign walk_right = (mode == WALK) && (dir == RIGHT);
        endmodule
    """,
)

add(
    num=129, section_dir=D, filename="lemmings2", title="Lemmings 2",
    url=H + "Lemmings2", section_name=S,
    statement="Lemmings 1 plus `aaah` which is 1 while falling.",
    code="""
        module top_module (
            input      clk,
            input      areset,
            input      bump_left,
            input      bump_right,
            input      ground,
            output     walk_left,
            output     walk_right,
            output     aaah
        );
            parameter LEFT = 1'b0, RIGHT = 1'b1;
            parameter WALK = 1'b0, FALL = 1'b1;
            reg dir, mode;
            always @(posedge clk or posedge areset) begin
                if (areset) begin
                    dir  <= LEFT;
                    mode <= WALK;
                end else begin
                    if (!ground)
                        mode <= FALL;
                    else begin
                        mode <= WALK;
                        if (mode == WALK) begin
                            if (bump_left && bump_right)
                                dir <= ~dir;
                            else if (bump_left)
                                dir <= RIGHT;
                            else if (bump_right)
                                dir <= LEFT;
                        end
                    end
                end
            end
            assign walk_left  = (mode == WALK) && (dir == LEFT);
            assign walk_right = (mode == WALK) && (dir == RIGHT);
            assign aaah       = (mode == FALL);
        endmodule
    """,
)

add(
    num=130, section_dir=D, filename="lemmings3", title="Lemmings 3",
    url=H + "Lemmings3", section_name=S,
    statement="""
        Lemmings 2 plus digging. `dig` is requested; if on ground and not
        already falling, start digging (`digging`=1, walk=0, aaah=0) until
        ground disappears (then fall). Digging does not change direction.
        Cannot dig while falling. Bumps are ignored while digging.
    """,
    code="""
        module top_module (
            input      clk,
            input      areset,
            input      bump_left,
            input      bump_right,
            input      ground,
            input      dig,
            output     walk_left,
            output     walk_right,
            output     aaah,
            output     digging
        );
            parameter LEFT=0, RIGHT=1;
            parameter WALK=0, FALL=1, DIG=2;
            reg dir;
            reg [1:0] state;
            always @(posedge clk or posedge areset) begin
                if (areset) begin
                    dir   <= LEFT;
                    state <= WALK;
                end else begin
                    case (state)
                        WALK: begin
                            if (!ground)
                                state <= FALL;
                            else if (dig)
                                state <= DIG;
                            else if (bump_left && bump_right)
                                dir <= ~dir;
                            else if (bump_left)
                                dir <= RIGHT;
                            else if (bump_right)
                                dir <= LEFT;
                        end
                        FALL: begin
                            if (ground)
                                state <= WALK;
                        end
                        DIG: begin
                            if (!ground)
                                state <= FALL;
                        end
                    endcase
                end
            end
            assign walk_left  = (state == WALK) && (dir == LEFT);
            assign walk_right = (state == WALK) && (dir == RIGHT);
            assign aaah       = (state == FALL);
            assign digging    = (state == DIG);
        endmodule
    """,
)

add(
    num=131, section_dir=D, filename="lemmings4", title="Lemmings 4",
    url=H + "Lemmings4", section_name=S,
    statement="""
        Lemmings 3 plus splatter: if the lemming falls for more than 20
        clock cycles, then when it hits the ground it is squished
        (`walk_*`=`aaah`=`digging`=0 forever). Falling for exactly 20
        cycles is still safe.
    """,
    code="""
        module top_module (
            input      clk,
            input      areset,
            input      bump_left,
            input      bump_right,
            input      ground,
            input      dig,
            output     walk_left,
            output     walk_right,
            output     aaah,
            output     digging
        );
            parameter LEFT=0, RIGHT=1;
            parameter WALK=0, FALL=1, DIG=2, DEAD=3;
            reg dir;
            reg [1:0] state;
            reg [4:0] fall_cnt;
            always @(posedge clk or posedge areset) begin
                if (areset) begin
                    dir      <= LEFT;
                    state    <= WALK;
                    fall_cnt <= 5'd0;
                end else begin
                    case (state)
                        WALK: begin
                            fall_cnt <= 5'd0;
                            if (!ground)
                                state <= FALL;
                            else if (dig)
                                state <= DIG;
                            else if (bump_left && bump_right)
                                dir <= ~dir;
                            else if (bump_left)
                                dir <= RIGHT;
                            else if (bump_right)
                                dir <= LEFT;
                        end
                        FALL: begin
                            if (fall_cnt < 5'd21)
                                fall_cnt <= fall_cnt + 5'd1;
                            if (ground)
                                state <= (fall_cnt > 5'd20) ? DEAD : WALK;
                        end
                        DIG: begin
                            if (!ground) begin
                                state    <= FALL;
                                fall_cnt <= 5'd0;
                            end
                        end
                        DEAD: state <= DEAD;
                    endcase
                end
            end
            assign walk_left  = (state == WALK) && (dir == LEFT);
            assign walk_right = (state == WALK) && (dir == RIGHT);
            assign aaah       = (state == FALL);
            assign digging    = (state == DIG);
        endmodule
    """,
)

add(
    num=132, section_dir=D, filename="fsm_onehot", title="One-hot FSM",
    url=H + "Fsm_onehot", section_name=S,
    statement="""
        10-state one-hot FSM (`state[9:0]`). Write each `next_state` bit as a
        Boolean equation from the official diagram (no case on the whole
        vector). Moore outputs:
          out1 = state[8] | state[9]
          out2 = state[7] | state[9]
    """,
    code="""
        module top_module (
            input        in,
            input  [9:0] state,
            output [9:0] next_state,
            output       out1,
            output       out2
        );
            assign next_state[0] = ~in & (state[0]|state[1]|state[2]|state[3]|state[4]|state[7]|state[8]|state[9]);
            assign next_state[1] =  in &  state[0];
            assign next_state[2] =  in &  state[1];
            assign next_state[3] =  in &  state[2];
            assign next_state[4] =  in &  state[3];
            assign next_state[5] =  in &  state[4];
            assign next_state[6] =  in &  state[5];
            assign next_state[7] =  in & (state[6] | state[7]);
            assign next_state[8] = ~in &  state[5];
            assign next_state[9] = ~in & (state[6] | state[8]);
            assign out1 = state[8] | state[9];
            assign out2 = state[7] | state[9];
        endmodule
    """,
)

add(
    num=133, section_dir=D, filename="fsm_ps2", title="PS/2 packet parser",
    url=H + "Fsm_ps2", section_name=S,
    statement="""
        Parse a PS/2 3-byte packet. Bytes arrive in `in[7:0]` when `in[3:0]`
        of the first byte is 4'h8..4'hB (bits [3] of the first byte is 1).
        `done` is 1 for one cycle after the third byte of a valid packet.
        Synchronous reset.
    """,
    code="""
        module top_module (
            input        clk,
            input        reset,
            input  [7:0] in,
            output       done
        );
            parameter B1=0, B2=1, B3=2, DN=3;
            reg [1:0] state, next;
            always @(*) begin
                case (state)
                    B1: next = in[3] ? B2 : B1;
                    B2: next = B3;
                    B3: next = DN;
                    DN: next = in[3] ? B2 : B1;
                    default: next = B1;
                endcase
            end
            always @(posedge clk) begin
                if (reset)
                    state <= B1;
                else
                    state <= next;
            end
            assign done = (state == DN);
        endmodule
    """,
)

add(
    num=134, section_dir=D, filename="fsm_ps2data", title="PS/2 packet parser and datapath",
    url=H + "Fsm_ps2data", section_name=S,
    statement="Same parser, also capture the 24-bit packet `out_bytes` when done.",
    code="""
        module top_module (
            input             clk,
            input             reset,
            input       [7:0] in,
            output            done,
            output reg [23:0] out_bytes
        );
            parameter B1=0, B2=1, B3=2, DN=3;
            reg [1:0] state, next;
            reg [7:0] b1, b2, b3;
            always @(*) begin
                case (state)
                    B1: next = in[3] ? B2 : B1;
                    B2: next = B3;
                    B3: next = DN;
                    DN: next = in[3] ? B2 : B1;
                    default: next = B1;
                endcase
            end
            always @(posedge clk) begin
                if (reset)
                    state <= B1;
                else begin
                    state <= next;
                    if (next == B2 && (state == B1 || state == DN))
                        b1 <= in;
                    if (state == B2)
                        b2 <= in;
                    if (state == B3)
                        b3 <= in;
                end
            end
            assign done = (state == DN);
            always @(*) out_bytes = {b1, b2, b3};
        endmodule
    """,
)

add(
    num=135, section_dir=D, filename="fsm_serial", title="Serial receiver",
    url=H + "Fsm_serial", section_name=S,
    statement="""
        UART-like receiver: idle until a start bit 0, then 8 data bits
        (LSB first), then a stop bit 1. `done` is 1 for one cycle if the
        stop bit is 1. If stop is 0, wait until the line goes back to 1
        (idle) before looking for a new start bit. Synchronous reset.
    """,
    code="""
        module top_module (
            input      clk,
            input      reset,
            input      in,
            output     done
        );
            parameter IDLE=0, DATA=1, STOP=2, WAIT=3, DONE=4;
            reg [2:0] state, next;
            reg [2:0] cnt, cnt_next;
            always @(*) begin
                next     = state;
                cnt_next = cnt;
                case (state)
                    IDLE: begin
                        if (in == 1'b0) begin
                            next     = DATA;
                            cnt_next = 3'd0;
                        end
                    end
                    DATA: begin
                        if (cnt == 3'd7)
                            next = STOP;
                        cnt_next = cnt + 3'd1;
                    end
                    STOP: next = in ? DONE : WAIT;
                    WAIT: if (in) next = IDLE;
                    DONE: next = in ? IDLE : DATA;
                    default: next = IDLE;
                endcase
            end
            always @(posedge clk) begin
                if (reset) begin
                    state <= IDLE;
                    cnt   <= 3'd0;
                end else begin
                    state <= next;
                    cnt   <= cnt_next;
                end
            end
            assign done = (state == DONE);
        endmodule
    """,
)

add(
    num=136, section_dir=D, filename="fsm_serialdata", title="Serial receiver and datapath",
    url=H + "Fsm_serialdata", section_name=S,
    statement="Same serial receiver, also output the received byte `out_byte` when done.",
    code="""
        module top_module (
            input            clk,
            input            reset,
            input            in,
            output           done,
            output reg [7:0] out_byte
        );
            parameter IDLE=0, DATA=1, STOP=2, WAIT=3, DONE=4;
            reg [2:0] state, next;
            reg [2:0] bitn;
            reg [7:0] data;
            always @(*) begin
                next = state;
                case (state)
                    IDLE: if (!in) next = DATA;
                    DATA: next = (bitn == 3'd7) ? STOP : DATA;
                    STOP: next = in ? DONE : WAIT;
                    WAIT: if (in) next = IDLE;
                    DONE: next = in ? IDLE : DATA;
                    default: next = IDLE;
                endcase
            end
            always @(posedge clk) begin
                if (reset) begin
                    state <= IDLE;
                    bitn  <= 3'd0;
                end else begin
                    state <= next;
                    if (state == IDLE && next == DATA)
                        bitn <= 3'd0;
                    else if (state == DATA) begin
                        data[bitn] <= in;
                        bitn <= bitn + 3'd1;
                    end
                    if (state == DONE)
                        ;
                    if (next == DONE)
                        out_byte <= data;
                    if (state == DATA && bitn == 3'd7)
                        data[7] <= in;
                end
            end
            assign done = (state == DONE);
        endmodule
    """,
)

add(
    num=137, section_dir=D, filename="fsm_serialdp", title="Serial receiver with parity checking",
    url=H + "Fsm_serialdp", section_name=S,
    statement="""
        Serial receiver with odd parity. After 8 data bits comes a parity bit,
        then a stop bit. `done` only if stop=1 and odd parity is correct.
        You may use the provided `parity` module (odd parity of 8 bits plus
        a reset). `odd` from that module is 1 when the running parity is odd.
    """,
    code="""
        module top_module (
            input            clk,
            input            reset,
            input            in,
            output           done,
            output reg [7:0] out_byte
        );
            parameter IDLE=0, DATA=1, PAR=2, STOP=3, WAIT=4, DONE=5;
            reg [2:0] state, next;
            reg [2:0] bitn;
            reg [7:0] data;
            wire odd;
            reg par_reset;
            parity p (.clk(clk), .reset(reset | par_reset), .in(in), .odd(odd));
            always @(*) begin
                next      = state;
                par_reset = 1'b0;
                case (state)
                    IDLE: begin
                        par_reset = 1'b1;
                        if (!in) next = DATA;
                    end
                    DATA: next = (bitn == 3'd7) ? PAR : DATA;
                    PAR:  next = STOP;
                    STOP: next = in ? (odd ? DONE : IDLE) : WAIT;
                    WAIT: if (in) next = IDLE;
                    DONE: begin
                        par_reset = 1'b1;
                        next = in ? IDLE : DATA;
                    end
                    default: next = IDLE;
                endcase
            end
            always @(posedge clk) begin
                if (reset) begin
                    state <= IDLE;
                    bitn  <= 3'd0;
                end else begin
                    state <= next;
                    if (state == IDLE || state == DONE)
                        bitn <= 3'd0;
                    else if (state == DATA) begin
                        data[bitn] <= in;
                        bitn <= bitn + 3'd1;
                    end
                    if (next == DONE)
                        out_byte <= data;
                end
            end
            assign done = (state == DONE);
        endmodule
    """,
    notes="HDLBits provides `parity`. Local helper: `helpers/parity.v`. Odd-parity checking is subtle; verify on HDLBits.",
)

add(
    num=138, section_dir=D, filename="fsm_hdlc", title="Sequence recognition",
    url=H + "Fsm_hdlc", section_name=S,
    statement="""
        HDLC bit-stuffing detector. Search the serial stream for 0111110
        (disc=1, bit to discard) and 01111110 (flag, done=1). Count
        consecutive 1s after a 0. Synchronous reset.
    """,
    code="""
        module top_module (
            input      clk,
            input      reset,
            input      in,
            output     disc,
            output     flag,
            output     err
        );
            reg [3:0] ones, ones_n;
            always @(*) begin
                if (!in)
                    ones_n = 4'd0;
                else if (ones < 4'd7)
                    ones_n = ones + 4'd1;
                else
                    ones_n = ones;
            end
            always @(posedge clk) begin
                if (reset)
                    ones <= 4'd0;
                else
                    ones <= ones_n;
            end
            assign disc = (ones == 4'd5) && (in == 1'b0);
            assign flag = (ones == 4'd6) && (in == 1'b0);
            assign err  = (ones >= 4'd7);
        endmodule
    """,
)
