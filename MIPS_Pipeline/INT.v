module CP (
    input clk,
    input Wtsig,
    input[4:0] A,//rd
    input[31:0] in_data,
    output[31:0] res
);
    reg[31:0] CP0[31:0];
    integer i = 0;

    assign res = CP0[A];//A is equivalent to rd
    always @(posedge clk) 
    begin
        if(Wtsig)
        begin
            CP0[A] <= in_data;
        end
    end

    initial 
    begin
        for(i = 0;i < 31;i += 1)
            CP0[i] = 0;
    end
endmodule


module EPC (
    input[31:0] instrD,
    output[31:0] EPCValue,
    input clk,
    input intrupt
);
    reg[31:0] EPC_value = 0;

    assign EPCValue = EPC_value;
    
    always @(posedge clk)
    begin
        if(intrupt)
        begin
            EPC_value <= instrD;//读入
        end 
    end
endmodule



module INTDetect (
    input[31:0] instrD, 
    input[31:0] RD2,
    input[31:0] ALUres,
    input memwriteE,
    output reg IDBug,
    output reg EXEbug
);
    reg tmpIDbug = 0;
    reg tmpEXEbug = 0;
    always @(*) 
    begin
        tmpIDbug = 0;
        tmpEXEbug = 0;
        if((instrD[31:26] == 6'b000000 && instrD[5:0] == 6'b011010) ||
            (instrD[31:26] == 6'b000000 && instrD[5:0] == 6'b011011))
        begin
            if(RD2 == 0)
            begin
               tmpIDbug <= 1; 
            end
        end

        if(memwriteE == 1 && ALUres > 2047)
        begin
            tmpEXEbug <= 1;
        end

        IDBug <= tmpIDbug;
        EXEbug <= tmpEXEbug;
    end
endmodule


module INTprocess (
    input IDBug,
    input EXEbug,
    output intrupt,
    output FlushD,
    output FlushE,
    output FlushM,
    output FlushW,
    output disenableWrite
);
    reg tmpintrupt = 0;
    reg myFlushD = 0;
    reg myFlushE = 0;
    reg myFlushM = 0;
    reg myFlushW = 0;
    reg myDisenableWrite = 0;
    assign intrupt = tmpintrupt;
    assign FlushD = myFlushD;
    assign FlushE = myFlushE;
    assign FlushM = myFlushM;
    assign FlushW = myFlushW;
    assign disenableWrite = myDisenableWrite;
    always @(*) 
    begin
        tmpintrupt = 0;
        if(IDBug == 1 && EXEbug == 1)
        begin
            tmpintrupt <= 1;
            myFlushD = 1;
            myFlushE = 1;
            myFlushM = 1;
            myFlushW = 1;
            myDisenableWrite = 1;
        end
    end
endmodule

