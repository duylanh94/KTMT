module ControlUnit(funct,opcode,ALUCtl,RegDst,AluSrc,MemWrite,Branch,MemtoReg,RegWrite,MemRead,Branch_Neq, Jump);
	input [5:0] opcode;
	input [5:0] funct;
	output RegDst,AluSrc,Branch,MemWrite,MemtoReg,RegWrite;
	output MemRead;
	output [3:0] ALUCtl;
	output Branch_Neq;
	output Jump;
wire [1:0] Alu_op;
//--------------------------------------------------------------------------
	wire R,lw,sw,beq,bne,I;
nor(R,opcode[5],opcode[4],opcode[3],opcode[2],opcode[1],opcode[0]);
assign lw = (opcode[5]) & (~opcode[4]) & (~opcode[3]) & (~opcode[2]) & (opcode[1]) & (opcode[0]) ;
assign sw = (opcode[5]) & (~opcode[4]) & (opcode[3]) & (~opcode[2]) & (opcode[1]) & (opcode[0]) ;
assign beq = (~opcode[5]) & (~opcode[4]) & (~opcode[3]) & (opcode[2]) & (~opcode[1]) & (~opcode[0]) ;
assign bne = (~opcode[5]) & (~opcode[4]) & (~opcode[3]) & (opcode[2]) & (~opcode[1]) & (opcode[0]) ;
assign addi = (~opcode[5]) & (~opcode[4]) & (opcode[3]) & (~opcode[2]) & (~opcode[1]) & (~opcode[0]) ;
assign Jump = (~opcode[5]) & (~opcode[4]) & (~opcode[3]) & (~opcode[2]) & (opcode[1]) & (~opcode[0]) ;
//-----------------------------------
	assign RegDst = R;
	assign AluSrc = lw | sw | addi;
	assign Branch = beq;
	assign Branch_Neq = bne; 
	
	assign MemWrite = sw;
	assign MemRead = lw;
	
	assign RegWrite = R | lw | addi;
	assign MemtoReg = lw;
//-----------------------------------
	assign Alu_op[1] = R;
	assign Alu_op[0] = beq | bne;
//-----------------------------------
assign ALUCtl[0] = Alu_op[1] & (funct[3] | funct[0]);
nand(ALUCtl[1], Alu_op[1], funct[2]);
assign ALUCtl[2] = Alu_op[0] | (funct[1] & Alu_op[1]);
wire ALUCtl3_tmp;
or(ALUCtl3_tmp,funct[5],funct[4]);
nor(ALUCtl[3],ALUCtl3_tmp,addi);
endmodule
	
