//==============================================================================
// HDLBits 128 — Lemmings 1
// Official problem: https://hdlbits.01xz.net/wiki/Lemmings1
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// A walking lemming. Exactly one of `walk_left` / `walk_right` is 1
// while on ground. `bump_left` / `bump_right` reverse direction
// (both bumps also reverse). `ground`=0 means falling: both walk
// outputs are 0; resume the previous direction when ground returns.
// Asynchronous reset: walk left. (Lemmings 1 has no `aaah` port.)
//

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
