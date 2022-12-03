`timescale 1ns / 1ps

module IF_ID_REG (
    input[31:0] instrF,
    input stallD,
    input[31:0] PCplusF,
    input flushD,
    input clk,
    input reset,
    output [31:0] instrD,
    output [31:0] PCplusD
);

    initial begin
        owninstr = 0;
        ownpcplus = 0;
        flg = 0;
        isStall = 0;
        lastinstr = 0;
        lastpcplus = 0;
    end
    
    reg[31:0] owninstr;
    reg[31:0] ownpcplus;
    reg flg = 0;
    reg isStall = 0;
    reg[31:0] lastinstr;
    reg[31:0] lastpcplus;
    always @(posedge clk)
    begin
        if (flushD) //nop
        begin
            owninstr <= 0;
            ownpcplus <= 0;
        end
        else if(!stallD)//stall
        begin
           if(reset)
            begin
                owninstr = 0;
                ownpcplus = 0;
            end
            else begin
                lastinstr = owninstr;
                lastpcplus = ownpcplus;

                owninstr = instrF;
                ownpcplus = PCplusF;
            end
        end
        else
        begin
            isStall <= 1;
        end
    end
    assign instrD = isStall ? (owninstr) : (owninstr);
    assign PCplusD = isStall ? (ownpcplus) : (ownpcplus);
endmodule

module FlushD (
    input jmp,
    input jr,
    input beq,
    output flushD
);
    assign flushD = jmp | jr | beq;
endmodule