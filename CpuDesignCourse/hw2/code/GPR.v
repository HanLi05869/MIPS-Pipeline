`timescale 1ns / 1ps
module GPR(
		input Regwrite, JAL,
        input[31:2] pc_plus,
        input clk,Reset,slt_op,
        output [31:0] Rddata1,Rddata2,
        input[4:0] Regrd1,Regrd2,
        input[4:0] Regwt,
        input[31:0] Wddata
	);
    //Regrd1 Regrd2就是左上的两个信号
    //Regwrite是写信号
    //Regwt是写寄存器编号
    reg[31:0] gpr[31:0];
    reg[31:0] tmp;
    
    assign Rddata1 = gpr[Regrd1];
    assign Rddata2 = gpr[Regrd2];
    /*
    always @(Regrd1 or Regrd2) 
    begin
        Rddata1 = gpr[Regrd1];
        Rddata2 = gpr[Regrd2];
    end
    */
    integer i;
    always @(posedge clk) 
    begin
        if(Reset == 1)
        begin
            for(i = 0;i < 32;i = i + 1)
                gpr[i] = 0;
        end
        else if(Regwrite == 1)//写信号
        begin
            if(slt_op == 1) // slt_op 小于则置位
                if(Wddata[31] == 1)//高位为1，表示负数，即小于则置位
                    gpr[Regwt] = 1;
                else
                    gpr[Regwt] = 0;
            else
                if(JAL == 1)
                begin
                    gpr[31] = {pc_plus,2'b00};
                    //$display("!!!!!!!:%d", pc_plus);
                    tmp = pc_plus;
                end
                else //if(Regwrite == 1)
                    gpr[Regwt] = Wddata;
        end
    end

    /*always @(posedge JAL)
    begin
        if(JAL == 1)
        begin
            gpr[31] = {pc_plus, 2'b00};
            //$display("!!!!!!!:%d", pc_plus);
            //tmp = pc_plus;
        end
    end
    */

    initial
    begin
        //integer i;
        for (i = 0; i < 31; i += 1) 
            gpr[i] = 0;
    end
endmodule