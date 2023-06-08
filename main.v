/* CSED273 FInal project */

`timescale 1ns / 1ps

module safe(
    input row1, row2, row3, row4, col1, col2, col3,
<<<<<<< HEAD
    input reset_, initialize_, clk,
    output [5:0] passward_led, wire [2:0] state
=======
    input reset, initialize, clk,
    output [5:0] passward_led, reg [2:0] state
>>>>>>> e842aca292ff5d50028964b714b5b71822fa160e
);

    reg is_on;
    reg reset;
    reg initialize;
    reg [2:0] input_digit_count;
    wire [5:0] _cs;
    wire [5:0] cs;
    wire is_pressed;
    wire digit_count_clk;
    wire [3:0] bcd;
<<<<<<< HEAD
    reg correct;
    wire correct_;
    reg is_star_pressed;

    initial begin
        is_on <= 1'b0;
        input_digit_count <= 3'b000;
        reset <= 1'b0;
        initialize <= 1'b0;
        is_star_pressed <= 1'b0;
        correct <= 1'b0;
        
=======
    wire correct;
    
    initial begin
        is_on = 1'b0;
        input_digit_count <= 3'b000;
        state = 3'b000;
>>>>>>> e842aca292ff5d50028964b714b5b71822fa160e
    end
    
    KeypadToBcd keypad_to_bcd(row1, row2, row3, row4, col1, col2, col3, bcd); // get bcd
    Counter input_digit_counter(is_pressed, row4 & col1, reset, digit_count); // count
    Decoder decoder(digit_count, _cs, 1);
    Comparator comparator(bcd, digit_count, clk, cs, reset, row4 & col1, reset, initialize, correct_);
    StateManager state_manager(is_on, is_star_pressed, reset, correct_, initialize, state);
    
<<<<<<< HEAD
    assign is_pressed = (row1 | row2 | row3 | row4 | col1 | col2 | col3) & ~(col1 & row4);
=======
    assign is_pressed = row1 | row2 | row3 | row4 | col1 | col2 | col3;
    assign is_star_pressed = col3 & row4 & ~is_pressed;
>>>>>>> e842aca292ff5d50028964b714b5b71822fa160e
    assign digit_count_clk = is_on & is_pressed;

    assign cs[0] = _cs[0] & is_pressed;
    assign cs[1] = _cs[1] & is_pressed;
    assign cs[2] = _cs[2] & is_pressed;
    assign cs[3] = _cs[3] & is_pressed;
    assign cs[4] = _cs[4] & is_pressed;
    assign cs[5] = _cs[5] & is_pressed;

    always @(posedge clk) begin    
<<<<<<< HEAD
        is_on <= col3 & row4 & ~reset & ~is_pressed; // reg
        reset <= reset_; // wire
        initialize <= initialize_; // wire
        correct <= correct_; // reg
        is_star_pressed <= col1 & row4 & ~is_pressed; // wire
=======
        is_on = col3 & row4 & ~reset & ~is_pressed;
        
        

        
        
        
>>>>>>> e842aca292ff5d50028964b714b5b71822fa160e
    end


endmodule

