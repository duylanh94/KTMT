`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:07:07 11/07/2015 
// Design Name: 
// Module Name:    IF_ID 
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
module IF_ID(
	input [31:0] Ins,
	input clk,clr,en,rst,	
	input [31:0] PCPlus4F,
	output reg [31:0] PCPlus4D,
	output reg [31:0] InstrD
    );

always@(posedge clk)
begin
if(~rst)
begin
	InstrD <= 0;
	PCPlus4D <= 0;
end
else if (!en)
	begin
		if(clr)
				begin
					InstrD <= 0;
					PCPlus4D <= 0;
				end	
		else
			begin
			 InstrD <= Ins;
			 PCPlus4D <= PCPlus4F;
			end
	end				 
end

endmodule
