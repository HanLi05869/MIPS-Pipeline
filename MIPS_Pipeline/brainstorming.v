module muxRD1 (
    input[31:0] resultD,
    input[31:0] RD1,
    input regwriteW,
    input[4:0] A1,
    input[4:0] WriteRegW,
    output[31:0] srcaD
);
    assign srcaD = regwriteW && A1 == WriteRegW ? resultD : RD1;  
endmodule

module muxRD2 (
    input[31:0] resultD,
    input[31:0] RD2,
    input regwriteW,
    input[4:0] B1,
    input[4:0] WriteRegW,
    output[31:0] srcaD
);
    assign srcaD = regwriteW && B1 == WriteRegW ? resultD : RD2;  
endmodule

module flushD_module (
    input jrD,
    input pcsrcD,
    input jumpD,
    input ErrorFlush,
    output reg flushD
);
    always @(*) begin
        flushD = jrD | pcsrcD | jumpD | ErrorFlush;
    end
endmodule





module mux_jalr (
    input[4:0] cur_rs,
    input[4:0] WriteRegE,
    input[31:0] PCplusE,
    input[4:0] WriteRegM,
    input[31:0] PCplusM,
    input[31:0] srcaD,
    input jalrD,
    output[31:0] forward_gpr_rs
);
    assign forward_gpr_rs = jalrD && (cur_rs == WriteRegM || cur_rs == WriteRegE ) ? ((cur_rs == WriteRegE) ? PCplusE : PCplusM) :srcaD;
endmodule

module mux_hi_out (
    input hiwriteW,
    input[31:0] Res_hiW,
    input[31:0] hiout,
    output[31:0] real_hiout
);
    assign real_hiout = hiwriteW ? Res_hiW : hiout;
endmodule

module mux_lo_out (
    input lowriteW,
    input[31:0] Res_loW,
    input[31:0] loout,
    output[31:0] real_loout
);
    assign real_loout = lowriteW ? Res_loW : loout;
endmodule