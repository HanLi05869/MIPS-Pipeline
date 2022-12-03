`timescale 1ns / 1ps

module HL_ID (
    input clk,
    input[31:0] Res_hiW,
    input[31:0] Res_loW,
    input hiwriteW,
    input lowriteW,
    output [31:0] hiout,
    output [31:0] loout
);
    reg[31:0] Hi_reg = 0;
    reg[31:0] Lo_reg = 0;
    assign hiout = Hi_reg;
    assign loout = Lo_reg;
    always @(posedge(clk)) 
    begin
        if(hiwriteW)
            Hi_reg <= Res_hiW;
        if(lowriteW)
            Lo_reg <= Res_loW;
    end
    initial begin
        Hi_reg = 0;
        Lo_reg = 0;
    end
endmodule