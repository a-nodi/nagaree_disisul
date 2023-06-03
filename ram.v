/* CSED273 FInal project */

`timescale 1ns / 1ps

module RamCell(
    input data[3:0],
    input clk,
    input cs,
    input wr,
    output reg out[3:0]
);
    wire ck;
    assign ck = cs & wr & clk;
    
    initial begin
        out = 4'b0000;
    end
    
    always @(posedge ck) begin
        assign out[0] = _data[0];
        assign out[1] = _data[1];
        assign out[2] = _data[2];
        assign out[3] = _data[3];
    end
    
endmodule


module InputRegArray(
    input data[3:0],
    input clk,
    input cs[5:0],
    input wr,
    input reset,
    output wire [5:0] out_bcd [3:0]
);

    RamCell cell0(data, clk, cs[0] | reset, wr, out_bcd[0]);
    RamCell cell1(data, clk, cs[1] | reset, wr, out_bcd[1]);
    RamCell cell2(data, clk, cs[2] | reset, wr, out_bcd[2]);
    RamCell cell3(data, clk, cs[3] | reset, wr, out_bcd[3]);
    RamCell cell4(data, clk, cs[4] | reset, wr, out_bcd[4]);
    RamCell cell5(data, clk, cs[5] | reset, wr, out_bcd[5]);
    
endmodule

module OutputRegArray(
    input wire [5:0] data[3:0],
    input clk,
    input cs[5:0],
    input wr,
    input reset,
    output wire [5:0] out_bcd [3:0]
);

    RamCell cell0(data, clk, cs[0], wr, out_bcd[0]);
    RamCell cell1(data, clk, cs[1], wr, out_bcd[1]);
    RamCell cell2(data, clk, cs[2], wr, out_bcd[2]);
    RamCell cell3(data, clk, cs[3], wr, out_bcd[3]);
    RamCell cell4(data, clk, cs[4], wr, out_bcd[4]);
    RamCell cell5(data, clk, cs[5], wr, out_bcd[5]);

endmodule

module StorageDevice(
    input data[3:0],
    input clk,
    input wr,
    input cs[5:0],
    input reset,
    input initialize,
    output wire correct
);
    
    wire _correct[5:0];
    wire input_word[5:0];
    wire answer_word[5:0];
    
    InputRegArray input_reg_array(data, clk, cs, 1, reset, input_word);
    OutputRegArray output_reg_array(input_word, clk, cs, wr, initialize, output_word);
    
    assign _correct[0] = input_word[0] ~^ output_word[0];
    assign _correct[1] = input_word[1] ~^ output_word[1];
    assign _correct[2] = input_word[2] ~^ output_word[2];
    assign _correct[3] = input_word[3] ~^ output_word[3];
    assign _correct[4] = input_word[4] ~^ output_word[4];
    assign _correct[5] = input_word[5] ~^ output_word[5];
    
    assign correct = _correct[0] & _correct[1] & _correct[2] & _correct[3] & _correct[4] & _correct[5] & _correct[6];
endmodule

module Comparator(
    input data[3:0], // BCD
    input input_digit_count[2:0],
    input clk, // Clock
    input cs[5:0],
    input wr, // ��й�ȣ �缳�� (reset)
    input compare, // is_star_pressed
    input reset, // input buffer �ʱ�ȭ
    input initialize, // answer buffer �ʱ�ȭ
    output reg correct
);
    
    reg [2:0] answer_digit_count;
    wire _reset;
    StorageDevice storage_device(data, clk, wr, cs, reset | _reset, initialize, _correct);
    
    initial begin
        answer_digit_count = 3'b100;
        reset = 1'b1;
        initialize = 1'b1;
        correct = 1'b0;
    end
    
    always @(posedge wr) begin // wr 1 �̸� ��� ����
        assign answer_digit_count[0] = input_digit_count[0];
        assign answer_digit_count[1] = input_digit_count[1];
        assign answer_digit_count[2] = input_digit_count[2];        
    end
    
    always @(posedge compare) begin // compare
        assign correct = _correct & (input_digit_count[0] ~^ answer_digit_count[0]) & (input_digit_count[1] ~^ answer_digit_count[1]) & (input_digit_count[2] ~^ answer_digit_count[2]);
        assign _reset = 1; 
    end
    
    always @(negedge compare) begin
        assign correct = _correct & (input_digit_count[0] ~^ answer_digit_count[0]) & (input_digit_count[1] ~^ answer_digit_count[1]) & (input_digit_count[2] ~^ answer_digit_count[2]);
        assign _reset = 0;
    end
    
endmodule