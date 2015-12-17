module EXMEM(
				input clk,
				input RegWriteE,MemtoRegE,MemWriteE,
				input [4:0] WriteRegE,
				input [31:0] Aluresults,WriteDataE,
				input MemReadE,
				output reg MemReadM,
				output reg RegWriteM,MemtoRegM,MemWriteM,
				output reg [4:0] WriteRegM,
				output reg [31:0] AluOutM,WriteDataM
				);
always @(posedge clk)
			begin
				RegWriteM <= RegWriteE;
				MemtoRegM <= MemtoRegE;
				MemWriteM <= MemWriteE;
				WriteRegM <= WriteRegE;
				AluOutM <= Aluresults;
				WriteDataM <= WriteDataE;
				MemReadM <= MemReadE;
			end
endmodule

