`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:38:00 11/07/2015 
// Design Name: 
// Module Name:    Mux_3_1 
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
module Mux_3_1(
	input [1:0] Sel,
	input [31:0] Din0, Din1, Din2,
	output reg [31:0] Dout
    );

always@(*)
begin
	case(Sel)
		2'b00: Dout <= Din0;
		2'b01: Dout <= Din1;
		2'b10: Dout <= Din2;
	endcase
end

endmodule
