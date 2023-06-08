module Datapath_SC(clk, rst, PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc, ImmSrc, RegWrite, op, func7, func3, Zero, lt);
    input clk, rst, PCSrc, MemWrite, ALUSrc, RegWrite;
    input [1:0] ResultSrc;
    input [2:0] ALUControl, ImmSrc;
    output [6:0] op;
    output [6:0] func7;
    output [2:0] func3;
    output Zero, lt;

    wire [31:0] PCNext, PC, PCPLus4, ImmExt, PCTarget,
                Instr, SrcA, SrcB, ALUResult, ReadData, Result, WriteData;

    assign op = Instr[6:0];
    assign func3 = Instr[14:12];
    assign func7 = Instr[31:25];

    wire [31:0] FOUR = 32'd4;

    mux_2to1_32bit mux1(PCPLus4, PCTarget, PCSrc, PCNext);
    PC_Register PCreg(clk, rst, PCNext, PC);
    Instruction_Memory IM(PC, Instr);
    Register_File RF(clk, rst, Instr[19:15], Instr[24:20], Instr[11:7], Result, RegWrite, SrcA, WriteData);
    mux_2to1_32bit mux2(WriteData, ImmExt, ALUSrc, SrcB);
    ALU ALU_inst(SrcA, SrcB, ALUControl, ALUResult, Zero, lt);
    Data_Memory DM(clk, rst, ALUResult, WriteData, MemWrite, ReadData);
    mux_3to1_32bit mux3(ALUResult, ReadData, PCPLus4, ResultSrc, Result);
    Adder Plus4(PC, FOUR, PCPLus4);
    Extend Extnd(Instr[31:7], ImmSrc, ImmExt);
    Adder ADD(PC, ImmExt, PCTarget);
    
endmodule