`timescale 1ns / 1ps
module NPC(
		input[31:0] muxinstr_3,
        input intrupt,
        output[31:0] next_pc
	);
    assign next_pc = intrupt ? 12'b1000_0000_0000 : muxinstr_3;
 endmodule
