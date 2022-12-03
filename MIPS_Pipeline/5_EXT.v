`timescale 1ns / 1ps
module EXT(
        input[15:0] A,
        output reg[31:0] signextend,zeroextend,upperimm
    );
    reg[31:0] tmp;
    initial begin
        signextend = 0;
        zeroextend = 0;
        upperimm = 0;
    end
    always @(*) 
    begin
        signextend <= $signed(A);
        zeroextend <= {16'h0000,A};
        upperimm <= A << 16;
    end
endmodule

module pcbranch (
    input [31:0] signimmD,
    input[31:0] PCplusD,
    output reg[31:0] PCbranchD
);
    reg[31:0] signimmshiftD;
    always @(*) 
    begin
        PCbranchD <= 0;
        signimmshiftD <= signimmD << 2;
        PCbranchD <= signimmshiftD + PCplusD;
    end
endmodule

module pcjmp(
    input[31:0] PCplusD,
    input[31:0] instrD,
    output reg[31:0] PCjmpD
);
    reg[31:0] tmp;
    always @(*) 
    begin
        PCjmpD <= 0;
        tmp = instrD << 2;
        PCjmpD <= {PCplusD[31:28], tmp[27:0]};
    end
endmodule
    