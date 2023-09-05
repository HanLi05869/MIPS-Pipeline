`timescale 1ns/1ps

module ALU (
    input[31:0] a,b,
    input[1:0] op,
    output reg[31:0] sum
);
    always @(*)
    begin
        if(op == 3)
        begin
            sum = a + b;
        end
        else if (op == 2)
        begin
            sum = a + (~b) +1;
        end
        else
        begin
            sum = a | b;
        end
    end
endmodule






