module mux_2to1_32bit(in0, in1, sel, out);
	input [31:0] in0, in1;
	input sel;
	output [31:0] out;
	assign out = sel == 1'b0 ? in0 :
		     sel == 1'b1 ? in1 : 32'bx;
endmodule