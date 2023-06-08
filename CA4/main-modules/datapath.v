module Datapath (clk, rst, RegWriteD, ResultSrcD, MemWriteD, JumpD, BeqD, BneD, BltD, BgeD, ALUControlD, ALUSrcD, ImmSrcD, StallF, StallD, FlushE, ForwardAE, ForwardBE, 
                op, func3, func7, Rs1D, Rs2D, Rs1E, Rs2E, RdE, PCSrcE, ResultSrcE0, RdM, RdW, RegWriteM, RegWriteW);
    input clk, rst, RegWriteD, MemWriteD, JumpD, BeqD, BneD, BltD, BgeD, ALUSrcD, StallF, StallD, FlushE;
    input [1:0] ResultSrcD, ForwardAE, ForwardBE;
    input [2:0] ALUControlD, ImmSrcD;
    output PCSrcE, ResultSrcE0, RegWriteM, RegWriteW;
    output [6:0] op;
    output [2:0] func3;
    output [6:0] func7;
    output [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;

    //fetch
    wire [31:0] PCFPrime, PCPLus4F, PCF, InstrF;

    //decode
    wire [4:0] RdD;
    wire [31:0] InstrD, PCD, PCPLus4D, Rd1D, Rd2D, PCPlus4D, ExtImmD;

    //execute
    wire RegWriteE, MemWriteE, JumpE, BeqE, BneE, BltE, BgeE, ALUSrcE, LTE, ZeroE;
    wire [1:0] ResultSrcE;
    wire [2:0] ALUControlE, ImmSrcE;
    wire [4:0] Rs1E, Rs2E;
    wire [31:0] Rd1E, Rd2E, PCE, ExtImmE, PCPlus4E, srcAE, srcBE, WriteDataE, ALUResultE, PCTargetE;

    //memory
    wire MemWriteM;
    wire [1:0] ResultSrcM;
    wire [31:0] ALUResultM, WriteDataM, PCPlus4M, ReadDataM;

    //writeback
    wire [1:0] ResultSrcW;
    wire [31:0] ALUResultW, ReadDataW, PCPlus4W, ResultW;

    assign op = InstrD[6:0];
    assign func3 = InstrD[14:12];
    assign func7 = InstrD[31:25];
    assign Rs1D = InstrD[19:15];
    assign Rs2D = InstrD[24:20];
    assign RdD = InstrD[11:7];
    assign PCSrcE = JumpE | (BeqE & ZeroE) | (BneE & ~ZeroE) | (BltE & LTE) | (BgeE & ~LTE);

    wire [31:0] FOUR = 32'd4;

    //fetch
    mux_2to1_32bit pc_sel_mux(PCPLus4F, PCTargetE, PCSrcE, PCFPrime);
    PC_Register pc_reg(clk, rst, StallF, PCFPrime, PCF);
    Instruction_Memory instr_mem(PCF, InstrF);
    Adder pcaddr1(PCF, FOUR, PCPLus4F);

    //decode
    PipeLine_Register_FD pipe_reg_fd(clk, StallD, InstrF, PCF, PCPLus4F, InstrD, PCD, PCPlus4D);
    Register_File reg_file(clk, rst, Rs1D, Rs2D, RdD, ResultW, RegWriteW, Rd1D, Rd2D);
    Extend extnd(InstrD[31:7], ImmSrcD, ExtImmD);

    //execute
    PipeLine_Register_DE pipe_reg_de(clk, FlushE, RegWriteD, ResultSrcD, MemWriteD, JumpD, BeqD, BneD, BltD,
                                    BgeD, ALUControlD, ALUSrcD, ImmSrcD, Rd1D, Rd2D, PCD, Rs1D, Rs2D, RdD, ExtImmD, PCPlus4D,
                                    RegWriteE, ResultSrcE, MemWriteE, JumpE, BeqE, BneE, BltE, BgeE, ALUControlE, ALUSrcE, 
                                    ImmSrcE, Rd1E, Rd2E, PCE, Rs1E, Rs2E, RdE, ExtImmE, PCPlus4E);
    mux_3to1_32bit a_alu_sel_mux(Rd1E, ResultW, ALUResultM, ForwardAE, srcAE);
    mux_3to1_32bit data_mem_sel_mux(Rd2E, ResultW, ALUResultM, ForwardBE, WriteDataE);
    mux_2to1_32bit b_alu_sel_mux(WriteDataE, ExtImmE, ALUSrcE, srcBE);
    ALU alu(srcAE, srcBE, ALUControlE, ALUResultE, ZeroE, LTE);
    Adder pcaddr2(PCE, ExtImmE, PCTargetE);

    //memory
    PipeLine_Register_EM pipe_reg_em(clk, RegWriteE, ResultSrcE, MemWriteE, ALUResultE, WriteDataE, RdE, PCPlus4E,
                                    RegWriteM, ResultSrcM, MemWriteM, ALUResultM, WriteDataM, RdM, PCPlus4M);
    Data_Memory data_mem(clk, rst, ALUResultM, WriteDataM, MemWriteM, ReadDataM);

    //writeback
    PipeLine_Register_MW pipe_reg_mw(clk, RegWriteM, ResultSrcM, ALUResultM, ReadDataM, RdM, PCPlus4M,
                                    RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W);
    mux_3to1_32bit write_sel_mux(ALUResultW, ReadDataW, PCPlus4W, ResultSrcW, ResultW);

    

endmodule