`timescale 1ns / 1ps

module IM(
		input[31:0] addr,
		output reg[31:0] IS
	);
	reg[31:0] im[32767:0];
	integer i;
	always @(*)
	begin
		IS = im[addr[11:2]];
	end

    
    /*initial begin
        
    end*/
    
	//test
	initial
	begin
		for(i = 0; i < 32767; i += 1) 
			im[i] = 0;
		$readmemb("TESTCODE.txt", im, 0);
	end
    
endmodule