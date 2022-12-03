`timescale 1ns / 1ps

module mux_ID_EX_REG (
    input[31:0] PCplusE_,
    input[31:0] upperimmE_,
    input[31:0] zeroimmE_,
    input[31:0] signimmE_,
    input[10:6] shamtE_,
    input[4:0] WriteRegE_,
    input[31:0] AE_,
    input[31:0] BE_,
    input jalE_,
    input regwriteE_,
    input[1:0] MemtoRegE_,
    input lbuE_,
    input lhuE_,
    input MemWriteE_,
    input[1:0] Sh_bE_,
    input[1:0] alusrcE_,

    input[5:0] ALUControlE_,
    input usignedE_,

    input signE_,
    input mulE_,
    input divE_,
    input mtloE_,
    input mthiE_,
    input lowriteE_,
    input hiwriteE_,
    input mfloE_,
    input mfhiE_,
    input[31:0] hi_loE_,

    input stallE,

    output [31:0] PCplusE,
    output [31:0] upperimmE,
    output [31:0] zeroimmE,
    output [31:0] signimmE,
    output [10:6] shamtE,
    output [4:0] WriteRegE,
    output [31:0] AE,
    output [31:0] BE,
    output  jalE,
    output  regwriteE,
    output [1:0] MemtoRegE,
    output  lbuE,
    output  lhuE,
    output  MemWriteE,
    output [1:0] Sh_bE,
    output [1:0] alusrcE,

    output [5:0] ALUControlE,
    output  usignedE,

    output  signE,
    output  mulE,
    output  divE,
    output  mtloE,
    output  mthiE,
    output  lowriteE,
    output  hiwriteE,
    output  mfloE,
    output  mfhiE,
    output [31:0] hi_loE
);

assign PCplusE = stallE ? 0 : PCplusE_;
assign upperimmE = stallE ? 0 : upperimmE_;
assign zeroimmE = stallE ? 0 : zeroimmE_;
assign signimmE = stallE ? 0 : signimmE_;
assign shamtE = stallE ? 0 : shamtE_;
assign WriteRegE = stallE ? 0 : WriteRegE_;
assign AE = stallE ? 0 : AE_;
assign BE = stallE ? 0 : BE_;
assign jalE = stallE ? 0 : jalE_;
assign regwriteE = stallE ? 0 : regwriteE_;
assign MemtoRegE = stallE ? 0 : MemtoRegE_;
assign lbuE = stallE ? 0 : lbuE_;
assign lhuE = stallE ? 0 : lhuE_;
assign MemWriteE = stallE ? 0 : MemWriteE_;
assign Sh_bE = stallE ? 0 : Sh_bE_;
assign alusrcE = stallE ? 0 : alusrcE_;

assign ALUControlE = stallE ? 0 : ALUControlE_;
assign usignedE = stallE ? 0 : usignedE_;

assign signE = stallE ? 0 : signE_;
assign mulE = stallE ? 0 : mulE_;
assign divE = stallE ? 0 : divE_;
assign mtloE = stallE ? 0 : mtloE_;
assign mthiE = stallE ? 0 : mthiE_;
assign lowriteE = stallE ? 0 : lowriteE_;
assign hiwriteE = stallE ? 0 : hiwriteE_;
assign mfloE = stallE ? 0 : mfloE_;
assign mfhiE = stallE ? 0 : mfhiE_;
assign hi_loE = stallE ? 0 : hi_loE_;
endmodule