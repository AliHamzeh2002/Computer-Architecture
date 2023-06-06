module risc_v(clk, rst, done); 
    input clk, rst;
    output done;

    wire [6:0] op, funct7;

	wire [2:0] funct3, ImmSrc, ALUControl;

	wire Zero, lt;

	wire PCSrc, MemWrite, ALUSrc, RegWrite;

	wire [1:0] ResultSrc;

	Controller CU(op, funct3, funct7, Zero, lt, PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc, ImmSrc, RegWrite, done);
    
	Datapath DP(clk, rst, PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc, ImmSrc, RegWrite, op, funct7, funct3, Zero, lt);

endmodule