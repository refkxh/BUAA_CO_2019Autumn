`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:31:24 11/07/2019 
// Design Name: 
// Module Name:    mips 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module mips(
    input clk,
    input reset
    );

	wire [31:0] InstrD, InstrE, InstrM, InstrW, RD1DE, RD2DE, RD1E, RD2E, WDE, RD2M, WDM, WDW,
					ForwardD1, ForwardD2, ForwardE1, ForwardE2, ForwardM2, NPCOut, InstrFD, PC4FD, PCFD,
					PC4D, PCD, PCW, Imm32DE, WDDE, Imm32E, PCE, ALUOutEM, RD2EM, WDEM, ALUOutM, PCM, WDMW;
	wire [4:0] A3E, A3M, A3W, A3DE, A3EM, A3MW;
	wire [1:0] PCSrc;
	
	STALL STALLInstance (
    .InstrD(InstrD), 
    .InstrE(InstrE), 
    .InstrM(InstrM), 
    .PCEn(PCEn), 
    .DRegEn(DRegEn), 
    .ERegFlush(ERegFlush)
    );
	 
	 FWD FWDInstance (
    .A1D(InstrD[25:21]), 
    .A2D(InstrD[20:16]), 
    .RD1D(RD1DE), 
    .RD2D(RD2DE), 
    .A1E(InstrE[25:21]), 
    .A2E(InstrE[20:16]), 
    .RD1E(RD1E), 
    .RD2E(RD2E), 
    .A3E(A3E), 
    .WDE(WDE), 
    .A2M(InstrM[20:16]), 
    .RD2M(RD2M), 
    .A3M(A3M), 
    .WDM(WDM), 
    .A3W(A3W), 
    .WDW(WDW), 
    .ForwardD1(ForwardD1), 
    .ForwardD2(ForwardD2), 
    .ForwardE1(ForwardE1), 
    .ForwardE2(ForwardE2), 
    .ForwardM2(ForwardM2)
    );
	
	StageF StageFInstance (
    .Clk(clk), 
    .Reset(reset), 
    .PCEn(PCEn), 
    .PCSrc(PCSrc), 
    .NPCOut(NPCOut), 
    .ForwardD1(ForwardD1), 
    .InstrFD(InstrFD), 
    .PC4FD(PC4FD), 
    .PCFD(PCFD)
    );
	 
	 DReg DRegInstance (
    .Clk(clk), 
    .Reset(reset), 
    .DRegEn(DRegEn), 
    .InstrF(InstrFD), 
    .PC4F(PC4FD), 
    .PCF(PCFD), 
    .InstrD(InstrD), 
    .PC4D(PC4D), 
    .PCD(PCD)
    );
	 
	 StageD StageDInstance (
    .Clk(clk), 
    .Reset(reset), 
    .InstrD(InstrD), 
    .PC4D(PC4D), 
    .ForwardD1(ForwardD1), 
    .ForwardD2(ForwardD2), 
    .InstrW(InstrW), 
    .A3W(A3W), 
    .WDW(WDW), 
    .PCW(PCW), 
    .RD1DE(RD1DE), 
    .RD2DE(RD2DE), 
    .Imm32DE(Imm32DE), 
    .A3DE(A3DE), 
    .WDDE(WDDE), 
    .PCSrc(PCSrc), 
    .NPCOut(NPCOut)
    );
	 
	 EReg ERegInstance (
    .Clk(clk), 
    .Reset(reset), 
    .ERegFlush(ERegFlush), 
    .InstrD(InstrD), 
    .RD1D(RD1DE), 
    .RD2D(RD2DE), 
    .Imm32D(Imm32DE), 
    .A3D(A3DE), 
    .WDD(WDDE), 
    .PCD(PCD), 
    .InstrE(InstrE), 
    .RD1E(RD1E), 
    .RD2E(RD2E), 
    .Imm32E(Imm32E), 
    .A3E(A3E), 
    .WDE(WDE), 
    .PCE(PCE)
    );
	 
	 StageE StageEInstance (
    .InstrE(InstrE), 
    .ForwardE1(ForwardE1), 
    .ForwardE2(ForwardE2), 
    .Imm32E(Imm32E), 
    .A3E(A3E), 
    .WDE(WDE), 
    .ALUOutEM(ALUOutEM), 
    .RD2EM(RD2EM), 
    .A3EM(A3EM), 
    .WDEM(WDEM)
    );

	MReg MRegInstance (
    .Clk(clk), 
    .Reset(reset), 
    .InstrE(InstrE), 
    .ALUOutE(ALUOutEM), 
    .RD2E(RD2EM), 
    .A3E(A3EM), 
    .WDE(WDEM), 
    .PCE(PCE), 
    .InstrM(InstrM), 
    .ALUOutM(ALUOutM), 
    .RD2M(RD2M), 
    .A3M(A3M), 
    .WDM(WDM), 
    .PCM(PCM)
    );
	 
	 StageM StageMInstance (
    .Clk(clk), 
    .Reset(reset), 
    .InstrM(InstrM), 
    .ALUOutM(ALUOutM), 
    .ForwardM2(ForwardM2), 
    .A3M(A3M), 
    .WDM(WDM), 
    .PCM(PCM), 
    .A3MW(A3MW), 
    .WDMW(WDMW)
    );
	 
	 WReg WRegInstance (
    .Clk(clk), 
    .Reset(reset), 
    .InstrM(InstrM), 
    .A3M(A3MW), 
    .WDM(WDMW), 
    .PCM(PCM), 
    .InstrW(InstrW), 
    .A3W(A3W), 
    .WDW(WDW), 
    .PCW(PCW)
    );

endmodule
