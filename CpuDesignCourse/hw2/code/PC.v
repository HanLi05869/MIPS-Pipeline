`timescale 1ns/1ps

module PC(
		input[31:2] next_pc,
		input reset, clk,
		output reg[31:2] pc
	);
    
    always @(posedge clk)
    begin
        if (reset == 1) 
            pc <= 30'h00003000;//pc = 30'b0000_0000_0000_0000_0011_0000_0000_00;
		else 
            pc <= next_pc;
    end
endmodule