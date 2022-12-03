`timescale 1ns / 1ps

module GPR(
        input[4:0] A,
        input[4:0] B,
        input[4:0] WriteRegW,
        input[31:0] Reg_resW,
        input[31:0] PCplusW,
        input jalW,
        input clk,
        input RegWriteW,
        input[31:0] instrD,//easy debuging
        output [31:0] RD1,RD2,
        output[31:0] result
    );

    reg [31:0] gpr[0:31];
    integer i = 0;

    assign result = jalW ? PCplusW : Reg_resW;
    
    assign RD1 = (RegWriteW && WriteRegW & WriteRegW == A) ? (result): gpr[A];
    assign RD2 = (RegWriteW && WriteRegW & WriteRegW == B) ? (result): gpr[B];

    always @(posedge clk) 
    begin
        if(RegWriteW && WriteRegW)
        begin
            gpr[WriteRegW] = result;
        end
    end
    
    initial begin
        for (i = 0;i < 32; i += 1)
            gpr[i] = 0;
    end
endmodule

