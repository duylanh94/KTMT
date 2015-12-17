module ALU(ALU_Control,A_input,B_input,ALUresult,shame);
input [3:0] ALU_Control;
input [31:0] A_input,B_input;
input [4:0] shame;
output reg [31:0] ALUresult;

always @(*)
begin
	case(ALU_Control)
		4'b0000 : ALUresult = (A_input & B_input);
		4'b0001 : ALUresult = (A_input | B_input);
		4'b0010 : ALUresult = (A_input + B_input);
		4'b0110 : ALUresult = (A_input - B_input);
		4'b0111 : ALUresult = (A_input < B_input) ? 1 : 0;
		4'b1111 : ALUresult = (B_input>> shame) | {B_input[31],31'b0};
		4'b1010 : ALUresult = B_input>>shame;
		4'b1110 : ALUresult = B_input<<shame;
		default : ALUresult = 0;
	endcase
end
endmodule
