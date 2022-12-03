`timescale 1ns / 1ps

module MDunit (
    input[31:0] AE,
    input[31:0] BE,
    input signE,
    input mulE,
    input divE,
    input mthiE,
    input mtloE,
    output reg[31:0] Res_hiE,
    output reg[31:0] Res_loE
);
    initial begin
        Res_hiE = 0;
        Res_loE = 0;
    end
    reg[63:0] res = 0;
    always @(*) 
    begin
        if(mulE)
        begin
            if(signE)//unsign
                res <= {32'b0000_0000_0000_0000_0000_0000_0000_0000,AE} * {32'b0000_0000_0000_0000_0000_0000_0000_0000,BE};
            else   
                res <= AE * BE;
        end
        else if(divE)
        begin
            if(signE)
            begin
                res[31:0] <= {32'b0000_0000_0000_0000_0000_0000_0000_0000,AE} / {32'b0000_0000_0000_0000_0000_0000_0000_0000,BE} ;//商放在lo
                res[63:32] <= {32'b0000_0000_0000_0000_0000_0000_0000_0000,AE} % {32'b0000_0000_0000_0000_0000_0000_0000_0000,BE};//hi放余数
            end
            else
                res[31:0] <= AE / BE;
                res[63:32] <= AE % BE;
        end

        Res_hiE <= mthiE ? AE : res[63:32];
        Res_loE <= mtloE ? AE : res[31:0];
    end
endmodule