`timescale 1ns / 1ps

module EX_MEM_REG (
    input jalE,
    input regwriteE,
    input[1:0] MemtoRegE,//1:0
    input lbuE,
    input lhuE,
    input MemWriteE,
    input[1:0] Sh_bE,//1:0
    input clk,
    input lowriteE,
    input hiwriteE,
    input mfloE,
    input mfhiE,
    input[31:0] Res_hiE,
    input[31:0] Res_loE,
    input[31:0] hi_loE,

    input[31:0] aluoutE,
    input[31:0] RD2,
    input[4:0] WriteRegE,
    input[31:0] PCplusE,

    input ErrorFlush,
    input CPWtE,
    input CPRdE,
    input[4:0] rdE,
    //OUPUT
    output  jalM,
    output  regwriteM,
    output [1:0] MemtoRegM,//1:0
    output  lbuM,
    output  lhuM,
    output  MemWriteM,
    output [1:0] Sh_bM,//1:0
    output  lowriteM,
    output  hiwriteM,
    output  mfloM,
    output  mfhiM,
    output CPWtM,
    output CPRdM,
    output[4:0] rdM,

    
    output [31:0] Res_hiM,
    output [31:0] Res_loM,
    output [31:0] hi_loM,
    output [31:0] aluoutM,
    output [31:0] writedataM,
    output [4:0] WriteRegM,
    output [31:0] PCplusM
);
    reg _jalM = 0;
    reg _regwriteM = 0;
    reg[1:0] _MemtoRegM = 0;//1:0
    reg _lbuM = 0;
    reg _lhuM = 0;
    reg _MemWriteM = 0;
    reg[1:0] _Sh_bM = 0;//1:0
    reg _lowriteM = 0;
    reg _hiwriteM = 0;
    reg _mfloM = 0;
    reg _mfhiM = 0;

    reg[31:0] _Res_hiM = 0;
    reg[31:0] _Res_loM = 0;
    reg[31:0] _hi_loM = 0;
    reg[31:0] _aluoutM = 0;
    reg[31:0] _writedataM = 0;
    reg[4:0] _WriteRegM = 0;
    reg[31:0] _PCplusM  = 0;
    reg[4:0] _rdM = 0;
    reg _CPWtM = 0;
    reg _CPRdM = 0;
    initial begin
        _jalM = 0; 
        _regwriteM = 0; 
        _MemtoRegM = 0; //1:0
        _lbuM = 0; 
        _lhuM = 0;
         _MemWriteM = 0;
        _Sh_bM = 0; //1:0
        _lowriteM = 0; 
        _hiwriteM = 0;
        _mfloM = 0;
        _mfhiM = 0;

        _Res_hiM = 0;
        _Res_loM = 0;
        _hi_loM = 0;
        _aluoutM = 0;
        _writedataM = 0;

        _WriteRegM = 0;
        _PCplusM = 0;
    end
    always @(posedge clk) 
    begin
        if(~ErrorFlush)//not nop
        begin
            _jalM <= jalE; 
            _regwriteM <= regwriteE; 
            _MemtoRegM <= MemtoRegE; //1:0
            _lbuM <= lbuE; 
            _lhuM <= lhuE;
            _MemWriteM <= MemWriteE;
            _Sh_bM <= Sh_bE; //1:0
            _lowriteM <= lowriteE; 
            _hiwriteM <= hiwriteE;
            _mfloM <= mfloE;
            _mfhiM <= mfhiE;

            _Res_hiM <= Res_hiE;
            _Res_loM <= Res_loE;
            _hi_loM <= hi_loE;
            _aluoutM <= aluoutE;
            _writedataM <= RD2;

            _WriteRegM <= WriteRegE;
            _PCplusM <= PCplusE;

            _CPWtM <= CPWtE;
            _CPRdM <= CPRdE;
            _rdM <= rdE;
        end
        else
        begin//写信号清空
            _jalM <= 0; 
            _regwriteM <= 0; 
            _MemtoRegM <= 0; //1:0
            _lbuM <= 0; 
            _lhuM <= 0;
            _MemWriteM <= 0;
            _Sh_bM <= 0; //1:0
            _lowriteM <= 0; 
            _hiwriteM <= 0;
            _mfloM <= 0;
            _mfhiM <= 0;

            _CPWtM <= 0;
            _CPRdM <= 0;
            _rdM <= 0;
        end
    end
    //always @(negedge clk) 
    //begin
    assign jalM  =  _jalM; 
    assign regwriteM  =  _regwriteM; 
    assign MemtoRegM  =  _MemtoRegM; //1:0
    assign lbuM  =  _lbuM; 
    assign lhuM  =  _lhuM;
    assign MemWriteM   =  _MemWriteM;
    assign Sh_bM  =  _Sh_bM; //1:0
    assign lowriteM  =  _lowriteM; 
    assign hiwriteM  =  _hiwriteM;
    assign mfloM  =  _mfloM;
    assign mfhiM  =  _mfhiM;

    assign Res_hiM  =  _Res_hiM;
    assign Res_loM  =  _Res_loM;
    assign hi_loM  =  _hi_loM;
    assign aluoutM  =  _aluoutM;
    assign writedataM  =  _writedataM;

    assign WriteRegM  =  _WriteRegM;
    assign PCplusM  =  _PCplusM;

    assign CPWtM = _CPWtM;
    assign CPRdM = _CPRdM;
    assign rdM =  _rdM;
    //end
endmodule