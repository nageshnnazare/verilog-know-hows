//==============================================================================
// HDLBits 118 — Conway's Game of Life 16x16
// Official problem: https://hdlbits.01xz.net/wiki/Conwaylife
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// 16x16 Game of Life with wrap-around (torus). `load` loads q from data.
// Each cell: 2 neighbours and live -> stay; 3 neighbours -> born/stay;
// otherwise die. q is packed 256 bits, row-major (q[15:0] is row 0).
//

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
