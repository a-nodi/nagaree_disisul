/* CSED273 Final project */

`timescale 1ns / 1ps

module StateManager(
    input is_on, is_star_pressed, reset, correct, initialize,
    output reg [2:0] state
);
    reg [4:0] _input;

    initial begin
        state = 3'b000;
    end

    always @(is_on, is_star_pressed, reset, correct, initialize) begin
        _input[4] <= is_on;                                             //#이 눌릴때가 1, 안눌릴때가 0이 아니라, 한번 눌렀다 떼면 1, 다시 눌렀다 뗴면 0 (reg)
        _input[3] <= is_star_pressed;                                   //* 이 눌린상태가 1 안눌리면 0 (wire)
        _input[2] <= reset;                                             //재설정 버튼이 눌린상태가 1, 안눌리면 0 (wire)
        _input[1] <= correct;                                           //correct인 상태는 1, 아니면 0 (reg)
        _input[0] <= initialize;                                        //초기화 버튼이 눌린상태가 1, 안눌리면 0 (wire)

        // State = 000
        if (_input === 5'bxxxx1) begin                                  //언제든지 초기화가 눌리면 off(000)으로
            state = 3'b000; end 
        else if (state === 3'b000 && _input === 5'b1xxxx) begin         //off일때 is_on이 1이 되면-> on(001) 으로 
            state = 3'b001; end
        else if (state === 3'b001 && _input === 5'b0xxxx) begin         //on일때 is_on이 0이되면-> 다시 off(000) 으로
            state = 3'b000; end
        else if (state === 3'b001 && _input === 5'b11010) begin         //on일때 재설정, 초기화가 0이고, correct가 1인 상태에서 *이 눌리면 -> answer(100)으로
            state = 3'b100; end
        else if (state === 3'b001 && _input === 5'b11000) begin         //on일때 재설정, 초기화가 0이고, correct도 0인 상태에서 *이 눌리면 -> wrong1(010)으로
            state = 3'b010; end
        else if (state === 3'b010 && _input === 5'b11010) begin         //wrong1일때 재설정, 초기화가 0이고, correct가 1인 상태에서 *이 눌리면 -> answer(100)으로
            state = 3'b100; end
        else if (state === 3'b010 && _input === 5'b11000) begin        //wrong1일때 재설정, 초기화가 0이고, correct도 0인 상태에서 *이 눌리면 -> wrong2(011)으로
            state = 3'b011; end
        else if (state === 3'b011 && _input === 5'b11010) begin        //wrong2일때 재설정, 초기화가 0이고, correct가 1인 상태에서 *이 눌리면 -> answer(100) 으로
            state = 3'b100; end
        else if (state === 3'b011 && _input === 5'b11000) begin         //wrong2일때 재설정, 초기화가 0이고, correct도 0인 상태에서 *이 눌리면 -> lock(111) 으로
            state = 3'b111; end
        else if (state ===3'b100 && _input === 5'b101x0) begin          //open 일때 reset이 눌리면 -> reset(101)으로
            state = 3'b101; end
        else if (state === 3'b101 && _input === 5'b11010) begin         //reset 일때 correct가 1인 상태(reset 상태일때 correct는 새로운 번호가 4개 이상 입력되었는지를 의미한다.)에서 *이 눌리면 -> off(000) 으로
            state = 3'b000; end


        // 000-off  001-on  010-wrong1  011-wrong2  100-answer  101-reset   111-lock

    end



endmodule