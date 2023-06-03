/* CSED273 FInal project */

`timescale 1ns / 1ps

module safe(
    input row1, row2, row3, row4, col1, col2, col3,
    input reset, initialize, clk,
    output passward_led[5:0], reg [2:0] state
);

    reg is_on;
    reg [2:0] input_digit_count;
    wire _cs[5:0];
    wire cs[5:0];
    wire is_pressed;
    wire digit_count_clk;
    wire bcd[3:0];
    wire correct;
    
    initial begin
        is_on = 1'b0;
        digit_count = 3'b000;
        state = 3'b000;
    end
    
    
    KeypadToBcd keypad_to_bcd(row1, row2, row3, row4, col1, col2, col3, bcd); // get bcd
    Counter input_digit_counter(is_pressed, row4 & col1, reset, digit_count); // count
    Decoder decoder(digit_count, _cs);
    Comparator comparator(bcd, digit_count, clk, cs, reset, row4 & col1. reset, initialize, correct);
    StateManager state_manager(is_on, is_star_pressed, reset, correct, initialize, state);
    
    always @(posedge clk) begin
        assign is_pressed = row1 | row2 | row3 | row4 | col1 | col2 | col3;
        assign is_on = col3 & row4 & ~reset & ~is_pressed;
        assign is_star_pressed = col3 & row4 & ~is_pressed;
        assign digit_count_clk = is_on & is_pressed;
        assign cs[0] = _cs[0] & is_pressed;
        assign cs[1] = _cs[1] & is_pressed;
        assign cs[2] = _cs[2] & is_pressed;
        assign cs[3] = _cs[3] & is_pressed;
        assign cs[4] = _cs[4] & is_pressed;
        assign cs[5] = _cs[5] & is_pressed;
        
        
        
    end
endmodule

