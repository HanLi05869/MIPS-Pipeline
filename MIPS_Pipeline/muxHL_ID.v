`timescale 1ns / 1ps

module muxHL_ID (
    input[31:0] Res_hiM,
    input[31:0] Res_hiE,
    input[31:0] hiout,
    input[1:0] forwardhi,
    input[1:0] forwardlo,
    input[31:0] loout,
    input[31:0] res_loE,
    input[31:0] res_loM,
    input mfhiD,
    input mfloD,
    output reg[31:0] hi_loD
);
    initial begin
        hi_loD = 0;
    end
    reg[31:0] hiD;
    reg[31:0] loD;
    always @(*) 
    begin
        case (forwardhi)
            2: hiD <= Res_hiM;
            1: hiD <= Res_hiE;
            0: hiD <= hiout;
        endcase

        case (forwardlo)
            0: loD <= loout;
            1: loD <= res_loE;
            2: loD <= res_loM;
        endcase    

        if(mfhiD)
            hi_loD <= hiD;
        if(mfloD)
            hi_loD <= loD;
    end
    initial begin
        hiD = 0;
        loD = 0;
    end
endmodule