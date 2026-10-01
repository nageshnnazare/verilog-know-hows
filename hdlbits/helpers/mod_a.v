// Local stand-ins for modules HDLBits provides. Compile these together with
// the corresponding solution when you want to simulate off-site.
// Do NOT paste helper modules into the HDLBits editor.

module mod_a (
    input  in1,
    input  in2,
    output out
);
    assign out = in1 & in2;
endmodule
