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
        if (_input === 5'bxxxx1) begin
            state = 3'b000; end
        else if (state === 3'b000 && _input === 5'b1xxxx) begin
            state = 3'b001; end
        else if (state === 3'b001 && _input === 5'b1xxxx) begin
            state = 3'b000; end
        else if (state === 3'b001 && _input === 5'b01010) begin
            state = 3'b100; end
        else if (state === 3'b001 && _input === 5'b01000) begin
            state = 3'b010; end
        else if (state === 3'b010 && _input === 5'b01010) begin
            state = 3'b100; end
        else if (state === 3'b010 && _input === 5'b01000) begin
            state = 3'b011; end
        else if (state === 3'b011 && _input === 5'b01010) begin
            state = 3'b100; end
        else if (state === 3'b011 && _input === 5'b01000) begin
            state = 3'b111; end
        else if (state ===3'b100 && _input === 5'b00100) begin
            state = 3'b101; end
        else if (state === 3'b111 && _input === 5'b01010) begin
            state = 3'b100; end


        // 000-off  001-on  010-wrong1  011-wrong2  100-answer  101-reset   111-lock

    end



endmodule