`timescale 1ns / 1ps

module DM(
		input[31:0] addr,//aluout
		input[31:0] data,//writedataM
        input[1:0] Sh_bM,
        input MemWriteM,
		input clk,
		output [31:0] data_out
    );
	reg[31:0] dm[0:2047];//
	integer i;
    wire[7:0] data_b;
    wire[15:0] data_h;
    assign data_b = data[7:0];
    assign data_h = data[15:0];



    assign data_out = dm[addr[12:2]];
	always @(posedge clk)
	begin
		if(MemWriteM && Sh_bM == 3)//sw 
            dm[addr[12:2]] <= data;
        else if(MemWriteM && Sh_bM == 1)//sh
        begin
            if(addr[1])//00 01 10 11
                dm[addr[12:2]][31:16] <= data_h;
            else if(!addr[1])
                dm[addr[12:2]][15:0] <= data_h;
        end
        else if(MemWriteM && Sh_bM == 0)//sb
        begin
            if(addr[1] && addr[0])//11
                dm[addr[12:2]][31:24] <= data_b;
            if(addr[1] && (~addr[0]))//10
                dm[addr[12:2]][23:16] <= data_b;
            if((~addr[1]) && addr[0])//01
                dm[addr[12:2]][15:8] <= data_b;
            if((~addr[1]) && (~addr[0]))//00
                dm[addr[12:2]][7:0] <= data_b; 
        end

        
	end
	initial
	begin
		for (i = 0; i < 2048; i += 1) 
			dm[i] = 0;
	end
endmodule

module halfword (
    input[31:0] data_out,
    input[31:0] aluoutM,
    input lhu,
    output reg[31:0] halfwordM
);
    wire[15:0] data_low,data_high;
    assign data_low = data_out[15:0];
    assign data_high = data_out[31:16];
    reg[15:0] tmp;
    reg[31:0] tmp_sign;
    reg[31:0] tmp_zero;
    always @(*) 
    begin
        tmp <= aluoutM[1] ? data_high : data_low;
        halfwordM <= lhu ? {16'b0000_0000_0000_0000,tmp} : $signed(tmp);
    end
    initial begin
        halfwordM = 0;
    end
endmodule

module byteWord (
    input[31:0] data_out,
    input[31:0] aluoutM,
    input lbu,
    output reg[31:0] byteM
);
    wire[7:0] data_0,data_1,data_2,data_3;
    assign data_0 = data_out[7:0];
    assign data_1 = data_out[15:8];
    assign data_2 = data_out[23:16];
    assign data_3 = data_out[31:24];

    reg[15:0] tmp = 0;
    reg[31:0] tmp_sign = 0;
    reg[31:0] tmp_zero = 0;
    always @(*) 
    begin
        case(aluoutM[1:0])
            0: tmp <= data_0;
            1: tmp <= data_1;
            2: tmp <= data_2;
            3: tmp <= data_3; 
        endcase
        byteM <= lbu ? {24'b0000_0000_0000_0000_0000_0000,tmp} : $signed(tmp);
    end

    initial begin
        byteM = 0;
    end
endmodule