//==============================================================================
// HDLBits 056 — Ring or vibrate?
// Official problem: https://hdlbits.01xz.net/wiki/Ringer
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Phone ringer/vibrator:
//   ringer = ring & ~vibrate_mode
//   motor  = ring &  vibrate_mode
// Exactly one of ringer/motor is on when `ring` is 1, selected by mode.
//

module top_module (
    input  ring,
    input  vibrate_mode,
    output ringer,
    output motor
);
    assign ringer = ring & ~vibrate_mode;
    assign motor  = ring &  vibrate_mode;
endmodule
