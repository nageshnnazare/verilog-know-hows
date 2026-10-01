# 118. Conway's Game of Life 16x16

**Section:** Circuits — Sequential Logic — More Circuits  
**HDLBits:** [Conway's Game of Life 16x16](https://hdlbits.01xz.net/wiki/Conwaylife)

## Problem

16x16 Game of Life with wrap-around (torus). `load` loads q from data.
Each cell: 2 neighbours and live -> stay; 3 neighbours -> born/stay;
otherwise die. q is packed 256 bits, row-major (q[15:0] is row 0).

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`118_conwaylife.v`](./118_conwaylife.v).

```verilog
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
```
