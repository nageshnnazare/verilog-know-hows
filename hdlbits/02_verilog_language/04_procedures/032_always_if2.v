//==============================================================================
// HDLBits 032 — If statement latches
// Official problem: https://hdlbits.01xz.net/wiki/Always_if2
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Fix a combinational always block that accidentally infers a latch
// because `out` is not assigned in every branch. The intended function
// is a mux: if `cpu_overheated` then `shut_off_computer = 1` else 0;
// if `arrived` then `keep_driving = ~gas_tank_empty` else 0.
// Always assign both outputs in all cases.
//

module top_module (
    input      cpu_overheated,
    output reg shut_off_computer,
    input      arrived,
    input      gas_tank_empty,
    output reg keep_driving
);
    always @(*) begin
        if (cpu_overheated)
            shut_off_computer = 1'b1;
        else
            shut_off_computer = 1'b0;
    end

    always @(*) begin
        if (~arrived)
            keep_driving = ~gas_tank_empty;
        else
            keep_driving = 1'b0;
    end
endmodule
