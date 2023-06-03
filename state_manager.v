/* CSED273 FInal project */

`timescale 1ns / 1ps

module StateManager(
    input is_on, is_star_pressed, reset, correct, initialize,
    input clk,
    output reg [2:0] state
);
    reg [4:0] _input;
    
    initial begin
        state = 3'b000;
    end
    
    always @(posedge clk) begin
        assign _input[4] = is_on;
        assign _input[3] = is_star_pressed;
        assign _input[2] = reset;
        assign _input[1] = correct;
        assign _input[0] = initialize;
        
        // State = 000
        if (state == 3'b000 && _input == 5'b1xxxx) begin
            state = 3'b001;
        end
        
        if (state == 3'b000 && _input == 5'b0xxxx) begin
            state = 3'b000;
        end
        
        // State = 001
        if (state == 3'b001 && _input == 5'b) begin
        
        end
        
    end
    

    
endmodule