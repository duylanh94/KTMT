`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:52:26 11/14/2015
// Design Name:   TongHop
// Module Name:   C:/Users/Windows7/Desktop/Verilog/xilin/Pipeline/tb_Tonghop.v
// Project Name:  Pipeline
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TongHop
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module tb_Tonghop;
	// Inputs
	reg clk;
	reg rst;
//	reg [31:0] PC_input;

	// Instantiate the Unit Under Test (UUT)
	TongHop uut (
		.clk(clk), 
		.rst(rst)
//		.PC_input(PC_input)
	);

	initial begin
		// Initialize Inputs
		clk = 0;
//		PC_input = 0;
		rst = 0;

		// Wait 100 ns for global reset to finish
		#2 rst = 1'b1;
        
		// Add stimulus here

	end
    always #1 clk = ~clk;  

endmodule

