`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:59:01 11/06/2015 
// Design Name: 
// Module Name:    Instruction_Memory 
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
`define 	SIZE_MEM 64
module Instruction_Memory(
	input [31:0] PC,
	output [31:0] Instr
    );
//------------------------------
//			initial memory
//------------------------------
reg [31:0] IM [0:`SIZE_MEM-1];
initial
begin
	$readmemh("IM.txt",IM);
end
//------------------------------
//			assign
//------------------------------
assign Instr = IM[PC[31:2]];

endmodule
