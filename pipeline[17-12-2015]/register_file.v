`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:23:24 11/06/2015 
// Design Name: 
// Module Name:    register_file 
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
module register_file(
	input clk, 
	input [4:0] A1, A2,
	input [4:0] A3,
	input [31:0] WD3,
	input WE,
	output [31:0] RD1,RD2
    );
//------------------------------
//			reg_wire
//------------------------------
reg [31:0] RF [0:31]; 
initial
begin
	$readmemh("RF.txt",RF);
end
//------------------------------
//			assign
//------------------------------
assign RD1 = RF[A1];
assign RD2 = RF[A2];
//------------------------------
//			always
//------------------------------
always@(negedge clk)
begin
	if(WE & (A3 != 0))
		begin
			RF[A3] = WD3;
		end
end
endmodule
