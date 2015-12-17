`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:37:43 11/07/2015 
// Design Name: 
// Module Name:    Mux_2_1 
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
module Mux_2_1_5bit(
		input Sel,
		input [4:0] Din0, Din1,
		output [4:0] Dout
    );
assign Dout = Sel?Din1:Din0;
endmodule
