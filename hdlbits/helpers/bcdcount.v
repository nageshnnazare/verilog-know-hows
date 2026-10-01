module bcdcount (
    input            clk,
    input            reset,
    input            enable,
    output reg [3:0] Q
);
    always @(posedge clk) begin
        if (reset)
            Q <= 4'd0;
        else if (enable) begin
            if (Q == 4'd9)
                Q <= 4'd0;
            else
                Q <= Q + 4'd1;
        end
    end
endmodule
