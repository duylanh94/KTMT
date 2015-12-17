module ALUControl(ALUOp,FuncCode,ALUCtl);
input [1:0] ALUOp;
input [5:0] FuncCode;
output [2:0] ALUCtl;
always @(*)
	begin
	case(ALUOp)
		2'b00: ALUCtl = 3'b010;//lw or sw
		2'b01: ALUCtl = 3'b110;//beq
		2'b10:
		begin
			if(FuncCode == 6'b100000)
				ALUCtl = 3'b010;//add
			if(FuncCode == 6'b100010)
				ALUCtl = 3'b110;//sub
			if(FuncCode == 6'b100100)
				ALUCtl = 3'b000;//and
			if(FuncCode == 6'b100101)
				ALUCtl = 3'b001;//or
			if(FuncCode == 6'b101010)
				ALUCtl = 3'b111;//set on less than
		end
		2'b11: ALUCtl = 0;
	endcase
	end
endmodule