`timescale 1ns / 1ps

module controller(
                input[5:0] func,op,
                output reg RegDst,ALUsrc, MemtoReg, RegWrite, MemWrite, extop, ifbeq, luiop, JAL, J, JR,
                output reg[1:0] aluop,
                output reg slt_op//小于则置位
	);
	reg addu, subu, ori, lw, sw, beq, lui, addi, slt, j, jal, jr;

	always @(func or op)
	begin
                addu = 0; addi = 0; subu = 0; ori = 0;
                lw = 0; sw = 0; beq = 0; lui = 0;
                slt = 0; j = 0; jal = 0; jr = 0; 
                RegDst = 0;
                ALUsrc = 0;
                MemtoReg = 0;
                RegWrite = 0;
                MemWrite = 0;
                extop = 0;
                ifbeq = 0;
                luiop = 0;
                JAL = 0;
                J = 0;
                JR = 0;

                extop = 1; slt_op = 0;

                if ((op == 6'b0) && (func == 6'b100001)) 
                        addu=1;
    		else if ((op == 6'b0) && (func == 6'b100011)) 
                        subu=1;
                else if((op == 6'b001101))
                        ori = 1;
                else if ((op == 6'b100011))
                        lw = 1;
                else if ((op == 6'b101011))
                        sw = 1;
                else if ((op == 6'b000100))
                begin
                        beq = 1;
                        /*$display("GPR[9]——:%d", GPR.gpr[9]);
                        $display("GPR[6]——:%d", GPR.gpr[6]);*/
                end	
                else if ((op == 6'b001111))
                        lui = 1;	
                else if ((op == 6'b001000) || (op == 6'b001001)) 
                        addi = 1;
                else if ((op == 6'b000000) && (func == 6'b101010)) 
                        slt = 1;
                else if ((op == 6'b000010))
                        j = 1;
                else if ((op == 6'b000011)) 
                        jal = 1;
                else if ((op == 6'b000000) && (func == 6'b001000)) 
                        jr = 1;


                if (lui == 1) 
                        luiop = 1;
                if (lui == 1) 
                        extop = 0;
                if ((addu == 1) || (subu == 1) || (slt == 1)) 
                        RegDst = 1;
                if ((addu == 1) || (subu == 1) || (lui == 1) || (lw == 1) || (ori == 1) || (addi == 1) || (jal == 1) || (slt == 1)) 
                        RegWrite=1;
                if ((lui == 1) || (ori == 1) || (lw == 1) || (sw == 1) || (addi == 1)) 
                        ALUsrc = 1;
                if (beq == 1) 
                        ifbeq = 1;
                if (sw == 1) 
                        MemWrite = 1;
                if (lw == 1) 
                        MemtoReg=1;
                if ((addu == 1) || (lw == 1) || (sw == 1) || (addi == 1) || (lui == 1)) 
                        aluop = 3;//3加法
                if ((subu == 1) || (beq == 1) || (slt == 1)) 
                        aluop = 2;//2减法
                if (ori == 1) 
                        aluop = 1;//
                if (slt == 1) 
                        slt_op = 1;
                if ((j == 1) || (jal == 1) || (jr == 1)) 
                        J = 1;//都要跳转
                if (jal == 1) 
                        JAL = 1;
                if (jr == 1) 
                        JR = 1;
	end
endmodule