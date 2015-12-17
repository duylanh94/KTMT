`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:22:33 11/07/2015 
// Design Name: 
// Module Name:    ID_EX 
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
module ID_EX(
	input clk,clr,
	input [31:0] op_D_1, op_D_2,
	input [4:0] RsD,RtD,RdD,			
	input RegWriteD, MemtoRegD, MemWriteD,ALUSrcD, RegDstD,  
	input MemReadD,
	input [31:0] SignImmD,
	output reg [31:0] SignImmE,
	input [3:0] ALUControlD,
	output reg MemReadE,
	output reg [31:0] op_E_1, op_E_2,
	output reg [4:0] RsE,RtE,RdE,
	output reg RegWriteE,MemtoRegE, MemWriteE,ALUSrcE, RegDstE, 
	output reg[3:0] ALUControlE
    );

always@(posedge clk)
begin
		if(!clr)
			begin
				RsE <= RsD;
				RtE <= RtD;
				RdE <= RdD;
				RegWriteE <= RegWriteD;
				MemtoRegE <= MemtoRegD;
				MemWriteE <= MemWriteD;
				ALUSrcE <= ALUSrcD;
				RegDstE <= RegDstD;
				ALUControlE <= ALUControlD;
				op_E_1 <= op_D_1;
				op_E_2 <= op_D_2;
				MemReadE <= MemReadD;
				SignImmE <= SignImmD;
			end
		else
			begin
				RsE <= 0;
				RtE <= 0;
				RdE <= 0;
				RegWriteE <= 0;
				MemtoRegE <= 0;
				MemWriteE <= 0;
				ALUSrcE <= 0;
				RegDstE <= 0;
				ALUControlE <= 0;
				op_E_1 <= 0;
				op_E_2 <= 0;
				MemReadE <= 0;
				SignImmE <= 0;
			end
end

endmodule
