//==============================================================================
// HDLBits 057 — Thermostat
// Official problem: https://hdlbits.01xz.net/wiki/Thermostat
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Heating/cooling thermostat:
//   mode=1 is heating: heater = too_cold
//   mode=0 is cooling: aircon = too_hot
//   fan is on if heater or aircon is on, or if fan_on is requested.
//

module top_module (
    input  too_cold,
    input  too_hot,
    input  mode,
    input  fan_on,
    output heater,
    output aircon,
    output fan
);
    assign heater = mode & too_cold;
    assign aircon = ~mode & too_hot;
    assign fan    = heater | aircon | fan_on;
endmodule
