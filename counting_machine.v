`timescale 1ns / 1ps

module Counter(
    input clk,
    input is_star_pressed,
    input reset,
    output reg [2:0] q
    );
    
    initial begin
        q[2:0] = 3'b000;
    end
    
    always @(negedge clk) begin
        q[0] <= ~(is_star_pressed & q[2]) & ~q[0] | ~is_star_pressed & q[2] & q[1] & q[0];
        q[1] <= ~(is_star_pressed & q[2]) & q[1] ^ q[0] | ~is_star_pressed & q[2] & q[1] & q[0];
        q[2] <= ~(is_star_pressed & q[2]) & (q[2] | q[1] & q[0]) | ~is_star_pressed & q[2] & q[1] & q[0];
    end
    
    always @(posedge reset) begin
        q[2:0] = 3'b000;
    end
endmodule
