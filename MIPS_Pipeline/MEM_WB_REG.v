`timescale 1ns / 1ps

module MEM_WB_REG (
    input jalM,
    input regwriteM,
    input[1:0] MemtoRegM,
    input[31:0] aluoutM,
    input[31:0] readdataM,
    input[31:0] halfwordM,
    input[4:0] WriteRegM,
    input[31:0] byteM,
    input[31:0] PCplusM,
    input lowriteM,
    input hiwriteM,
    input mfloM,
    input mfhiM,
    input[31:0] Res_hiM,
    input[31:0] Res_loM,
    input[31:0] hi_loM,
    input clk,
    input ErrorFlush,
    input[31:0] CPout,
    input CPRd,

    output jalW,
    output regwriteW,
    output [1:0] memtoregW,
    output [31:0] aluoutW,
    output [31:0] readdataW,
    output [31:0] halfwordW,
    output [4:0] WriteRegW,
    output [31:0] byteW,
    output [31:0] PCplusW,
    output lowriteW,
    output hiwriteW,
    output mfloW,
    output mfhiW,
    output [31:0] Res_hiW,
    output [31:0] Res_loW,
    output [31:0] hi_loW,

    output[31:0] CPoutW,
    output CPRdW
);
    reg _jalW = 0;
    reg _regwriteW = 0;
    reg[1:0] _memtoregW = 0;
    reg[31:0] _aluoutW = 0;
    reg[31:0] _readdataW = 0;
    reg[31:0] _halfwordW = 0;
    reg[4:0] _WriteRegW = 0;
    reg[31:0] _byteW = 0;
    reg[31:0] _PCplusW = 0;
    reg _lowriteW = 0;
    reg _hiwriteW = 0;
    reg _mfloW = 0;
    reg _mfhiW = 0;
    reg[31:0] _Res_hiW = 0;
    reg[31:0] _Res_loW = 0;
    reg[31:0] _hi_loW = 0;
    reg[31:0] _CPout = 0;
    reg _CPRd = 0;

    always @(posedge clk) 
    begin
        if(~ErrorFlush)
        begin
            _jalW <= jalM;
            _regwriteW <= regwriteM;
            _memtoregW <= MemtoRegM;
            _aluoutW <= aluoutM;
            _readdataW <= readdataM;
            _halfwordW <= halfwordM;
            _WriteRegW <= WriteRegM;
            _byteW <= byteM;
            _PCplusW <= PCplusM;
            _lowriteW <= lowriteM;
            _hiwriteW <= hiwriteM;
            _mfloW <= mfloM;
            _mfhiW <= mfhiM;
            _Res_hiW <= Res_hiM;
            _Res_loW <= Res_loM;
            _hi_loW <= hi_loM;
            _CPout <= CPout;
            _CPRd <= CPRd;
        end
        else
        begin
            _jalW <= 0;
            _regwriteW <= 0;
            _memtoregW <= 0;
            _WriteRegW <= 0;
            _lowriteW <= 0;
            _hiwriteW <= 0;
            _mfloW <= 0;
            _mfhiW <= 0;
            _CPout <= 0;
            _CPRd <= 0;
        end
    end
    
        assign jalW = _jalW;
        assign regwriteW = _regwriteW;
        assign memtoregW = _memtoregW;
        assign aluoutW = _aluoutW;
        assign readdataW = _readdataW;
        assign halfwordW = _halfwordW;
        assign WriteRegW = _WriteRegW;
        assign byteW = _byteW;
        assign PCplusW = _PCplusW;
        assign lowriteW = _lowriteW;
        assign hiwriteW = _hiwriteW;
        assign mfloW = _mfloW;
        assign mfhiW = _mfhiW;
        assign Res_hiW = _Res_hiW;
        assign Res_loW = _Res_loW;
        assign hi_loW = _hi_loW;
        assign CPoutW = _CPout;
        assign CPRdW = _CPRd;
endmodule