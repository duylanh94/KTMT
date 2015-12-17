`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:55:07 11/07/2015 
// Design Name: 
// Module Name:    TongHop 
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
module TongHop(
	input clk,rst
//	input [31:0] PC_input
    );

//-----------------------------------------------
//				Wire_reg
//-----------------------------------------------
wire [31:0] PC;					//sua cho nay
wire [31:0] PCF;
wire [31:0] PCPlus4F = PCF + 4;
wire [4:0] WriteRegW;
wire [31:0] ResultW;
wire [31:0] PCBranchD;
wire RegWriteW;
wire BranchD;
wire Branch_NeqD;
wire [4:0] WriteRegE;
wire [31:0] RF_out1,RF_out2;
wire [31:0] ALUOutM;
wire ForwardAD, ForwardBD;
wire jumpD;

wire [31:0] RF_out1_tmp, RF_out2_tmp;
assign RF_out1_tmp = ForwardAD?ALUOutM:RF_out1;
assign RF_out2_tmp = ForwardBD?ALUOutM:RF_out2;

wire PCSrcD = ( (RF_out1_tmp == RF_out2_tmp) & BranchD ) | ( (RF_out1_tmp != RF_out2_tmp) & Branch_NeqD) | jumpD;

//--------------------
Mux_2_1 mux_PC(
				.Sel(PCSrcD),
				.Din0(PCPlus4F),
				.Din1(PCBranchD),
				.Dout(PC)
				);
//----------PC-----------------
wire StallIF;
PC_IF u1(
			.PC(PC),			
			.PCF(PCF),
			.clk(clk),
			.rst(rst),
			.en(StallIF)
			);
//---------------------------------
//				IF
//---------------------------------
wire [31:0] Ins;
Instruction_Memory	IM(
			.PC(PCF),
			.Instr(Ins)
    );
//---------------------------------
//				ID
//---------------------------------
wire [31:0] InstrD;
wire [31:0] PCPlus4D;
wire StallID;
IF_ID u2(
			.Ins(Ins),
			.en(StallID),
			.InstrD(InstrD),
			.clk(clk),
			.PCPlus4F(PCPlus4F),
			.PCPlus4D(PCPlus4D),
			.clr( PCSrcD),
			.rst(rst)// rst
			);
wire [31:0] PCjump;
assign PCjump = InstrD[25:0] << 2;
//---------------Register_File-----
//wire [31:0] RF_out1,RF_out2;
register_file u3(
						.clk(clk), 
						.A1(InstrD[25:21]),
						.A2(InstrD[20:16]),
						.A3(WriteRegW),
						.WD3(ResultW),
						.WE(RegWriteW),
						.RD1(RF_out1),
						.RD2(RF_out2)
						);
//---------------SignExtend-------
wire [31:0] SignImmD;
SignExtend	SE(
					.din(InstrD[15:0]),
					.dout(SignImmD)
					);
assign PCBranchD = jumpD ? PCjump : (PCPlus4D + (SignImmD<<2));
//---------------Control_Unit-----
wire RegDstD,AluSrcD,MemWriteD,MemtoRegD,RegWriteD, MemReadD;
wire [3:0] ALUCtrlD;
ControlUnit u4(
					.opcode(InstrD[31:26]),
					.funct(InstrD[5:0]),
					.RegDst(RegDstD),
					.AluSrc(AluSrcD),
					.Branch(BranchD),
					.MemWrite(MemWriteD),
					.MemRead(MemReadD),
					.MemtoReg(MemtoRegD),
					.RegWrite(RegWriteD),
					.ALUCtl(ALUCtrlD),
					.Branch_Neq(Branch_NeqD),
					.Jump(jumpD)
					);
//---------------------------------
//				EX
//---------------------------------

//---------------ID_EX-------------
wire FlushE;
wire RegWriteE,MemtoRegE, MemWriteE,ALUSrcE, RegDstE, MemReadE;
wire [31:0] SignImmE;
wire [3:0] ALUControlE;
wire [4:0] RtE,RsE,RdE;
wire [31:0]op_E_1;
wire [31:0]op_E_2;
ID_EX u5(
			.clk(clk),
			.clr(FlushE | (~rst) ),				//rst
			.op_D_1(RF_out1),
			.op_D_2(RF_out2),
			.RsD(InstrD[25:21]),						
			.RtD(InstrD[20:16]),						
			.RdD(InstrD[15:11]),				
			.RegWriteD(RegWriteD),
			.MemWriteD(MemWriteD),
			.MemReadD(MemReadD),
			.MemtoRegD(MemtoRegD),
			.SignImmD(SignImmD),
			.SignImmE(SignImmE),
			.ALUSrcD(AluSrcD), 
			.RegDstD(RegDstD),   
			.ALUControlD(ALUCtrlD),
			.op_E_1(op_E_1),
			.op_E_2(op_E_2),
			.RsE(RsE),
			.RtE(RtE),
			.RdE(RdE),
			.RegWriteE(RegWriteE),
			.MemtoRegE(MemtoRegE), 
			.MemWriteE(MemWriteE),
			.MemReadE(MemReadE),
			.ALUSrcE(ALUSrcE),
			.RegDstE(RegDstE),  
			.ALUControlE(ALUControlE)
			);
//---------------Mux_2_1-------------
Mux_2_1_5bit mux2_1_IDEX(
					.Sel(RegDstE),
					.Din0(RtE),								//sua cho nay: dia chi A1
					.Din1(RdE),								//sua cho nay: dia chi A2
					.Dout(WriteRegE)
					);
//---------------Mux_3_1-------------
wire [1:0]ForwardAE,ForwardBE;
//wire [31:0] ALUOutM;
//wire [31:0] ResultW;
wire [31:0] SrcAE,WriteDataE;
Mux_3_1 MUX31_FWAE(
				.Sel(ForwardAE),
				.Din0(op_E_1),
				.Din2(ALUOutM),
				.Din1(ResultW),
				.Dout(SrcAE)
				);
Mux_3_1 MUX31_FWBE(
				.Sel(ForwardBE),
				.Din0(op_E_2),
				.Din2(ALUOutM),
				.Din1(ResultW),
				.Dout(WriteDataE)
				);
//---------------Mux_2_1-------------
//wire [31:0] SignImmE;
wire [31:0] SrcBE;
Mux_2_1 mux2_1_ALU(
					.Sel(ALUSrcE),
					.Din0(WriteDataE),
					.Din1(SignImmE),
					.Dout(SrcBE)
					);
//---------------ALU-------------------
wire [31:0] ALUOutE;
ALU alu(
			.ALU_Control(ALUControlE),
			.A_input(SrcAE),	
			.B_input(SrcBE),
			.shame(SignImmE[10:6]),
			.ALUresult(ALUOutE)
			);
//---------------------------------
//				MEM
//---------------------------------

//---------------EX_MEM-------------
wire [31:0]WriteDataM;
wire RegWriteM,MemtoRegM,MemWriteM, MemReadM;
wire [4:0] WriteRegM;
//wire [4:0] WriteRegE;
EXMEM exmem(
				.clk(clk),
				.RegWriteE(RegWriteE),
				.MemtoRegE(MemtoRegE), 
				.MemWriteE(MemWriteE),
				.MemReadE(MemReadE),
				.WriteRegE(WriteRegE),
				.Aluresults(ALUOutE),
				.WriteDataE(WriteDataE),
				.RegWriteM(RegWriteM),
				.MemtoRegM(MemtoRegM),
				.MemWriteM(MemWriteM),
				.MemReadM(MemReadM),
				.WriteRegM(WriteRegM),
				.AluOutM(ALUOutM),
				.WriteDataM(WriteDataM)
				);
//---------------DataMemory-------------
wire [31:0] ReadDataW;
//wire [31:0] ReadDataM;
DataMemory DM(
				.clk(clk),
				.WE(MemWriteM),
				.RE(MemReadM),
				.A(ALUOutM),
				.WD(WriteDataM),
				.RD(ReadDataW)
				);
//---------------------------------
//				WB
//---------------------------------

//---------------MEM_WB-------------
wire [31:0] AluOutW;
//wire [4:0] WriteRegW;
//wire RegWriteW;
wire MemtoRegW;
MEMWB	memwb(
				.clk(clk),
				.RegWriteM(RegWriteM),
				.MemtoRegM(MemtoRegM),
//				.MemOut(ReadDataM),
				.AluOutM(ALUOutM),
				.WriteRegM(WriteRegM),
				.RegWriteW(RegWriteW),
				.MemtoRegW(MemtoRegW),
//				.ReadDataW(ReadDataW),
				.AluOutW(AluOutW),
				.WriteRegW(WriteRegW)
				);
//---------------Mux_2_1-------------
Mux_2_1 mux2_1_WB(
					.Sel(MemtoRegW),
					.Din0(AluOutW),
					.Din1(ReadDataW),
					.Dout(ResultW)
					);
//--------------HazardUnit----------
HazardUnit hazardUnit(
	.RegWriteW(RegWriteW),
	.RegWriteM(RegWriteM),
	.MemtoRegM(MemtoRegM),
	.RegWriteE(RegWriteE),
	.MemtoRegE(MemtoRegE),
	.ForwardAE(ForwardAE),
	.ForwardBE(ForwardBE),
	.MemReadE(MemReadE),
	.ForwardAD(ForwardAD),
	.ForwardBD(ForwardBD),
	.FlushE(FlushE),
	.WriteRegE(WriteRegE),
	.WriteRegM(WriteRegM),
	.WriteRegW(WriteRegW),
	.RsE(RsE), 
	.RtE(RtE), 
//	.RdE(RdE),
	.RsD(InstrD[25:21]), 
	.RtD(InstrD[20:16]), 
//	.RdD(RdD),
	.BranchD(BranchD),
	.StallID(StallID),
	.StallIF(StallIF),
	.Branch_NeqD(Branch_NeqD)
	);
endmodule
