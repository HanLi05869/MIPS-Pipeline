`timescale 1ns / 1ps

module mux_write(
		input out,
		input[31:0] alu_out,
		input[31:0] dm_out,
		output reg[31:0] write_data
	);

	always @(alu_out or dm_out or out)
		if (out == 1)
			write_data = dm_out; 
		else 
			write_data = alu_out;
endmodule