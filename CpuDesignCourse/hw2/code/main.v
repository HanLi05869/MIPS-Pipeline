`timescale 1ns / 1ps

`include "mips.v"

module main;

    reg  reset,clk;   
    mips mips(.reset(reset),.clk(clk));

	initial
	begin
		clk = 0;
		reset = 1;
		#6 reset = 0;
		#300 $finish;
	end

	always 
	begin
		#5 clk = ~clk;
	end

    initial
    begin
        $dumpfile("main.vcd");
        $dumpvars(0, main);
        #10000000 $finish;
    end



	/*always 
	begin
		#5 clk = ~clk;
	end*/
endmodule
