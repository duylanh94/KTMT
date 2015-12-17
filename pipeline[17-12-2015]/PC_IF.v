`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:17:36 11/07/2015 
// Design Name: 
// Module Name:    PC_IF 
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
module PC_IF(
	input [31:0] PC,
	input clk,en,
	input rst,
	output reg [31:0] PCF
    );

always@(posedge clk)
begin
	if(~rst)
		PCF<=0;
	else 
		if (!en) PCF <= PC;
end

endmodule
