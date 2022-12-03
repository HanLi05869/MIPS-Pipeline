`timescale 1ns/1ps

module PC(
		input[31:0] next_pc,
		input reset, clk,
        input stallF,
		output reg[31:0] pc,
        output reg[31:0] PCplus
	);
    
    always @(posedge clk)
    begin
        if (reset == 1) 
            pc = {30'h00003000,2'b00};//pc = 30'b0000_0000_0000_0000_0011_0000_0000_00;
		else if(stallF)
            pc = pc;//stall PC
        else
            pc = next_pc;
        PCplus <= pc + 4;
    end

    initial begin
        pc = {30'h00003000,2'b00};
    end
endmodule