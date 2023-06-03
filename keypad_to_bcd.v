`timescale 1ns / 1ps

module KeypadToBcd(
    input row1, input row2, input row3, input row4, 
    input col1, input col2, input col3, 
    output [3:0] bcd
    );
    //priority encoder
    
    assign bcd[3] = ~row1 & ~row2 & row3 & ~col1 & col2 | ~row1 & ~row2 & row3 & ~col1 & col3;
    assign bcd[2] = ~row1 & row2 | ~row1 & row3 & col1;
    assign bcd[1] = row1 & ~col1 & col2 | row1 & ~col1 & col3 | ~row1 & row2 & ~col1 & ~col2 & col3 | ~row1 & ~row2 & row3 & col1;
    assign bcd[0] = row1 & col1 | row1 & ~col2 & col3 | ~row1 & row2 & col2 | ~row1 & ~row2 & row3 & col1 | ~row1 & ~row2 & row3 & ~col2 & col3;
endmodule
