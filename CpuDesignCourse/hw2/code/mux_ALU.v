`timescale 1ns / 1ps

module mux_ALU(
		input[31:0] Rddata2, _imm,
		input ALUsrc,
		output reg[31:0] res
	);

	always @(Rddata2 or _imm)
	begin
		if (ALUsrc == 1) 
            res = _imm;
		else 
            res = Rddata2;
	end
endmodule