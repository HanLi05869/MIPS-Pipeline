`timescale 1ns / 1ps
`include "ALU.v"
`include "controller.v"
`include "DM.v"
`include "EXT.v"
`include "GPR.v"
`include "IM.v"
`include "NPC.v"
`include "PC.v"
`include "mux_ALU.v"
`include "mux_GPR.v"
`include "mux_instr.v"
`include "mux_write.v"

//module main;
module mips(reset,clk);
	input reset,clk;
	//IF
	wire[31:2] next_pc, pc;
	wire[11:2] add_im;
	wire[31:0] im_out;
	wire[25:0] im_outs; //低26位
	wire[31:28] pc_high;
	wire[31:2] pc_plus, instr;
	//ID
	wire[5:0] func,op;
	wire[15:0] imm_low16;
	wire[4:0]  rs, rt, rd;
	wire[4:0]  RegRd1, RegRd2, A3;
	wire[31:0] read_data1, read_data2, write_data;
	wire[31:0] _imm_extend;
	//signal
	wire[1:0] aluop;
	wire zero, RegWrite, ALUsrc, ifbeq;
	wire MemWrite, MemtoReg, RegDst, extop, luiop, slt_op, J, JR, JAL;
	//EXE
	wire[31:0] b;
	wire[31:0] alu_res;
	//MEM
	wire[11:2] add_dm;
	wire[31:0] dm_data, MEMout;
	//reg clk,reset;

	controller controller(.func(func), .op(op), .RegDst(RegDst),.ALUsrc(ALUsrc),.MemtoReg(MemtoReg),.RegWrite(RegWrite),.MemWrite(MemWrite),
		.extop(extop), .ifbeq(ifbeq), .luiop(luiop), .JAL(JAL), .J(J), .JR(JR), .aluop(aluop), .slt_op(slt_op));

	ALU ALU(.a(read_data1), .b(b), .op(aluop), .sum(alu_res));

	NPC NPC(.ifbeq(ifbeq), .IsZero(alu_res), .J(J), .offset(imm_low16), .instr(instr), .now_pc(pc), .next_pc(next_pc));

	PC PC(.next_pc(next_pc), .reset(reset), .clk(clk), .pc(pc));

	IM IM(.addr(add_im), .IS(im_out));

	mux_GPR mux_GPR(.rt(rt), .rd(rd), .RegDst(RegDst), .A3(A3));

	GPR GPR(.Regwrite(RegWrite), .JAL(JAL), .pc_plus(pc_plus), .clk(clk), .Reset(reset), .slt_op(slt_op), 
	.Rddata1(read_data1), .Rddata2(read_data2), .Regrd1(RegRd1), .Regrd2(RegRd2), .Regwt(A3), .Wddata(write_data));
	
	EXT EXT(.extop(extop), .luiop(luiop), .A(imm_low16), .res(_imm_extend));
	
	mux_ALU mux_ALU(.Rddata2(read_data2), ._imm(_imm_extend), .ALUsrc(ALUsrc), .res(b));
	
	DM DM(.addr(add_dm), .data(dm_data), .clk(clk), .in_enable(MemWrite), .out_enable(MemtoReg), .data_out(MEMout));
	
	mux_write mux_write(.alu_out(alu_res), .out(MemtoReg), .dm_out(MEMout), .write_data(write_data));

	mux_instr mux_instr(.im_outs(im_outs), .pc_s(pc_high), .Rddata1(read_data1), .JR(JR), .instr(instr));
	
	//IF
	assign add_im = pc[11:2];
	assign im_outs = im_out[25:0];
	assign pc_high = pc[31:28];
	assign pc_plus = pc + 1;
	//ID
	assign rs = im_out[25:21];
	assign rt = im_out[20:16];
	assign rd = im_out[15:11];
	assign op = im_out[31:26];
	assign func = im_out[5:0];
	assign imm_low16 = im_out[15:0];
	//GPR接的
	assign RegRd1 = rs; 
	assign RegRd2 = rt;
	//DM input
	assign add_dm = alu_res[11:2];//去DM寻址用
	assign dm_data = read_data2;

	/*initial
	begin
		clk = 0;
		reset = 1;
		#6 reset = 0;
		#100 $finish;
	end


	always 
	begin
		#5 clk = ~clk;
	end
*/
	//test
	always @(GPR.gpr[1])
		$display("GPR[1]:%d", GPR.gpr[1]);
	always @(GPR.gpr[2])
		$display("GPR[2]:%d", GPR.gpr[2]);
	always @(GPR.gpr[3])
		$display("GPR[3]:%d", GPR.gpr[3]);
	always @(GPR.gpr[4])
		$display("GPR[4]:%d", GPR.gpr[4]);
	always @(GPR.gpr[5])
		$display("GPR[5]:%d", GPR.gpr[5]);
	always @(GPR.gpr[6])
		$display("GPR[6]:%d", GPR.gpr[6]);
	always @(GPR.gpr[7])
		$display("GPR[7]:%d", GPR.gpr[7]);
	always @(GPR.gpr[8])
		$display("GPR[8]:%d", GPR.gpr[8]);
	always @(GPR.gpr[9])
		$display("GPR[9]:%d", GPR.gpr[9]);
	always @(GPR.gpr[10])
		$display("GPR[10]:%d", GPR.gpr[10]);
	always @(GPR.gpr[11])
		$display("GPR[11]:%d", GPR.gpr[11]);
	always @(GPR.gpr[12])
		$display("GPR[12]:%d", GPR.gpr[12]);
	always @(GPR.gpr[13])
		$display("GPR[13]:%d", GPR.gpr[13]);
	always @(GPR.gpr[14])
		$display("GPR[14]:%d", GPR.gpr[14]);
	always @(GPR.gpr[15])
		$display("GPR[15]:%d", GPR.gpr[15]);
	always @(GPR.gpr[31])
		$display("GPR[31]:%d", GPR.gpr[31]);	
	/*initial
	begin
		$dumpfile("main.vcd");
		$dumpvars(0, IM);
		$dumpvars(0, DM);
		$dumpvars(0, ALU);
		$dumpvars(0, GPR);
		$dumpvars(0, controller);
	end*/

endmodule