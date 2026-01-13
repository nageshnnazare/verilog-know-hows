//============================================================================
// Example 6: Traffic Light Controller FSM
// Description: Moore state machine for traffic light control
//============================================================================

module traffic_light_fsm (
    input  wire       clk,
    input  wire       rst_n,
    input  wire       pedestrian_button,
    output reg  [2:0] lights  // {red, yellow, green}
);

    // State encoding
    localparam GREEN  = 2'b00;
    localparam YELLOW = 2'b01;
    localparam RED    = 2'b10;
    
    // Timing (in clock cycles for simulation)
    localparam GREEN_TIME  = 10;
    localparam YELLOW_TIME = 3;
    localparam RED_TIME    = 8;
    
    reg [1:0] state, next_state;
    reg [7:0] timer;
    wire timer_done;
    
    // State register
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            state <= RED;
        else
            state <= next_state;
    end
    
    // Timer
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            timer <= 8'd0;
        else if (state != next_state)
            timer <= 8'd0;
        else
            timer <= timer + 1;
    end
    
    assign timer_done = (state == GREEN  && timer >= GREEN_TIME - 1)  ||
                       (state == YELLOW && timer >= YELLOW_TIME - 1) ||
                       (state == RED    && timer >= RED_TIME - 1);
    
    // Next state logic
    always @(*) begin
        case (state)
            GREEN:  next_state = timer_done ? YELLOW : GREEN;
            YELLOW: next_state = timer_done ? RED    : YELLOW;
            RED:    next_state = timer_done ? GREEN  : RED;
            default: next_state = RED;
        endcase
    end
    
    // Output logic (Moore - depends only on state)
    always @(*) begin
        case (state)
            GREEN:   lights = 3'b001;
            YELLOW:  lights = 3'b010;
            RED:     lights = 3'b100;
            default: lights = 3'b100;
        endcase
    end

endmodule

//============================================================================
// Testbench
//============================================================================

`timescale 1ns/1ps

module traffic_light_fsm_tb;
    reg        clk;
    reg        rst_n;
    reg        pedestrian_button;
    wire [2:0] lights;
    
    traffic_light_fsm dut (
        .clk(clk),
        .rst_n(rst_n),
        .pedestrian_button(pedestrian_button),
        .lights(lights)
    );
    
    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    // Monitor state changes
    always @(posedge clk) begin
        case (lights)
            3'b001: $display("Time %0t: GREEN", $time);
            3'b010: $display("Time %0t: YELLOW", $time);
            3'b100: $display("Time %0t: RED", $time);
        endcase
    end
    
    initial begin
        $dumpfile("traffic_light.vcd");
        $dumpvars(0, traffic_light_fsm_tb);
        
        // Initialize
        rst_n = 0;
        pedestrian_button = 0;
        
        #15 rst_n = 1;
        $display("\n=== Traffic Light Controller FSM Test ===\n");
        
        // Let it run through several cycles
        #500;
        
        $display("\n✓ Traffic light FSM test completed!");
        $finish;
    end
endmodule

