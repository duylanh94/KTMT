module Mux_2_1(
		input Sel,
		input [31:0] Din0, Din1,
		output [31:0] Dout
    );
assign Dout = Sel?Din1:Din0;
endmodule
