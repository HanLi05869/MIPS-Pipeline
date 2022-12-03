`timescale 1ns / 1ps

module muxWB (
    input[31:0] aluoutW,
    input[31:0] readdataW,
    input[31:0] halfwordW,
    input[31:0] byteW,
    input[1:0] MemtoRegW,
    input mfloW,
    input mfhiW,
    input[31:0] hi_loW,
    output reg[31:0] Reg_resW
);
    reg[31:0] resultW;
    reg tmp = 0;
    always @(*) 
    begin
        case (MemtoRegW)
            0: resultW <= aluoutW;
            1: resultW <= readdataW;
            2: resultW <= halfwordW;
            3: resultW <= byteW;
        endcase   
        tmp <= mfloW | mfhiW;
        Reg_resW <= tmp ? hi_loW : resultW;
    end
    initial begin
        Reg_resW = 0;
    end
endmodule