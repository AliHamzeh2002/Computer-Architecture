module Datapath_MC(clk, rst, PCWrite, AdrSrc, IRWrite, RegWrite, MemWrite, ResultSrc, ALUControl, ALUSrcA, ALUSrcB, ImmSrc,
    op, func7, func3, lt, Zero);

    // Input ports
    input clk, rst;
    input AdrSrc, RegWrite, IRWrite, MemWrite, PCWrite;
    input [1:0] ResultSrc, ALUSrcA, ALUSrcB;
    input[2:0] ImmSrc;
    input [2:0] ALUControl;
    // Output ports
    output [6:0] op;
    output [6:0] func7;
    output [2:0] func3;
    output Zero, lt;
    // Wire and regs
    wire [31:0] PC, Adr, RD1, RD2, OldPC, A, B, ALUOut, Data, Instr, PCNext, SrcA, SrcB,
	    ImmExt, ALUResult, ReadData, Result;
    // Const
    wire [31:0] FOUR = 32'd4;
    wire One = 1'b1;

    assign op = Instr[6:0];
    assign func3 = Instr[14:12];
    assign func7 = Instr[31:25];
    assign PCNext = Result;

    Register32Bit PCReg(clk, rst, PCWrite, PCNext, PC);
    mux_2to1_32bit mux1(PC, Result, AdrSrc, Adr);
    Data_Memory DM(clk, rst, Adr, B, MemWrite, ReadData);
    Register32Bit InstrReg(clk, rst, IRWrite, ReadData, Instr);
    Register32Bit OldPCReg(clk, rst, IRWrite, PC, OldPC);
    Register32Bit RDReg(clk, rst, One, ReadData, Data);
    Register_File RF(clk, rst, Instr[19:15], Instr[24:20], Instr[11:7], Result, RegWrite, RD1, RD2);
    Register32Bit AReg(clk, rst, One, RD1, A);
    Register32Bit BReg(clk, rst, One, RD2, B);
    Extend Extnd(Instr[31:7], ImmSrc, ImmExt);
    mux_3to1_32bit mux2(PC, OldPC, A, ALUSrcA, SrcA);
    mux_3to1_32bit mux3(B, ImmExt, FOUR, ALUSrcB, SrcB);
    ALU ALU_inst(SrcA, SrcB, ALUControl, ALUResult, Zero, lt);
    Register32Bit ALUReg(clk, rst, One, ALUResult, ALUOut);
    mux_3to1_32bit mux4(ALUOut, Data, ALUResult, ResultSrc, Result);

endmodule