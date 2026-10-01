// Odd-parity accumulator used by fsm_serialdp.
module parity (
    input      clk,
    input      reset,
    input      in,
    output     odd
);
    reg p;
    always @(posedge clk) begin
        if (reset)
            p <= 1'b0;
        else
            p <= p ^ in;
    end
    assign odd = p;
endmodule
