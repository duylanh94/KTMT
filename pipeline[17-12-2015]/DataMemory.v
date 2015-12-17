`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:01:41 11/06/2015 
// Design Name: 
// Module Name:    DataMemory 
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
`define SIZE_DATAMEM 64
module DataMemory(
		input clk,WE,RE,
		input [31:0] A,
		input [31:0] WD,
		output reg [31:0] RD
    );
//------------------------------
//			initial mem
//------------------------------
reg [31:0] DataMem [0:`SIZE_DATAMEM-1];
initial
begin
	$readmemh("DM.txt",DataMem);
end
//------------------------------
//			always 
//------------------------------
always@(posedge clk)
begin
	if(WE)
		begin
			DataMem[A[31:2]] <= WD;
		end
	else 
		if(RE)
			begin
				RD <= DataMem[A[31:2]];
			end
end
endmodule
