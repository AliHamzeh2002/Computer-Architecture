module Adder(A, B, Res);
	input [31:0] A, B;
	output reg [31:0] Res;

	assign Res = A + B;
endmodule
