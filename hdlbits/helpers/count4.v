module count4 (
    input            clk,
    input            enable,
    input            load,
    input      [3:0] d,
    output reg [3:0] q
);
    always @(posedge clk) begin
        if (load)
            q <= d;
        else if (enable)
            q <= q + 4'd1;
    end
endmodule
