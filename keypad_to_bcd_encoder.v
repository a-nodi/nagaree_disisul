/* CSED273 Final project */

`timescale 1ns / 1ps

module KeypadToBcdEncoder(
    input row1, input row2, input row3, input row4, 
    input col1, input col2, input col3, 
    output [3:0] bcd
    );
    /*

    The encoder that converts keypad input to 8421 BCD code

    :input row1: 1 when 1st row of keypad is pressed, 0 when not
    :input row2: 1 when 2nd row of keypad is pressed, 0 when not
    :input row3: 1 when 3rd row of keypad is pressed, 0 when not
    :input row4: 1 when 4th row of keypad is pressed, 0 when not
    :input col1: 1 when 1st column of keypad is pressed, 0 when not
    :input col2: 1 when 2nd column of keypad is pressed, 0 when not
    :input col3: 1 when 3rd column of keypad is pressed, 0 when not
    :output [3:0] bcd: 8421 BCD code

    No initialization needed
    Synchronous module
    */
    
    assign bcd[3] = ~row1 & ~row2 & row3 & ~col1 & col2 | ~row1 & ~row2 & row3 & ~col1 & col3;
    assign bcd[2] = ~row1 & row2 | ~row1 & row3 & col1;
    assign bcd[1] = row1 & ~col1 & col2 | row1 & ~col1 & col3 | ~row1 & row2 & ~col1 & ~col2 & col3 | ~row1 & ~row2 & row3 & col1;
    assign bcd[0] = row1 & col1 | row1 & ~col2 & col3 | ~row1 & row2 & col2 | ~row1 & ~row2 & row3 & col1 | ~row1 & ~row2 & row3 & ~col2 & col3;

endmodule
