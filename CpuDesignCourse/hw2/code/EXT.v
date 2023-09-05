`timescale 1ns / 1ps

module EXT(
        input extop, 
        input luiop,
        input[15:0] A,
        output reg[31:0] res
    );
        reg[31:0] tmp;
    always @(*) 
    begin
        
        if(extop == 1)
            tmp = $signed(A);
        else
            tmp = A;
        if(extop == 0 && luiop == 1)
            res = A << 16;
        else
            res = tmp;
    end

endmodule