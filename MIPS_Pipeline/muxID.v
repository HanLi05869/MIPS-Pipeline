`timescale 1ns / 1ps

module Forwarda (
    input[31:0] hi_loM,
    input[31:0]  hi_low,
    input[31:0]  byteM,
    input[31:0]  halfdataM,
    input[31:0]  readdataM,
    input[31:0]  aluoutM,
    input[31:0]  aluoutE,
    input[31:0] A,
    input[2:0] op,
    output reg[31:0] res
);
    always @(*) 
    begin
        case (op)
            7: res <= hi_loM;
            6: res <= hi_low;
            5: res <= byteM;
            4: res <= halfdataM;
            3: res <= readdataM;
            2: res <= aluoutM;
            1: res <= aluoutE;
            0: res <= A;
        endcase
    end
    initial begin
        res = 0;
    end
endmodule

module Forwardb (
    input[31:0] hi_loM,
    input[31:0]  hi_low,
    input[31:0]  byteM,
    input[31:0]  halfdataM,
    input[31:0]  readdataM,
    input[31:0]  aluoutM,
    input[31:0]  aluoutE,
    input[31:0] B,
    input[2:0] op,
    output reg[31:0] res
);
    always @(*) 
    begin
        case (op)
            7: res <= hi_loM;
            6: res <= hi_low;
            5: res <= byteM;
            4: res <= halfdataM;
            3: res <= readdataM;
            2: res <= aluoutM;
            1: res <= aluoutE;
            0: res <= B;
        endcase

    end
    initial begin
        res = 0;
    end
endmodule

module Regdst (
    input[1:0] regdst,
    input[4:0] rtD,
    input[4:0] rdD,
    input mfc0D,
    output reg[4:0] WriteRegD
);
    always @(*) 
    begin
        case (regdst)
            0: WriteRegD <= rtD;
            1: WriteRegD <= rdD;
            2: WriteRegD <= 5'b11111;
        endcase   
        if(mfc0D)
            WriteRegD <= rtD;
    end
    initial begin
        WriteRegD = 0;
    end
endmodule

module smallALU (
    input blez,
    input bltz,
    input bgtz,
    input bgez,
    input branchne,
    input branch,
    input[31:0] A,
    input[31:0] B,
    output reg PCSrcD
    //output PCSrcD
);
    reg lezD = 0;
    reg gezD = 0;
    reg ltzD = 0;
    reg gtzD = 0;
    reg equalD = 0;
    reg isAzero = 0;
    always @(*) 
    begin
        ltzD <= $signed(A) < 0 ? 1 : 0;
        gtzD <= $signed(A) > 0 ? 1 : 0;
        equalD <= A^B ? 0 : 1;
        isAzero <= A == 0 ? 1 : 0;
        PCSrcD <= (branch & equalD) | (bgtz & gtzD) | (bgez & (gtzD | isAzero)) | (bltz & ltzD) | (blez & (ltzD | isAzero)) | (branchne & (~equalD));
    end
endmodule