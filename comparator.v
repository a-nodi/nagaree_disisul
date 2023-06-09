/* CSED273 Final project */

`timescale 1ns / 1ps

module TriStateBuffer(
    input in,
    input en,
    output out
);
    /*
    The tri-state buffer
    
    :input in: input
    :input en: enable
    :output out: output
    
    No Initialization needed
    Asynchronous module
    */

    assign out = en ? in:1'bz;

endmodule

module _2to1MUX(
    input [3:0] data0,
    input [3:0] data1,
    input select,
    output [3:0] out
);
    /*
    
    */
    
    assign out[0] = ~select & data0[0] | select & data1[0];
    assign out[1] = ~select & data0[1] | select & data1[1];
    assign out[2] = ~select & data0[2] | select & data1[2];
    assign out[3] = ~select & data0[3] | select & data1[3];

endmodule

module DataCell(
    input [3:0] data,
    input cs,
    input wr,
    input reset,
    output reg [3:0] out
);
    /*
    The data cell that contains 8421 BCD code
    
    :input [3:0] data: 8421 BCD code input 
    :input cs: 1 when this chip is selected, 0 when not
    :input wr: 1 when write mod, 0 when read mod
    :input reset: 1 when want to clear content of cell to 0000, 0 when not
    :output reg [3:0] out: 8421 BCD code output

    No Initialization needed
    Asynchronous module
    */
    
    wire ck;
    assign ck = cs & wr;
    
    initial begin // Initialize data to 0000
        out <= 4'b0000;
    end

    always @(posedge ck) begin // If chip selected and write mod write data
        // Write data
        out[0] <= data[0] & ~reset;
        out[1] <= data[1] & ~reset;
        out[2] <= data[2] & ~reset;
        out[3] <= data[3] & ~reset;
    end

    always @(posedge reset) begin // If reset is 1
        // Reset data to 0000
        out <= 4'b0000;
    end
    
endmodule

module InputRegArray(
    input [3:0] data,
    input [5:0] cs,
    input wr,
    input reset,
    output [3:0] out_bcd0, 
    output [3:0] out_bcd1, 
    output [3:0] out_bcd2, 
    output [3:0] out_bcd3, 
    output [3:0] out_bcd4, 
    output [3:0] out_bcd5
);
    /*
    The register array contains 6 of 8421 BCD code Input.

    :input [3:0] data: 8421 BCD code input 
    :input [5:0] cs: Array of cs, element of cs is 1 when this chip is selected, 0 when not
    :input wr: 1 when write mod, 0 when read mod
    :input reset: 1 when want to clear content of cell to 0000, 0 when not
    :output [3:0] out_bcd0: 0st 8421 BCD code output
    :output [3:0] out_bcd1: 1st 8421 BCD code output
    :output [3:0] out_bcd2: 2nd 8421 BCD code output
    :output [3:0] out_bcd3: 3rd 8421 BCD code output
    :output [3:0] out_bcd4: 4th 8421 BCD code output
    :output [3:0] out_bcd5: 5th 8421 BCD code output
    
    No Initialization needed
    Asynchronous module
    */

    DataCell cell0(data, cs[0], wr, reset, out_bcd0); // Connect 0th cell
    DataCell cell1(data, cs[1], wr, reset, out_bcd1); // Connect 1st cell
    DataCell cell2(data, cs[2], wr, reset, out_bcd2); // Connect 2nd cell
    DataCell cell3(data, cs[3], wr, reset, out_bcd3); // Connect 3rd cell
    DataCell cell4(data, cs[4], wr, reset, out_bcd4); // Connect 4th cell
    DataCell cell5(data, cs[5], wr, reset, out_bcd5); // Connect 5th cell
    
endmodule

module OutputRegArray(
    input [3:0] data0,
    input [3:0] data1,
    input [3:0] data2,
    input [3:0] data3,
    input [3:0] data4,
    input [3:0] data5,
    input [5:0] cs,
    input wr,
    input reset,
    output [3:0] out_bcd0, 
    output [3:0] out_bcd1, 
    output [3:0] out_bcd2, 
    output [3:0] out_bcd3, 
    output [3:0] out_bcd4, 
    output [3:0] out_bcd5
);
    /*
    The register array contains 6 of 8421 BCD code answer.

    :input [3:0] data0: 0th 8421 BCD code input
    :input [3:0] data1: 1st 8421 BCD code input 
    :input [3:0] data2: 2nd 8421 BCD code input 
    :input [3:0] data3: 3rd 8421 BCD code input 
    :input [3:0] data4: 4th 8421 BCD code input 
    :input [3:0] data5: 5th 8421 BCD code input  
    :input [5:0] cs: Array of cs, element of cs is 1 when this chip is selected, 0 when not
    :input wr: 1 when write mod, 0 when read mod
    :input reset: 1 when want to clear content of cell to 0000, 0 when not
    :output [3:0] out_bcd0: 0th 8421 BCD code output
    :output [3:0] out_bcd1: 1st 8421 BCD code output
    :output [3:0] out_bcd2: 2nd 8421 BCD code output
    :output [3:0] out_bcd3: 3rd 8421 BCD code output
    :output [3:0] out_bcd4: 4th 8421 BCD code output
    :output [3:0] out_bcd5: 5th 8421 BCD code output
    
    No Initialization needed
    Asynchronous module
    */

    DataCell cell0(data0, cs[0], wr, reset, out_bcd0); // Connect 0th cell
    DataCell cell1(data1, cs[1], wr, reset, out_bcd1); // Connect 1st cell
    DataCell cell2(data2, cs[2], wr, reset, out_bcd2); // Connect 2nd cell
    DataCell cell3(data3, cs[3], wr, reset, out_bcd3); // Connect 3rd cell
    DataCell cell4(data4, cs[4], wr, reset, out_bcd4); // Connect 4th cell
    DataCell cell5(data5, cs[5], wr, reset, out_bcd5); // Connect 5th cell
    
endmodule

module BitwiseComparator(
    input [3:0] input_data,
    input [3:0] answer_data,
    output correct
);

    /*
    The module that compares all bits of two 8421 BCD code
    
    :input [3:0] input_data: 8421 BCD code input 
    :input [3:0] answer_data: 8421 BCD code answer
    :output correct: 1 when all bits of input data and answer data is same, 0 when not

    No Initialization needed
    Asynchronous module
    */

    // Bit-wise comparison
    assign correct0 = input_data[0] ~^ answer_data[0]; 
    assign correct1 = input_data[1] ~^ answer_data[1];
    assign correct2 = input_data[2] ~^ answer_data[2];
    assign correct3 = input_data[3] ~^ answer_data[3];
    
    // Integrate comparison results
    assign correct = correct0 & correct1 & correct2 & correct3;

endmodule

module Comparator(
    input [3:0] data,
    input is_star_pressed,
    input reset_password,
    input clear_answer,
    input is_on,
    input is_pressed,
    output wire correct
);
    /*
    The module that compares input word and answer word, contains input word and answer word
    
    :input [3:0] data: 8421 BCD code input
    :input is_star_pressed: 1 when * is pressed, 0 when not 
    :input reset_password: 1 when reset button is pressed, 0 when not
    :input clear_answer: 1 when initialize button is pressed, 0 when not
    :input is_on: 1 when safe is on, 0 when not
    :input is_pressed: 1 when keypad button (except star) is pressed, 0 when not
    :output wire correct: 1 when input word and output word is same, 0 when not
    
    No Initialization needed
    Asynchronous module
    */

    wire [5:0] _correct;
    wire [3:0] input_word[5:0];
    wire [3:0] answer_word[5:0];
    wire [3:0] answer_input[5:0];
    wire [5:0] input_cs;
    wire [5:0] output_cs;
    wire [2:0] input_length;
    reg [2:0] answer_length;
    reg changing_password;
    reg clear_input;

    initial begin
        answer_length <= 3'b110; // Set Initial password to 000000
        changing_password <= 1'b0; // Not changing password 
        clear_input <= 1'b0; // Not clearing input
    end

    InputRegArray input_reg_array(data, input_cs, 1, clear_input, input_word[0], input_word[1], input_word[2], input_word[3], input_word[4], input_word[5]);
    
    /*
    2to1MUX 2to1mux0(answer_word[0], input_word[0], parallel_load, answer_input[0]);
    2to1MUX 2to1mux1(answer_word[1], input_word[1], parallel_load, answer_input[1]);
    2to1MUX 2to1mux2(answer_word[2], input_word[2], parallel_load, answer_input[2]);
    2to1MUX 2to1mux3(answer_word[3], input_word[3], parallel_load, answer_input[3]);
    2to1MUX 2to1mux4(answer_word[4], input_word[4], parallel_load, answer_input[4]);
    2to1MUX 2to1mux5(answer_word[5], input_word[5], parallel_load, answer_input[5]);
    */

    OutputRegArray output_reg_array(input_word[0], input_word[1], input_word[2], input_word[3], input_word[4], input_word[5], 
                                    output_cs, parallel_load, clear_answer, 
                                    answer_word[0], answer_word[1], answer_word[2], answer_word[3], answer_word[4], answer_word[5]);
    
    // Bit-wise compare input word bits and output word bits
    BitwiseComparator bitwise_comparator0(input_word[0], answer_word[0], _correct[0]);
    BitwiseComparator bitwise_comparator1(input_word[1], answer_word[1], _correct[1]);
    BitwiseComparator bitwise_comparator2(input_word[2], answer_word[2], _correct[2]);
    BitwiseComparator bitwise_comparator3(input_word[3], answer_word[3], _correct[3]);
    BitwiseComparator bitwise_comparator4(input_word[4], answer_word[4], _correct[4]);
    BitwiseComparator bitwise_comparator5(input_word[5], answer_word[5], _correct[5]);

    // Count input word length
    Counter length_counter(is_pressed, is_star_pressed, clear_input, input_length);
    
    // Chip selection of input reg array
    Decoder decoder(input_length, 1, input_cs);
    
    // Clear answer reg array if the safe is changing password state
    assign output_cs[0] = changing_password;
    assign output_cs[1] = changing_password;
    assign output_cs[2] = changing_password;
    assign output_cs[3] = changing_password;
    assign output_cs[4] = changing_password;
    assign output_cs[5] = changing_password;

    // Parallel load input reg array to answer reg array if the safe is changing password state, password length is 4 ~ 6, 
    assign parallel_load = changing_password & input_length[2] & is_star_pressed & ~(input_length[2] & input_length[1] & input_length[0]);
    
    // 1 when length of input word and length of answer word is same, 0 when not
    assign length_correct = (input_length[0] ~^ answer_length[0]) & (input_length[1] ~^ answer_length[1]) & (input_length[2] ~^ answer_length[2]);
    
    // 1 when content of input reg array and content of answer reg array is same, 0 when not
    assign word_correct = _correct[0] & _correct[1] & _correct[2] & _correct[3] & _correct[4] & _correct[5];
    
    // 1 when input word and output word is same, 0 when not
    assign correct = length_correct & word_correct;

    // Clear password
    always @(posedge reset_password) begin
        changing_password <= 1'b1;
    end

    // End parallel load, Save password length, Clear input reg array if star button pressed
    always @(posedge is_star_pressed) begin
        changing_password <= 1'b0;
        answer_length <= input_length;
        clear_input <= 1;
    end

    // Clear input reg array if safe if off state
    always @(negedge is_on) begin
        clear_input <= 1;
    end

    // Stop clearing input reg array if star button preesed
    always @(negedge is_star_pressed) begin
        clear_input <= 0;
    end

    // Stop clearing input reg array if on state
    always @(posedge is_on) begin
        clear_input <= 0;
    end

endmodule