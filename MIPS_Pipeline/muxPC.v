`timescale 1ns / 1ps

module PCplus_or_PCbranch (
    input[31:0] PCbranch,
    input[31:0] PCplus,
    input beq,
    output reg[31:0] muxinstr_1
);
    always @(*) begin
        muxinstr_1 = beq ? PCbranch : PCplus;
    end
endmodule

module muxinstr_1_or_PCjmp(
    input[31:0] muxinstr_1,
    input[31:0] PCjmp,
    input jmp,//jmp, jal
    output reg[31:0] muxinstr_2
);
    always @(*) 
    begin
        muxinstr_2 = jmp ? PCjmp : muxinstr_1;
    end
endmodule

module muxinstr_2_or_PCjr(
    input[31:0] muxinstr_2,
    input[31:0] PCreg,
    input jr,//jalr, jr
    output reg[31:0] muxinstr_3
);

    always @(*) begin
        muxinstr_3 = jr ? PCreg : muxinstr_2;
    end
endmodule