module MEMWB(
				input clk,
				input RegWriteM,MemtoRegM,
//				input[31:0] MemOut,
				input [31:0] AluOutM,
				input[4:0] WriteRegM,
				output reg RegWriteW,
				output reg MemtoRegW,
//				output reg [31:0] ReadDataW,
				output reg [31:0]AluOutW,
				output reg [4:0] WriteRegW);
always @(posedge clk)
	
			begin
				RegWriteW <= RegWriteM;
				MemtoRegW <= MemtoRegM;
//				ReadDataW <= MemOut;
				AluOutW <= AluOutM;
				WriteRegW <= WriteRegM;
			end

endmodule
