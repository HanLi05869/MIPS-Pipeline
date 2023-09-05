`timescale 1ns / 1ps

module DM(
		input[11:2] addr,
		input[31:0] data,//data
		input clk, in_enable, out_enable,
		output reg[31:0] data_out
	);
	reg[31:0] dm[1023:0];
	integer i;
	always @(addr or out_enable)
		if (out_enable) 
            data_out = dm[addr];

	always @(posedge clk)
	begin
		if (in_enable == 1) 
            dm[addr] = data;
		if (out_enable == 1) 
            data_out = dm[addr];
	end

	initial
	begin
		for (i = 0; i < 1024; i += 1) 
			dm[i] = 0;
		data_out = 0;
	end
endmodule
