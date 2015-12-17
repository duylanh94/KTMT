`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:36:11 11/07/2015 
// Design Name: 
// Module Name:    SignExtend 
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
module SignExtend(
	input [15:0] din,
	output [31:0] dout
    );

wire Sign = din[15];
assign dout[15:0] = din;
assign dout[31:16] = Sign?16'hffff:16'h0000;

endmodule
