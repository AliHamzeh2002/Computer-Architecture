`define SUM 3'b000
`define SUB 3'b001
`define AND 3'b010
`define OR 3'b011
`define OR 3'b011
`define SRCB 3'b100
`define LT 3'b101
`define XOR 3'b111


module ALU(A, B, Ctrl, Res, Zero, lt);
	input signed [31:0] A, B;
	input [2:0] Ctrl;

	output reg signed [31:0] Res;
	output Zero;
	output lt;

	always @(A or B or Ctrl) begin
		case(Ctrl)
			`SUM: Res = A + B;
			`SUB: Res = A - B;
			`AND: Res = A & B;
			`OR: Res = A | B;
			`SRCB: Res = B;
			`LT: Res = (A < B);
			`XOR: Res = A^B;
			default: Res = 32'bx;
		endcase
	end

	assign Zero = ~( |(Res) );
	assign lt = (A < B) ? 1'b1 : 1'b0;

endmodule