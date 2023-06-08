/* CSED273 FInal project */

`timescale 1ns / 1ps

module RamCell(
    input [3:0] data,
    input clk,
    input cs,
    input wr,
    output reg [3:0] out
);
    wire ck;
    assign ck = cs & wr & clk;
    
    initial begin
        out <= 4'b0000;
    end
    
    always @(posedge ck) begin
        out[0] <= data[0];
        out[1] <= data[1];
        out[2] <= data[2];
        out[3] <= data[3];
    end
    
endmodule


module InputRegArray(
    input [3:0] data,
    input clk,
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

    RamCell cell0(data, clk, cs[0] | reset, wr, out_bcd0);
    RamCell cell1(data, clk, cs[1] | reset, wr, out_bcd1);
    RamCell cell2(data, clk, cs[2] | reset, wr, out_bcd2);
    RamCell cell3(data, clk, cs[3] | reset, wr, out_bcd3);
    RamCell cell4(data, clk, cs[4] | reset, wr, out_bcd4);
    RamCell cell5(data, clk, cs[5] | reset, wr, out_bcd5);
    
endmodule

module OutputRegArray(
    input wire [3:0] data,
    input clk,
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

    RamCell cell0(data, clk, cs[0], wr, out_bcd0);
    RamCell cell1(data, clk, cs[1], wr, out_bcd1);
    RamCell cell2(data, clk, cs[2], wr, out_bcd2);
    RamCell cell3(data, clk, cs[3], wr, out_bcd3);
    RamCell cell4(data, clk, cs[4], wr, out_bcd4);
    RamCell cell5(data, clk, cs[5], wr, out_bcd5);
<<<<<<< HEAD

endmodule

module BitwiseComparator(
    input [3:0] input_data,
    input [3:0] answer_data,
    output correct
);
    assign correct0 = input_data[0] ~^ answer_data[0]; 
    assign correct1 = input_data[1] ~^ answer_data[1];
    assign correct2 = input_data[2] ~^ answer_data[2];
    assign correct3 = input_data[3] ~^ answer_data[3];
    
    assign correct = correct0 & correct1 & correct2 & correct3;
=======
>>>>>>> e842aca292ff5d50028964b714b5b71822fa160e

endmodule

module StorageDevice(
    input [3:0] data,
    input clk,
    input wr,
    input [5:0] cs,
    input reset,
    input initialize,
    output wire correct
);
    
<<<<<<< HEAD
    wire [5:0] _correct;
    wire [3:0] input_word[5:0];
    wire [3:0] answer_word[5:0];
=======
    wire _correct[5:0];
    wire [5:0] input_word[3:0];
    wire [5:0] answer_word[3:0];
>>>>>>> e842aca292ff5d50028964b714b5b71822fa160e
    
    InputRegArray input_reg_array(data, clk, cs, 1, reset, input_word[0], input_word[1], input_word[2], input_word[3], input_word[4], input_word[5]);
    OutputRegArray output_reg_array(data, clk, cs, wr, initialize, answer_word[0], answer_word[1], answer_word[2], answer_word[3], answer_word[4], answer_word[5]);
    
<<<<<<< HEAD
    BitwiseComparator bitwise_comparator0(input_word[0], answer_word[0], _correct[0]);
    BitwiseComparator bitwise_comparator1(input_word[1], answer_word[1], _correct[1]);
    BitwiseComparator bitwise_comparator2(input_word[2], answer_word[2], _correct[2]);
    BitwiseComparator bitwise_comparator3(input_word[3], answer_word[3], _correct[3]);
    BitwiseComparator bitwise_comparator4(input_word[4], answer_word[4], _correct[4]);
    BitwiseComparator bitwise_comparator5(input_word[5], answer_word[5], _correct[5]);

    assign correct = _correct[0] & _correct[1] & _correct[2] & _correct[3] & _correct[4] & _correct[5];

    // assign correct = _correct[0] & _correct[1] & _correct[2] & _correct[3] & _correct[4] & _correct[5] & _correct[6];
=======
    assign _correct[0] = input_word[0] ~^ answer_word[0];
    assign _correct[1] = input_word[1] ~^ answer_word[1];
    assign _correct[2] = input_word[2] ~^ answer_word[2];
    assign _correct[3] = input_word[3] ~^ answer_word[3];
    assign _correct[4] = input_word[4] ~^ answer_word[4];
    assign _correct[5] = input_word[5] ~^ answer_word[5];
    
    assign correct = _correct[0] & _correct[1] & _correct[2] & _correct[3] & _correct[4] & _correct[5] & _correct[6];
>>>>>>> e842aca292ff5d50028964b714b5b71822fa160e
endmodule

module Comparator(
    input [3:0] data, // BCD
    input [2:0] input_digit_count,
    input clk, // Clock
    input [5:0] cs,
    input wr, // ��й�ȣ �缳�� (reset)
    input compare, // is_star_pressed
    input reset, // input buffer �ʱ�ȭ
    input initialize, // answer buffer �ʱ�ȭ
    output reg correct
);
    
    reg [2:0] answer_digit_count;
    reg _reset;
    StorageDevice storage_device(data, clk, wr, cs, reset | _reset, initialize, _correct);
    
    initial begin
        answer_digit_count <= 3'b100;
<<<<<<< HEAD
        _reset <= 1'b1;
=======
        // reset <= 1'b1;
>>>>>>> e842aca292ff5d50028964b714b5b71822fa160e
        // initialize <= 1'b1;
        correct = 1'b0;
    end
    
    always @(posedge wr) begin // wr 1 �̸� ��� ����
        answer_digit_count[0] <= input_digit_count[0];
        answer_digit_count[1] <= input_digit_count[1];
        answer_digit_count[2] <= input_digit_count[2];        
    end
    
    always @(posedge compare) begin // compare
        correct <= _correct & (input_digit_count[0] ~^ answer_digit_count[0]) & (input_digit_count[1] ~^ answer_digit_count[1]) & (input_digit_count[2] ~^ answer_digit_count[2]);
<<<<<<< HEAD
         
=======
        _reset <= 1; 
>>>>>>> e842aca292ff5d50028964b714b5b71822fa160e
    end
    
    always @(negedge compare) begin
        correct = _correct & (input_digit_count[0] ~^ answer_digit_count[0]) & (input_digit_count[1] ~^ answer_digit_count[1]) & (input_digit_count[2] ~^ answer_digit_count[2]);
<<<<<<< HEAD
        
=======
        _reset <= 0;
>>>>>>> e842aca292ff5d50028964b714b5b71822fa160e
    end
    
endmodule