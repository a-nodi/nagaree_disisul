`timescale 1ns / 1ps

module Counter(
    input is_star_pressed,
    input reset,
    input clk,
    output reg [2:0] q
    );
    /*
    The counter that counts length of input word

    :input clk: clock, 1 when keypad button(except star button) pressed, 0 when not   
    :input is_star_pressed: 1 when star button pressed, 0 when not
    :output reg [2:0] q: binary number count
    
    Initialize itself at start
    Initialized when is_star_pressed is 1
    Initialized when positive edge of reset

    Synchronous module
    */
    
    // Initialize when FPGA turned on
    initial begin
        q[2:0] = 3'b000;
    end
    
    always @(negedge clk) begin // When keypad
        q[0] <= ~(is_star_pressed & q[2]) & ~q[0] | ~is_star_pressed & q[2] & q[1] & q[0];
        q[1] <= ~(is_star_pressed & q[2]) & q[1] ^ q[0] | ~is_star_pressed & q[2] & q[1] & q[0];
        q[2] <= ~(is_star_pressed & q[2]) & (q[2] | q[1] & q[0]) | ~is_star_pressed & q[2] & q[1] & q[0];
    end
    
    always @(posedge reset) begin // When reset signal comes in
        q[2:0] = 3'b000;
    end
endmodule
