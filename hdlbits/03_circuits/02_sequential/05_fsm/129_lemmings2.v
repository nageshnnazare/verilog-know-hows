//==============================================================================
// HDLBits 129 — Lemmings 2
// Official problem: https://hdlbits.01xz.net/wiki/Lemmings2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Lemmings 1 plus `aaah` which is 1 while falling.
//

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
