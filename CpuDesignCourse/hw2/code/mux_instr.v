`timescale 1ns / 1ps

module mux_instr(
		input[25:0] im_outs,
		input[31:28] pc_s,
		input[31:0] Rddata1,
		input JR,
		output reg[31:2] instr
	);
	reg[31:0] temp;
	always @(*)
	begin
		if (JR == 1) 
            instr = Rddata1[31:2];//JR指令
		else 
            //instr = {pc_s, im_outs, 2'b00};//J指令
			instr = {pc_s, im_outs};//J指令
	temp = instr;
	end
endmodule