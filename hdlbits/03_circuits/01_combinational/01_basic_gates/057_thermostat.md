# 057. Thermostat

**Section:** Circuits — Combinational Logic — Basic Gates  
**HDLBits:** [Thermostat](https://hdlbits.01xz.net/wiki/Thermostat)

## Problem

Heating/cooling thermostat:
  mode=1 is heating: heater = too_cold
  mode=0 is cooling: aircon = too_hot
  fan is on if heater or aircon is on, or if fan_on is requested.

## Solution

The module is named `top_module` so you can paste it into HDLBits. The same source is in [`057_thermostat.v`](./057_thermostat.v).

```verilog
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
```
