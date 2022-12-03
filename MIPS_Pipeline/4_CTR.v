`timescale 1ns / 1ps
module CPU(
    input [5:0] func,op,
    input [31:0] instr,
    output reg jalD,regwriteD,lbuD,lhuD,MemWriteD,blezD,bltzD,bgtzD,branchD,branchneD,bgezD,
    output reg[1:0] MemtoRegD,Sh_bD,alusrc,regdst,
    output reg jrD,jumpD,
    output reg jalrD,signD,mulD,divD,mtloD,mthiD,lowriteD,hiwriteD,mfloD,mfhiD,
    output reg[5:0] ALUControl,
    output reg usigned,
    output reg Break,
    output reg ERET,
    output reg SYSCALL,
    output reg CPWrite,
    output reg CPRead);

    wire tmppp;
    assign tmppp = ori | Ior;

    //reg Rtype  =  0;
    reg lb  =  0,lbu  =  0;
    reg lh  =  0, lhu  =  0,lw  =  0,sb  =  0,sh  =  0,sw  =  0,add  =  0,addu  =  0,sub  =  0,subu  =  0;
    reg sll  =  0,srl  =  0;
    reg sra  =  0,sllv  =  0,srav  =  0;
    reg Iand  =  0, Ior  =  0,Ixor  =  0;
    reg Inor  =  0,addi  =  0,addiu  =  0,andi  =  0,ori  =  0;
    reg xori  =  0,lui  =  0,slt  =  0,slti  =  0,sltiu  =  0,sltu  =  0,beq  =  0,bne  =  0,blez  =  0,bgtz  =  0,bltz  =  0,bgez  =  0,j  =  0;
    reg jal  =  0,jalr  =  0,jr  =  0,mult  =  0,multu  =  0,div  =  0,divu  =  0,mthi  =  0;
    reg mtlo  =  0,mfhi  =  0,mflo  =  0;
    reg srlv  =  0;
    reg _Break = 0;
    reg _eret = 0;
    reg _syscall = 0;
    reg mtc0 = 0;
    reg mfc0 = 0;
    wire Rtype;
    assign Rtype = ((op == 6'b00_00_00) && (instr != 0)) ? 1 : 0;
    always @(*) 
    begin
        jalD = 0;regwriteD = 0;lbuD = 0;lhuD = 0;MemWriteD = 0;blezD = 0;bltzD = 0;bgtzD = 0;branchD = 0;branchneD = 0;
        MemtoRegD = 0;Sh_bD = 0;alusrc = 0;regdst = 0;

        jalrD = 0;
        signD = 0;
        mulD = 0;
        divD = 0;
        mtloD = 0;
        mthiD = 0;
        lowriteD = 0;
        hiwriteD = 0;
        mfloD = 0;
        mfhiD = 0;
        jrD = 0; 
        jumpD = 0;
        ALUControl = 0;
        usigned = 0;
        
        lb = (op == 6'b10_00_00) ? 1 : 0;
        lbu = (op == 6'b10_01_00) ? 1 : 0;
        lh = op == 6'b100001 ? 1 : 0;
        lhu = op == 6'b100101 ? 1 : 0;
        lw = op == 6'b100011 ? 1 : 0;
        sb = op == 6'b101000 ? 1 : 0;
        sh = op == 6'b101001 ? 1 : 0;
        sw = op == 6'b101011 ? 1 : 0;
        sll = 0;
        if(Rtype)
        begin
            add = ((func == 6'b100000) ? 1 : 0);
            addu = func == 6'b100001 ? 1 : 0;
            sub = func == 6'b100010 ? 1 : 0;
            subu = func == 6'b100011 ? 1 : 0;
            sll = ((func == 6'b000000) && (instr != 0)) ? 1 : 0;
            srl = func == 6'b000010 ? 1 : 0;
            sra = func == 6'b000011 ? 1 : 0;
            sllv = ((func == 6'b000100) && (instr != 0)) ? 1 : 0;
            srlv = func == 6'b000110 ? 1 : 0;
            srav = func == 6'b000111 ? 1 : 0;
            Iand = func == 6'b100100 ? 1 : 0;
            Ior = func == 6'b100101 ? 1 : 0;
            Ixor = func == 6'b100110 ? 1 : 0;
            Inor = func == 6'b100111 ? 1 : 0;
            
            slt = func == 6'b101010 ? 1 : 0;
            sltu = func == 6'b101011 ? 1 : 0;

            jalr = func == 6'b001001 ? 1 : 0;
            jr = func == 6'b001000 ? 1 : 0;

            mult = func == 6'b011000 ? 1 : 0;
            multu = func == 6'b011001 ? 1 : 0;
            div = func == 6'b011010 ? 1 : 0;
            divu = func == 6'b011011 ? 1 : 0;
            mthi = func == 6'b010001 ? 1 : 0;
            mtlo = func == 6'b010011 ? 1 : 0;
            mfhi = func == 6'b010000 ? 1 : 0;
            mflo = func == 6'b010010 ? 1 : 0;


            jalrD = jalr;
            signD = multu | divu;
            mulD = mult | multu;
            divD = div | divu;
            mtloD = mtlo;
            mthiD = mthi;
            lowriteD = mulD | divD;
            hiwriteD = mulD | divD;
            mfloD = mflo;
            mfhiD = mfhi;
            jrD = jr | jalr;
        end
        addi = op == 6'b001000 ? 1 : 0;
        addiu = op == 6'b001001 ? 1 : 0;
        andi = op == 6'b001100 ? 1 : 0;
        ori = op == 6'b001101 ? 1 : 0;
        xori = op == 6'b001110 ? 1 : 0;
        lui = op == 6'b001111 ? 1 : 0;
        slti = op == 6'b001010  ? 1 : 0;
        sltiu = op == 6'b001011 ? 1 : 0;
        beq = op == 6'b000100 ? 1 : 0;
        bne = op == 6'b000101 ? 1 : 0;
        blez = op == 6'b000110 ? 1 : 0;
        bgtz = op == 6'b000111 ? 1 : 0;
        bltz = (op == 6'b000001)&&(instr[20:16] == 5'b00000) ? 1 : 0;
        bgez = (op == 6'b000001)&&(instr[20:16] == 5'b00001) ? 1 : 0;
        j = op == 6'b000010 ? 1 : 0;
        jal = op == 6'b000011 ? 1 : 0;
        
        jalD = jal;

        if((op == 6'b00_00_00)&&(func == 6'b001101))
            _Break = 1;
        if(instr==32'b010000_1000_0000_0000_0000_0000_011000)
            _eret = 1;
        if((op == 6'b000000) && (func == 6'b001100))
            _syscall = 1;
        if((op == 6'b01_00_00) && instr[25:21] == 5'b00100 && instr[10:0] == 11'b0_0000_0000)
            mtc0 = 1;
        if((op == 6'b01_00_00) && instr[25:21] == 5'b00000 && instr[10:0] == 11'b0_0000_0000)
            mfc0 = 1;
        

        regdst[1] = jal ? 1 : 0;
        regdst[0] = Rtype ? 1 : 0;
        regwriteD = (Rtype | lw | addi | addiu | jal | andi | ori | xori | slti | sltiu | lui | lb | lbu | lh | lhu);
        MemtoRegD[1] = (lb | lbu | lh | lhu) ? 1 : 0;
        MemtoRegD[0] = (lb | lbu | lw) ? 1 : 0;
        lbuD = lbu;
        lhuD = lhu;
        MemWriteD = sb | sh | sw;
        Sh_bD[1] = sw ? 1 : 0;
        Sh_bD[0] = (sw | sh) ? 1 : 0;
        alusrc[1] = andi | ori | xori | lui ? 1 : 0;
        alusrc[0] = (Rtype | beq | bne | blez | bltz | bgtz | andi | ori | xori) ? 0 : 1;//改一下
        blezD = blez;
        bltzD = bltz;
        bgtzD = bgtz;
        bgezD = bgez;
        branchD = beq;
        branchneD = bne;
        Break = _Break;
        ERET = _eret;
        SYSCALL = _syscall;
        CPWrite = mtc0;//GPR[rt] -> CP0[rd]
        CPRead = mfc0;//CP0[rd] -> GPR[rt]

        if(lw | sw | addi | addiu | lui | lb | lbu | lh | lhu | sb | sh | add | addu )
        begin
            ALUControl = 6'b000010;//add
        end
        if(beq | bne | blez | bltz | bgtz | sub | subu)
            ALUControl = 6'b010010;//sub
        if(andi | Iand)//and
            ALUControl = 6'b000000;
        if(ori || Ior)//or  
        begin
            ALUControl = 6'b000001;
        end
        if(xori | Ixor)//xor
            ALUControl = 6'b000101;
        if(slti | sltiu | slt | sltu)//slt
           ALUControl = 6'b010011;
        if(Inor)//nor
            ALUControl = 6'b000110;
        if(srl)//srl
            ALUControl = 6'b000111;
        if(srlv)//srlv
            ALUControl = 6'b100111;
        if(sll)//sll   
            ALUControl = 6'b000100;
        if(sllv)//sllv 
            ALUControl = 6'b100100;
        if(sra)
            ALUControl = 6'b001000;
        if(srav)
            ALUControl = 6'b101000;
        jumpD = j | jal;
        usigned = addiu | addu | divu | lbu | lhu | multu | sltiu | sltu | subu;
    end


    initial 
        begin
            jalD = 0;regwriteD = 0;lbuD = 0;lhuD = 0;MemWriteD = 0;blezD = 0;bltzD = 0;bgtzD = 0;branchD = 0;branchneD = 0;
            MemtoRegD = 0;Sh_bD = 0;alusrc = 0;regdst = 0;
            jrD = 0;jumpD = 0;
            jalrD = 0;signD = 0;mulD = 0;divD = 0;mtloD = 0;mthiD = 0;lowriteD = 0;hiwriteD = 0;mfloD = 0;mfhiD = 0;
            ALUControl = 0;
            usigned = 0;
        end

endmodule

