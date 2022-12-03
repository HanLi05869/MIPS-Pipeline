`timescale 1ns / 1ps
module ALU(input [31:0] ReadData1,
            input [31:0] ReadData2,
            input [5:0] ALUOp,
            input[4:0] shamt,
            input usigned,//usigned number，pariticularly for slti, sltiu
            output reg[31:0] res,
            output reg zero);//not use this variable
        
        initial 
        begin
            res = 0;
            zero = 0;    
        end
        always @(*) 
        begin
            case(ALUOp)
                6'b000000:  res <= ((ReadData1) & (ReadData2));//and
                6'b000001:  res <= ReadData1 | ReadData2;//or
                6'b000010:  res <= ReadData1 + ReadData2;//+
                6'b000100:  res <= ReadData2 << shamt;//sll
                6'b000101:  res <= ReadData1 ^ ReadData2;//xor
                6'b000110:  res <= ~((ReadData1) | (ReadData2));//nor
                6'b000111:  res <= ReadData2 >> shamt;//srl
                6'b001000:  res <= $signed(ReadData2) >>> shamt;
                6'b010010:  res <= ReadData1 + (~ReadData2) + 1;//A-B
                6'b010011:  res <= usigned ? (ReadData1 < ReadData2 ? 1 : 0) : ($signed(ReadData1) < $signed(ReadData2) ? 1 : 0);//slt, usigned for sltu, else for signed, slt,slti
                6'b100100:  res <= ReadData2 << ReadData1[4:0];//sllv
                6'b100111:  res <= ReadData2 >> ReadData1[4:0];//srlv
                6'b101000:  res <= $signed(ReadData2) >>> ReadData1[4:0];
            endcase
            zero <= res == 0 ? 1 : 0;
        end
endmodule

