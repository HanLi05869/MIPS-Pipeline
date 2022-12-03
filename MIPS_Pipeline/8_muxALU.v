`timescale 1ns / 1ps

module muxALU (
    input[31:0] BE,
    input[31:0] signimmE,
    input[31:0] zeroimmE,
    input[31:0] upperimmR,
    input[1:0] alusrcE,
    output reg[31:0] B
);
    always @(*) 
    begin
        case (alusrcE)
            0: B <= BE;
            1: B <= signimmE;
            2: B <= zeroimmE;
            3: B <= upperimmR;
        endcase   
    end
    initial begin
        B = 0;
    end
endmodule