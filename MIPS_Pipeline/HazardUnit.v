`timescale 1ns / 1ps

module HazardUnit (
    input clk,
    input[1:0] MemtoRegE,
    input[1:0] MemtoRegM,
    input[4:0] rtD,
    input[4:0] rsD,
    input[4:0] WriteRegE,
    input[4:0] WriteRegM,
    input hiwriteE,
    input hiwriteM,
    input lowriteE,
    input lowriteM,
    input mfhiE,
    input mfhiM,
    input mfloE,
    input mfloM,
    input regwriteE,
    input regwriteM,
    //魔改
    input multE,
    input divE,
    input mfloD,
    input mfhiD,
    //魔改到此结束
    output reg stallF,
    output reg stallD,
    output reg stallE,
    output reg[2:0] forwarda,
    output reg[2:0] forwardb,
    output reg[1:0] forwardhi,
    output reg[1:0] forwardlo
);
    reg tostart = 0;
    always @(*) 
    begin
        stallF = ((MemtoRegE == 2'b01 || MemtoRegE == 2'b10 || MemtoRegE == 2'b11) && (regwriteE) && (WriteRegE == rsD || WriteRegE == rtD))
                    || ((multE || divE) && (mfloD || mfhiD))? 1 : 0;
        stallD = stallF;
        stallE = stallF;
        forwarda = 0;
        if(rsD != 5'b00000 && !(rsD ^ WriteRegM))
        begin
            if(regwriteM && MemtoRegM == 2'b00 && !mfhiM && !mfloM)
                forwarda = 3'b010;
            if(regwriteM && MemtoRegM == 2'b01 && !mfhiM && !mfloM)
                forwarda = 3'b011;
            if(regwriteM && MemtoRegM == 2'b10 && !mfhiM && !mfloM)
                forwarda = 3'b100;
            if(regwriteM && MemtoRegM == 2'b11 && !mfhiM && !mfloM)
                forwarda = 3'b101;
            if(regwriteM && MemtoRegM == 2'b00 && mfhiM && !mfloM)
                forwarda = 3'b111;
            if(regwriteM && MemtoRegM == 2'b00 && !mfhiM && mfloM)
                forwarda = 3'b111;
            if(regwriteM && MemtoRegM == 2'b00 && mfhiM && mfloM)
                forwarda = 3'b111;
        end
        //the order of if-else statement is vital!!! Otherwise it may forward wrong data, for instance add $1,$1,$1;add $1,$1,$1;add $1,$1,$1;
        if(rsD != 5'b00000 && !(rsD ^ WriteRegE))  
        begin
            if(regwriteE && !mfhiE && !mfloE)
            begin
                forwarda = 3'b001;
            end
            if(regwriteE && mfhiE && !mfloE)
                forwarda = 3'b110;
            if(regwriteE && !mfhiE && mfloE)
                forwarda = 3'b110;
            if(regwriteE && mfhiE && mfloE)
                forwarda = 3'b110;
        end

        forwardb = 0;
        if(rtD != 5'b00000 && !(rtD ^ WriteRegM))
        begin
            if(regwriteM && MemtoRegM == 2'b00 && !mfhiM && !mfloM)
                forwardb = 3'b010;
            if(regwriteM && MemtoRegM == 2'b01 && !mfhiM && !mfloM)
                forwardb = 3'b011;  
            if(regwriteM && MemtoRegM == 2'b10 && !mfhiM && !mfloM)
                forwardb = 3'b100; 
            if(regwriteM && MemtoRegM == 2'b11 && !mfhiM && !mfloM)
                forwardb = 3'b101; 
            if(regwriteM && MemtoRegM == 2'b00 && mfhiM && !mfloM)
                forwardb = 3'b111; 
            if(regwriteM && MemtoRegM == 2'b00 && !mfhiM && mfloM)
                forwardb = 3'b111; 
            if(regwriteM && MemtoRegM == 2'b00 && mfhiM && mfloM)
                forwardb = 3'b111; 
        end
        if(rtD != 5'b00000 && !(rtD ^ WriteRegE))
        begin
            if(regwriteE && !mfhiE && !mfloE)
                forwardb = 3'b001;
            if(regwriteE && mfhiE && !mfloE)
                forwardb = 3'b110;
            if(regwriteE && !mfhiE && mfloE)
                forwardb = 3'b110;
            if(regwriteE && mfhiE && mfloE)
                forwardb = 3'b110;
        end
        forwardlo = 2'b00;
        forwardhi = 2'b00;
        if(hiwriteE)
            forwardhi = 2'b01;
        else if(lowriteE)
            forwardlo = 2'b01;
        else if(!hiwriteE && hiwriteM)
            forwardhi = 2'b10;
        else if(!lowriteE && lowriteE)
            forwardlo = 2'b10;
    end
endmodule