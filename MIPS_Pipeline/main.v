`timescale 1ns / 1ps

`include "mips.v"

module main;

    reg  reset,clk;   
    mips mips(.reset(reset),.clk(clk));

	initial
	begin
		clk = 0;
		reset = 1;
		#30 reset = 0;
	end
	
	initial
    begin
        $dumpfile("main.vcd");
        $dumpvars(0, main);
        #10000 $finish;
    end

	always 
	begin
		#20 clk = ~clk;
	end
endmodule
