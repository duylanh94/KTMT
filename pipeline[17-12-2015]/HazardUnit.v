`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:40:13 11/13/2015 
// Design Name: 
// Module Name:    HazardUnit 
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
module HazardUnit(
	input RegWriteW,
	input RegWriteM,
	input MemtoRegM,
	input RegWriteE,
	input MemtoRegE,
	input MemReadE,
	output [1:0] ForwardAE,
	output [1:0] ForwardBE,
	output ForwardAD,
	output ForwardBD,
	output FlushE,
	input [4:0] WriteRegE,
	input [4:0] WriteRegM,
	input [4:0] WriteRegW,
	input [4:0] RsE, RtE,
	input [4:0] RsD, RtD,
	input BranchD,
	input Branch_NeqD,
	output StallID,
	output StallIF
    );


//----------------EX__data_hazard------------------------
wire is_WriteRegM_Neq_0 ;
or(is_WriteRegM_Neq_0,WriteRegM[0],WriteRegM[1],WriteRegM[2],WriteRegM[3],WriteRegM[4]);
or(is_WriteRegW_Neq_0,WriteRegW[0],WriteRegW[1],WriteRegW[2],WriteRegW[3],WriteRegW[4]);

wire is_WriteRegM_eq_RsE = (RsE == WriteRegM);
wire is_WriteRegM_eq_RtE = (RtE == WriteRegM);

wire is_WriteRegW_eq_RsE = (RsE == WriteRegW);
wire is_WriteRegW_eq_RtE = (RtE == WriteRegW);

		//----------ForwardAE
wire ForwardAE_eq_10 = RegWriteM & is_WriteRegM_Neq_0 & is_WriteRegM_eq_RsE ;

wire ForwardAE_eq_01 = RegWriteW & is_WriteRegW_Neq_0 & is_WriteRegW_eq_RsE ;

assign ForwardAE = ForwardAE_eq_10? 2'b10 : (ForwardAE_eq_01 ? 2'b01: 2'b00 );

		//----------ForwardBE
wire ForwardBE_eq_10 = RegWriteM & is_WriteRegM_Neq_0 & is_WriteRegM_eq_RtE;

wire ForwardBE_eq_01 = RegWriteW & is_WriteRegW_Neq_0 & is_WriteRegW_eq_RtE;

assign ForwardBE = ForwardBE_eq_10? 2'b10 : (ForwardBE_eq_01 ? 2'b01: 2'b00 );

//----------------LW_Stall------------------------
wire Stall_LW = MemReadE & ( (RtE == RsD) | (RtE == RtD) );
//assign StallID = Stall_LW;
//assign StallIF = Stall_LW;
//assign FlushE = Stall_LW;
//----------------Branch_Stall------------------------
wire Branch = BranchD | Branch_NeqD;
wire BranchStall =( ( Branch & RegWriteE & ( (WriteRegE == RsD) | (WriteRegE == RtD) ) ) | ( Branch & MemtoRegM & ( (WriteRegM == RsD) | (WriteRegM == RtD) ) ) ) & (|WriteRegE | |WriteRegM);
assign ForwardAD = (RsD != 0) & (RsD == WriteRegM) & RegWriteM;
assign ForwardBD = (RtD != 0) & (RtD == WriteRegM) & RegWriteM;
//----------------------------------------------------
assign StallID = Stall_LW | BranchStall;
assign StallIF = Stall_LW | BranchStall;
assign FlushE  = Stall_LW | BranchStall;						
endmodule
