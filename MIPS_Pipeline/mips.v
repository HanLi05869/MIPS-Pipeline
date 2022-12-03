`timescale 1ns / 1ps
//`include "testbench.v"
`include "7_ALU.v"
`include "4_CTR.v"
`include "DM.v"
`include "9_EX_MEM_REG.v"
`include "5_EXT.v"
`include "3_GPR.v"
`include "HazardUnit.v"
`include "HL_ID.v"
`include "6_ID_EX_REG.v"
`include "2_IF_ID_REG.v"
`include "1_IM.v"
`include "MDunit.v"
`include "MEM_WB_REG.v"
`include "8_muxALU.v"
`include "muxHL_ID.v"
`include "muxID.v"
`include "muxPC.v"
`include "NPC.v"
`include "PC.v"
`include "WB.v"

`include "ID_EX_REG(innov).v"
`include "brainstorming.v"

`include "INT.v"
module mips(
        input reset,
        input clk);

        wire[31:0] pcnextbrF,pcnextjF,pcnextF,pcF,instrF,instrD;
        wire[31:0] AD,BD;
        wire[31:0] srcaD,srcbD;
        wire[31:0] signimmD,zeroimmD,upperimmD;
        wire[4:0] WriteRegD;
        wire[31:0] pcjumpD,pcbranchD;
        wire[31:0] pcplus4F;
        wire[31:0] pcplus4D;
        wire[31:0] pcplus4E;
        wire[31:0] pcplus4E_;
        wire[31:0] pcplus4M;
        wire[31:0] pcplus4W;
        wire[31:0] srcaE,srcbE;
        wire[31:0] srcaE_,srcbE_;
        wire[4:0] WriteRegE;
        wire[4:0] WriteRegE_;
        wire[4:0] shamtE;
        wire[4:0] shamtE_;
        wire[31:0] signimmE,zeroimmE,upperimmE;
        wire[31:0] signimmE_,zeroimmE_,upperimmE_;
        wire[31:0] srcb2E;
        wire[62:0] res;
        wire[31:0] Res_hiE,Res_loE;
        wire[31:0] aluoutE;
        wire[31:0] hi_loE;
        wire[31:0] hi_loE_;

        wire[31:0] aluoutM,Res_hiM,Res_loM,hi_loM;
        wire[31:0] writedataM;
        wire[4:0] WriteRegM;
        wire[31:0] readdataM;

        wire[31:0] halfwordM,byteM;
        wire[31:0] byteW,halfwordW,readdataW,aluoutW;
        wire[4:0] WriteRegW;
        wire[31:0] Res_hiW,Res_loW,hi_loW,Reg_resW;
        wire pcsrcD;
        wire jalD,regwriteD,lbuD,lhuD,MemWriteD,blezD,bltzD,bgtzD,branchD,branchneD;
        wire[1:0] MemtoRegD,Sh_bD,alusrcD,regdstD;
        wire jrD;
        wire jumpD;
        wire jalrD,signD,mulD,divD,mtloD,mthiD,lowriteD,hiwriteD,mfloD,mfhiD;
        wire[5:0] ALUControlD;
        wire usignedD;

        wire jalE;
        wire regwriteE;
        wire[1:0] MemtoRegE;
        wire lbuE;
        wire lhuE;
        wire MemWriteE;
        wire[1:0] Sh_bE;
        wire[1:0] alusrcE;

        wire[5:0] ALUControlE;
        wire usignedE;

        wire signE;
        wire mulE;
        wire divE;
        wire mtloE;
        wire mthiE;
        wire lowriteE;
        wire hiwriteE;
        wire mfloE;
        wire mfhiE;

        wire jalE_;
        wire regwriteE_;
        wire[1:0] MemtoRegE_;
        wire lbuE_;
        wire lhuE_;
        wire MemWriteE_;
        wire[1:0] Sh_bE_;
        wire[1:0] alusrcE_;

        wire[5:0] ALUControlE_;
        wire usignedE_;

        wire signE_;
        wire mulE_;
        wire divE_;
        wire mtloE_;
        wire mthiE_;
        wire lowriteE_;
        wire hiwriteE_;
        wire mfloE_;
        wire mfhiE_;


        wire jalM;
        wire regwriteM;
        wire[1:0] MemtoRegM;//1:0
        wire lbuM;
        wire lhuM;
        wire MemWriteM;
        wire[1:0] Sh_bM;//1:0
        wire lowriteM;
        wire hiwriteM;
        wire mfloM;
        wire mfhiM;

        wire jalW;
        wire regwriteW;
        wire [1:0] memtoregW;
        wire lowriteW;
        wire hiwriteW;
        wire mfloW;
        wire mfhiW;

        wire [31:0] hiout,loout,hi_loD;
        wire stallD;
        wire stallE,stallF;
        wire[2:0] forwarda,forwardb;
        wire[1:0] forwardhi,forwardlo;
        wire[31:0] innerpcF;

        wire flushD;

  wire[31:0] forward_true_pcreg_srcaD;




    wire interruptLine;
    wire IDError;
    wire EXEError;

    //全部清空
    wire ErrorFlushD;
    wire ErrorFlushE;
    wire ErrorFlushM;
    wire ErrorFlushW;
    wire ErrorDisWrite;

    wire Break;
    wire eret_line;
    wire[31:0] outputEPC;
    wire syscall_line;
    wire CPRd;
    wire CPWt;
    wire[4:0] rdE,rtE;
    wire CPWtE,CPRdE;
    wire[4:0] rdM;
    wire CPRdM;
    wire CPWtM;
    wire[31:0] CPoutW;
    wire CPRdW;
    wire[31:0] CPout;

    INTDetect INTDetect(.instrD(instrD),.RD2(srcbD),.ALUres(aluoutE),.memwriteE(MemWriteE),.IDBug(IDError),.EXEbug(EXEError));
    INTprocess INTprocess(.IDBug(IDError),.EXEbug(EXEError),.intrupt(interruptLine),.disenableWrite(ErrorDisWrite),.FlushD(ErrorFlushD),.FlushE(ErrorFlushE),.FlushM(ErrorFlushM),.FlushW(ErrorFlushW));
    EPC EPC(.instrD(instrD),.clk(clk),.intrupt(interruptLine),.EPCValue(outputEPC));//the output remains to be implemented

    //IF pcsrcD is virtually in the module beq
    PCplus_or_PCbranch PCplus_or_PCbranch(.PCbranch(pcbranchD), .PCplus(pcplus4F), .beq(pcsrcD), .muxinstr_1(pcnextbrF));
    muxinstr_1_or_PCjmp muxinstr_1_or_PCjmp(.muxinstr_1(pcnextbrF), .PCjmp(pcjumpD),.jmp(jumpD), .muxinstr_2(pcnextjF));
    muxinstr_2_or_PCjr muxinstr_2_or_PCjr(.muxinstr_2(pcnextjF),.PCreg(eret_line ? outputEPC : forward_true_pcreg_srcaD),.jr(jrD),.muxinstr_3(pcnextF));//brainstroming
    NPC NPC(.muxinstr_3(pcnextF),.intrupt(interruptLine | Break | syscall_line),.next_pc(innerpcF));
    PC PC(.next_pc(innerpcF), .reset(reset), .clk(clk),.stallF(stallF),.pc(pcF), .PCplus(pcplus4F));
    IM IM(.addr(pcF),.IS(instrF));
    
    flushD_module flushD_module(.jrD(jrD),.jumpD(jumpD),.pcsrcD(pcsrcD),.ErrorFlush(ErrorFlushD),.flushD(flushD));
    IF_ID_REG IF_ID_REG(.instrF(instrF),.stallD(stallD),.PCplusF(pcplus4F),.flushD(flushD), 
    .instrD(instrD),.PCplusD(pcplus4D),.clk(clk),.reset(reset));
    

    wire[31:0] resultD;
    //ID
    GPR GPR(.result(resultD),.instrD(instrD),.A(instrD[25:21]),.B(instrD[20:16]),.WriteRegW(WriteRegW),.Reg_resW(CPRdW ? CPoutW : Reg_resW),.PCplusW(pcplus4W),.jalW(jalW),.clk(clk),.RegWriteW(ErrorDisWrite ? 1'b0 : regwriteW),.RD1(AD),.RD2(BD));
    EXT EXT(.A(instrD[15:0]), .signextend(signimmD), .zeroextend(zeroimmD), .upperimm(upperimmD));
    pcbranch pcbranch (.signimmD(signimmD),.PCplusD(pcplus4D),.PCbranchD(pcbranchD));
    pcjmp pcjmp(.PCplusD(pcplus4D),.instrD(instrD),.PCjmpD(pcjumpD));
    wire bgezD;
    smallALU smallALU(.blez(blezD),.bltz(bltzD),.bgtz(bgtzD),.branchne(branchneD),.branch(branchD),.A(srcaD),.B(srcbD),.PCSrcD(pcsrcD),.bgez(bgezD));
    wire[31:0] srca,srcb;
    muxRD1 muxRD1(resultD,AD,regwriteW,instrD[25:21],WriteRegW,srca);
    muxRD2 muxRD2(resultD,BD,regwriteW,instrD[20:16],WriteRegW,srcb);
    
    Forwarda Forwarda(.hi_loM(hi_loM),.hi_low(hi_loW),.byteM(byteM),.halfdataM(halfwordM),.readdataM(readdataM),.aluoutM(aluoutM),.aluoutE(aluoutE),.A(srca),.op(forwarda),.res(srcaD));
    Forwardb Forwardb(.hi_loM(hi_loM),.hi_low(hi_loW),.byteM(byteM),.halfdataM(halfwordM),.readdataM(readdataM),.aluoutM(aluoutM),.aluoutE(aluoutE),.B(srcb),.op(forwardb),.res(srcbD));
    
    
    mux_jalr mux_jalr(instrD[25:21],WriteRegE,pcplus4E,WriteRegM,pcplus4M,srcaD,jalrD,forward_true_pcreg_srcaD);
    
    wire[31:0] tmphiout,tmploout;
    HL_ID HL_ID(.clk(clk),.Res_hiW(Res_hiW),.Res_loW(Res_loW),.hiwriteW(hiwriteW),.lowriteW(lowriteW),.hiout(tmphiout),.loout(tmploout));
    mux_hi_out mux_hi_out(hiwriteW,Res_hiW,tmphiout,hiout);
    mux_lo_out mux_lo_out(lowriteW,Res_loW,tmploout,loout);

    muxHL_ID muxHL_ID(.Res_hiM(Res_hiM),.Res_hiE(Res_hiE),.hiout(hiout),.forwardhi(forwardhi),.forwardlo(forwardlo),.loout(loout),.res_loE(Res_loE),.res_loM(Res_loM),.mfhiD(mfhiD),.mfloD(mfloD),.hi_loD(hi_loD));
    Regdst Regdst(.regdst(regdstD),.rtD(instrD[20:16]),.rdD(instrD[15:11]),.WriteRegD(WriteRegD),.mfc0D(CPRd));
    
    CPU CPU(.func(instrD[5:0]),.op(instrD[31:26]),.instr(instrD), 
    .jalD(jalD),.regwriteD(regwriteD),.lbuD(lbuD),
    .lhuD(lhuD),
    .MemWriteD(MemWriteD),
    .blezD(blezD),
    .bltzD(bltzD),.bgtzD(bgtzD),.branchD(branchD),.branchneD(branchneD),.bgezD(bgezD),
    .MemtoRegD(MemtoRegD),.Sh_bD(Sh_bD),.alusrc(alusrcD),.regdst(regdstD),
    .jrD(jrD),.jumpD(jumpD),
    .jalrD(jalrD),.signD(signD),.mulD(mulD),.divD(divD),.mtloD(mtloD),.mthiD(mthiD),.lowriteD(lowriteD),.hiwriteD(hiwriteD),.mfloD(mfloD),.mfhiD(mfhiD),
    .ALUControl(ALUControlD),.usigned(usignedD),.Break(Break),.ERET(eret_line),.SYSCALL(syscall_line),.CPRead(CPRd),.CPWrite(CPWt));

    ID_EX_REG ID_EX_REG(.clk(clk),.jal(jalD | jalrD),.regwriteD(regwriteD),.MemtoRegD(MemtoRegD),.lbuD(lbuD),.lhuD(lhuD),.MemWriteD(MemWriteD),.Sh_bD(Sh_bD),.alusrc(alusrcD),.AD(srcaD),.BD(srcbD),
    .WriteRegD(WriteRegD),.shamtD(instrD[10:6]),.signimmD(signimmD),.zeroimmD(zeroimmD),.upperimmD(upperimmD),.PCplusD(pcplus4D),.stallE(stallE | ErrorFlushE),

    .jalr(jalrD),.ALUControl(ALUControlD),.usigned(usignedD),.signD(signD),.mulD(mulD),.divD(divD),.mtloD(mtloD),.mthiD(mthiD),.lowriteD(lowriteD),.hiwriteD(hiwriteD),.mfloD(mfloD),
    .mfhiD(mfhiD),.hi_loD(hi_loD),

    .PCplusE(pcplus4E),.upperimmE(upperimmE),.zeroimmE(zeroimmE),.signimmE(signimmE),.shamtE(shamtE),.WriteRegE(WriteRegE),.AE(srcaE),.BE(srcbE),.jalE(jalE),.regwriteE(regwriteE),
    .MemtoRegE(MemtoRegE),.lbuE(lbuE),.lhuE(lhuE),.MemWriteE(MemWriteE),.Sh_bE(Sh_bE),.alusrcE(alusrcE),

    .ALUControlE(ALUControlE),.usignedE(usignedE),

    .signE(signE),.mulE(mulE),.divE(divE),.mtloE(mtloE),.mthiE(mthiE),.lowriteE(lowriteE),.hiwriteE(hiwriteE),.mfloE(mfloE),.mfhiE(mfhiE),.hi_loE(hi_loE),
    .rdD(instrD[15:11]),.rtD(instrD[20:16]),.CPWtD(CPWt),.CPRdD(CPRd),
    .rdE(rdE),.rtE(rtE),.CPWtE(CPWtE),.CPRdE(CPRdE));

    
    //EX
    muxALU muxALU (.BE(srcbE),.signimmE(signimmE),.zeroimmE(zeroimmE),.upperimmR(upperimmE),.alusrcE(alusrcE),.B(srcb2E));
    MDunit MDunit (.AE(srcaE),.BE(srcbE),.signE(signE),.mulE(mulE),.divE(divE),.mthiE(mthiE),.mtloE(mtloE),.Res_hiE(Res_hiE),.Res_loE(Res_loE));
    ALU ALU(.ReadData1(srcaE),.ReadData2(srcb2E),.ALUOp(ALUControlE),.shamt(shamtE),.res(aluoutE),.usigned(usignedE));
    EX_MEM_REG EX_MEM_REG (.ErrorFlush(ErrorFlushM),.clk(clk),.jalE(jalE),.regwriteE(regwriteE),.MemtoRegE(MemtoRegE),.lbuE(lbuE),.lhuE(lhuE),.MemWriteE(MemWriteE),.Sh_bE(Sh_bE),.lowriteE(lowriteE),.hiwriteE(hiwriteE),.mfloE(mfloE),.mfhiE(mfhiE),.Res_hiE(Res_hiE),.Res_loE(Res_loE),.hi_loE(hi_loE),.aluoutE(aluoutE),.RD2(srcbE),.WriteRegE(WriteRegE),.PCplusE(pcplus4E),
    .jalM(jalM),.regwriteM(regwriteM),.MemtoRegM(MemtoRegM),.lbuM(lbuM),.lhuM(lhuM),.MemWriteM(MemWriteM),.Sh_bM(Sh_bM),.lowriteM(lowriteM),.hiwriteM(hiwriteM),.mfloM(mfloM),.mfhiM(mfhiM),.Res_hiM(Res_hiM),.Res_loM(Res_loM),.hi_loM(hi_loM),.aluoutM(aluoutM),.writedataM(writedataM),.WriteRegM(WriteRegM),.PCplusM(pcplus4M),
    .rdE(rdE),.CPRdE(CPRdE),.CPWtE(CPWtE),
    .rdM(rdM),.CPRdM(CPRdM),.CPWtM(CPWtM));

    //MEM
    DM DM(.addr(aluoutM),.data(writedataM),.Sh_bM(Sh_bM),.MemWriteM(MemWriteM),.clk(clk),.data_out(readdataM));
    halfword halfword(.data_out(readdataM),.aluoutM(aluoutM),.lhu(lhuM),.halfwordM(halfwordM));
    byteWord byteWord(.data_out(readdataM),.aluoutM(aluoutM),.lbu(lbuM),.byteM(byteM));
    
    CP CP(.A(rdM),.clk(clk),.in_data(writedataM),.res(CPout),.Wtsig(CPWtM));

    
    MEM_WB_REG MEM_WB_REG(.ErrorFlush(ErrorFlushW),.clk(clk),.jalM(jalM),.regwriteM(regwriteM),.MemtoRegM(MemtoRegM),.aluoutM(aluoutM),.readdataM(readdataM),.halfwordM(halfwordM),.WriteRegM(WriteRegM),.byteM(byteM),.PCplusM(pcplus4M),.lowriteM(lowriteM),.hiwriteM(hiwriteM),.mfloM(mfloM),.mfhiM(mfhiM),.Res_hiM(Res_hiM),.Res_loM(Res_loM),.hi_loM(hi_loM),
    .jalW(jalW),.regwriteW(regwriteW),.memtoregW(memtoregW),.aluoutW(aluoutW),.readdataW(readdataW),.halfwordW(halfwordW),.WriteRegW(WriteRegW),.byteW(byteW),.PCplusW(pcplus4W),.lowriteW(lowriteW),.hiwriteW(hiwriteW),.mfloW(mfloW),.mfhiW(mfhiW),.Res_hiW(Res_hiW),.Res_loW(Res_loW),.hi_loW(hi_loW),
    .CPout(CPout),.CPRd(CPRdE),
    .CPoutW(CPoutW),.CPRdW(CPRdW));
    //WB
    muxWB muxWB(.aluoutW(aluoutW),.readdataW(readdataW),.halfwordW(halfwordW),.byteW(byteW),.MemtoRegW(memtoregW),.mfloW(mfloW),.mfhiW(mfhiW),.hi_loW(hi_loW),.Reg_resW(Reg_resW));

    //Hazard process unit
    HazardUnit HazardUnit(.clk(clk),.MemtoRegE(MemtoRegE),.MemtoRegM(MemtoRegM),.rtD(instrD[20:16]),
    .rsD(instrD[25:21]),.WriteRegE(WriteRegE),.WriteRegM(WriteRegM),
    .hiwriteE(hiwriteE),.hiwriteM(hiwriteM),.lowriteE(lowriteE),.lowriteM(lowriteM),.mfhiE(mfhiE),.mfhiM(mfhiM),
    .mfloE(mfloE),.mfloM(mfloM),.regwriteE(regwriteE),.regwriteM(regwriteM),
    .stallF(stallF),.stallD(stallD),.stallE(stallE),.forwarda(forwarda),.forwardb(forwardb),.forwardhi(forwardhi),.forwardlo(forwardlo),
    .multE(mulE),.divE(divE),.mfloD(mfloD),.mfhiD(mfhiD));//这一行是魔改的


    always @(GPR.gpr[0])
		$display("GPR[0]:%h", GPR.gpr[0]);
    always @(GPR.gpr[1])
		$display("GPR[1]:%h", GPR.gpr[1]);
	always @(GPR.gpr[2])
		$display("GPR[2]:%h", GPR.gpr[2]);
	always @(GPR.gpr[3])
		$display("GPR[3]:%h", GPR.gpr[3]);
	always @(GPR.gpr[4])
		$display("GPR[4]:%h", GPR.gpr[4]);
	always @(GPR.gpr[5])
		$display("GPR[5]:%h", GPR.gpr[5]);
	always @(GPR.gpr[6])
		$display("GPR[6]:%h", GPR.gpr[6]);
	always @(GPR.gpr[7])
		$display("GPR[7]:%h", GPR.gpr[7]);
	always @(GPR.gpr[8])
		$display("GPR[8]:%h", GPR.gpr[8]);
	always @(GPR.gpr[9])
		$display("GPR[9]:%h", GPR.gpr[9]);
	always @(GPR.gpr[10])
		$display("GPR[10]:%h", GPR.gpr[10]);
	always @(GPR.gpr[11])
		$display("GPR[11]:%h", GPR.gpr[11]);
	always @(GPR.gpr[12])
		$display("GPR[12]:%h", GPR.gpr[12]);
	always @(GPR.gpr[13])
		$display("GPR[13]:%h", GPR.gpr[13]);
	always @(GPR.gpr[14])
		$display("GPR[14]:%h", GPR.gpr[14]);
	always @(GPR.gpr[15])
		$display("GPR[15]:%h", GPR.gpr[15]);
    always @(GPR.gpr[16])
		$display("GPR[16]:%h", GPR.gpr[16]);
    always @(GPR.gpr[17])
		$display("GPR[17]:%h", GPR.gpr[17]);
    always @(GPR.gpr[18])
		$display("GPR[18]:%h", GPR.gpr[18]);
    always @(GPR.gpr[19])
		$display("GPR[19]:%h", GPR.gpr[19]);
    always @(GPR.gpr[20])
		$display("GPR[20]:%h", GPR.gpr[20]);
    always @(GPR.gpr[21])
		$display("GPR[21]:%h", GPR.gpr[21]);
    always @(GPR.gpr[22])
		$display("GPR[22]:%h", GPR.gpr[22]);
    always @(GPR.gpr[23])
		$display("GPR[23]:%h", GPR.gpr[23]);    
	  always @(GPR.gpr[24])
		$display("GPR[24]:%h", GPR.gpr[24]);
    always @(GPR.gpr[25])
		$display("GPR[25]:%h", GPR.gpr[25]);
    always @(GPR.gpr[26])
		$display("GPR[26]:%h", GPR.gpr[26]);
    always @(GPR.gpr[27])
		$display("GPR[27]:%h", GPR.gpr[27]);
    always @(GPR.gpr[28])
		$display("GPR[28]:%h", GPR.gpr[28]);
    always @(GPR.gpr[29])
		$display("GPR[29]:%h", GPR.gpr[29]);
    always @(GPR.gpr[30])
		$display("GPR[30]:%h", GPR.gpr[30]);
    always @(GPR.gpr[31])
		$display("GPR[31]:%h", GPR.gpr[31]);
    always @(HL_ID.Hi_reg)
		$display("Hi_reg:%h", HL_ID.Hi_reg);
    always @(HL_ID.Lo_reg)
		$display("Lo_reg:%h", HL_ID.Lo_reg);
/*
    //you can see the alternation of MEM by following statements
    always @(DM.dm[0])
		    $display("mem[3,2,1,0]:%h %h %h %h",DM.dm[3],DM.dm[2],DM.dm[1],DM.dm[0]);
    always @(DM.dm[1])
		    $display("mem[3,2,1,0]:%h %h %h %h",DM.dm[3],DM.dm[2],DM.dm[1],DM.dm[0]);
    always @(DM.dm[2])
		    $display("mem[3,2,1,0]:%h %h %h %h",DM.dm[3],DM.dm[2],DM.dm[1],DM.dm[0]);
    always @(DM.dm[3])
		    $display("mem[3,2,1,0]:%h %h %h %h",DM.dm[3],DM.dm[2],DM.dm[1],DM.dm[0]);

    always @(DM.dm[4])
        $display("mem[7,6,5,4]:%h %h %h %h", DM.dm[7],DM.dm[6],DM.dm[5],DM.dm[4]);
    always @(DM.dm[5])
        $display("mem[7,6,5,4]:%h %h %h %h", DM.dm[7],DM.dm[6],DM.dm[5],DM.dm[4]);
    always @(DM.dm[6])
        $display("mem[7,6,5,4]:%h %h %h %h", DM.dm[7],DM.dm[6],DM.dm[5],DM.dm[4]);
    always @(DM.dm[7])
        $display("mem[7,6,5,4]:%h %h %h %h", DM.dm[7],DM.dm[6],DM.dm[5],DM.dm[4]);
    
    always @(DM.dm[11] || DM.dm[10] || DM.dm[9] ||DM.dm[8] )
        $display("mem[11,10,9,8]:%h %h %h %h", DM.dm[7],DM.dm[6],DM.dm[5],DM.dm[4]);
*/
endmodule
