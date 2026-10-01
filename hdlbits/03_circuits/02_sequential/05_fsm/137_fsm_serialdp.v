//==============================================================================
// HDLBits 137 — Serial receiver with parity checking
// Official problem: https://hdlbits.01xz.net/wiki/Fsm_serialdp
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Serial receiver with odd parity. After 8 data bits comes a parity bit,
// then a stop bit. `done` only if stop=1 and odd parity is correct.
// You may use the provided `parity` module (odd parity of 8 bits plus
// a reset). `odd` from that module is 1 when the running parity is odd.
//

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
