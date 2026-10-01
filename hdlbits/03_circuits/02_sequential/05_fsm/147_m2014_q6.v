//==============================================================================
// HDLBits 147 — Q6: FSM
// Official problem: https://hdlbits.01xz.net/wiki/Exams/m2014_q6
//
// The wording below is a restatement for this tutorial. Figures from the
// official page are in the matching .md file. Use HDLBits for the
// interactive checker.
//
// HDLBits always names the user module `top_module`. Port names match the
// official template so you can paste this file into the HDLBits editor.
//==============================================================================
//
// Full FSM from the 2014 midterm Q6. Synchronous reset. Input w,
// output z. The state diagram has states A-F:
//   A -0-> B -0-> C -0-> D -0-> A? with z=1 in certain states.
// Standard:
//   A --0--> B --0--> C --0--> D
//   any --1--> A  except some states go to E/F
// A known-good implementation of the textbook diagram:
//   z is 1 in states E and F? or C? 
// The usual diagram:
//   A w=0->B, w=1->A
//   B w=0->C, w=1->D
//   C w=0->E, w=1->D
//   D w=0->F, w=1->A
//   E w=0->E, w=1->D  z=1
//   F w=0->C, w=1->D  z=1
//

module top_module (
    input      clk,
    input      reset,
    input      w,
    output     z
);
    parameter A=0, B=1, C=2, D=3, E=4, F=5;
    reg [2:0] state, next;
    always @(*) begin
        case (state)
            A: next = w ? A : B;
            B: next = w ? D : C;
            C: next = w ? D : E;
            D: next = w ? A : F;
            E: next = w ? D : E;
            F: next = w ? D : C;
            default: next = A;
        endcase
    end
    always @(posedge clk) begin
        if (reset)
            state <= A;
        else
            state <= next;
    end
    assign z = (state == E) || (state == F);
endmodule
