`timescale 1ns / 1ps
module ID_EX_REG (
    input jal,
    input regwriteD,
    input[1:0] MemtoRegD,
    input lbuD,
    input lhuD,
    input MemWriteD,
    input[1:0] Sh_bD,
    input[1:0] alusrc,
    input [31:0] AD,
    input [31:0] BD,
    input [4:0] WriteRegD,
    input[10:6] shamtD,
    input[31:0] signimmD,
    input[31:0] zeroimmD,
    input[31:0] upperimmD,
    input[31:0] PCplusD,
    input stallE,
    input clk,
    input jalr,
    input [5:0] ALUControl,
    input usigned,
    input signD,
    input mulD,
    input divD,
    input mtloD,
    input mthiD,
    input lowriteD,
    input hiwriteD,
    input mfloD,
    input mfhiD,
    input[31:0] hi_loD,
    input CPWtD,
    input CPRdD,
    input[4:0] rdD,
    input[4:0] rtD,

    output [31:0] PCplusE,
    output [31:0] upperimmE,
    output [31:0] zeroimmE,
    output [31:0] signimmE,
    output [10:6] shamtE,
    output [4:0] WriteRegE,
    output [31:0] AE,
    output [31:0] BE,
    output  jalE,
    output  regwriteE,
    output [1:0] MemtoRegE,
    output  lbuE,
    output  lhuE,
    output  MemWriteE,
    output [1:0] Sh_bE,
    output [1:0] alusrcE,

    output [5:0] ALUControlE,
    output  usignedE,

    output  signE,
    output  mulE,
    output  divE,
    output  mtloE,
    output  mthiE,
    output  lowriteE,
    output  hiwriteE,
    output  mfloE,
    output  mfhiE,
    output [31:0] hi_loE,
    output CPWtE,
    output CPRdE,
    output[4:0] rdE,
    output[4:0] rtE
);


    reg[31:0] _PCplusE = 0;
    reg[31:0] _upperimmE = 0;
    reg[31:0] _zeroimmE = 0;
    reg[31:0] _signimmE = 0;
    reg[10:6] _shamtE = 0;
    reg[4:0] _WriteRegE = 0;
    reg[31:0] _AE = 0;
    reg[31:0] _BE = 0;
    reg _jalE = 0;
    reg _regwriteE = 0;
    reg[1:0] _MemtoRegE = 0;
    reg _lbuE = 0;
    reg _lhuE = 0;
    reg _MemWriteE = 0;
    reg[1:0] _Sh_bE = 0;
    reg[1:0] _alusrcE = 0;

    reg[5:0] _ALUControlE = 0;
    reg _usignedE = 0;

    reg _signE = 0;
    reg _mulE = 0;
    reg _divE = 0;
    reg _mtloE = 0;
    reg _mthiE = 0;
    reg _lowriteE = 0;
    reg _hiwriteE = 0;
    reg _mfloE = 0;
    reg _mfhiE = 0;
    reg[31:0] _hi_loE = 0;
    reg _CPWtE = 0;
    reg _CPRdE = 0;
    reg[4:0] _rdE = 0;
    reg[4:0] _rtE = 0;
    always @(posedge clk) 
    begin
        if(~stallE)
        begin
            _jalE <= jal | jalr;
            _regwriteE <= regwriteD;
            _MemtoRegE <= MemtoRegD;
            _lbuE <= lbuD;
            _lhuE <= lhuD;
            _MemWriteE <= MemWriteD;
            _Sh_bE <= Sh_bD;
            _alusrcE <= alusrc;

            _PCplusE <= PCplusD;
            _upperimmE <= upperimmD;
            _zeroimmE <= zeroimmD;
            _signimmE <= signimmD;
            _shamtE <= shamtD;
            _WriteRegE <= WriteRegD;
            _AE <= AD;
            _BE <= BD;

            
            _ALUControlE <= ALUControl; 
            _usignedE <= usigned;

            _signE <= signD;
            _mulE <= mulD;
            _divE <= divD;
            _mtloE <= mtloD;
            _mthiE <= mthiD;
            _lowriteE <= lowriteD;
            _hiwriteE <= hiwriteD;
            _mfloE <= mfloD;
            _mfhiE <= mfhiD;

            _hi_loE <= hi_loD;

            _CPWtE <= CPWtD;
            _CPRdE <= CPRdD;
            _rdE <= rdD;
            _rtE <= rtD;
        end
        else
        begin
            _jalE <= 0;
            _regwriteE <= 0;
            _MemtoRegE <= 0;
            _lbuE <= 0;
            _lhuE <= 0;
            _MemWriteE <= 0;
            _Sh_bE <= 0;
            _alusrcE <= 0;

            _PCplusE <= 0;
            _upperimmE <= 0;
            _zeroimmE <= 0;
            _signimmE <= 0;
            _shamtE <= 0;
            _WriteRegE <= 0;
            _AE <= 0;
            _BE <= 0;

            
            _ALUControlE <= 0; 
            _usignedE <= 0;

            _signE <= 0;
            _mulE <= 0;
            _divE <= 0;
            _mtloE <= 0;
            _mthiE <= 0;
            _lowriteE <= 0;
            _hiwriteE <= 0;
            _mfloE <= 0;
            _mfhiE <= 0;

            _hi_loE <= 0;

             _CPWtE <= 0;
            _CPRdE <= 0;
            _rdE <= 0;
            _rtE <= 0;
        end
    end

    assign PCplusE = _PCplusE;
    assign upperimmE = _upperimmE;
    assign zeroimmE = _zeroimmE;
    assign signimmE = _signimmE;
    assign shamtE = _shamtE;
    assign WriteRegE = _WriteRegE;
    assign AE = _AE;
    assign BE = _BE;
    assign jalE = _jalE;
    assign regwriteE = _regwriteE;
    assign MemtoRegE = _MemtoRegE;
    assign lbuE = _lbuE;
    assign lhuE = _lhuE;
    assign MemWriteE = _MemWriteE;
    assign Sh_bE = _Sh_bE;
    assign alusrcE = _alusrcE;

    assign ALUControlE = _ALUControlE;
    assign usignedE = _usignedE;

    assign signE = _signE;
    assign mulE = _mulE;
    assign divE = _divE;
    assign mtloE = _mtloE;
    assign mthiE = _mthiE;
    assign lowriteE = _lowriteE;
    assign hiwriteE = _hiwriteE;
    assign mfloE = _mfloE;
    assign mfhiE = _mfhiE;
    assign hi_loE = _hi_loE;

    assign CPRdE = _CPRdE;
    assign CPWtE = _CPWtE;
    assign rdE = _rdE;
    assign rtE = _rtE;
endmodule