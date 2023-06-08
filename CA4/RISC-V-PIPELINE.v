module RISC_V_PL(clk, rst, done);
    input clk, rst;
    output done;

    wire BeqD, BneD, BltD, BgeD, MemWriteD, ALUSrcD, RegWriteD, JumpD, PCSrcE, ResultSrcE0,
         StallF, StallD, FlushE, RegWriteM, RegWriteW;
    wire [1:0] ResultSrcD, ForwardAE, ForwardBE;
    wire [2:0] ImmSrcD, ALUControlD, func3;
    wire [6:0] op, func7;
    wire [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;

    Controller cu(op, func3, func7, RegWriteD, ResultSrcD, MemWriteD, JumpD, BeqD, BneD,
                  BltD, BgeD, ALUControlD, ALUSrcD, ImmSrcD, done);

    Datapath dp(clk, rst, RegWriteD, ResultSrcD, MemWriteD, JumpD, BeqD, BneD, BltD, BgeD,
                ALUControlD, ALUSrcD, ImmSrcD, StallF, StallD, FlushE, ForwardAE, ForwardBE, 
                op, func3, func7, Rs1D, Rs2D, Rs1E, Rs2E, RdE, PCSrcE, ResultSrcE0,
                RdM, RdW, RegWriteM, RegWriteW);

    Hazard_Unit hu(Rs1D, Rs2D, Rs1E, Rs2E, RdE, PCSrcE, ResultSrcE0,
                   RdM, RdW, RegWriteM, RegWriteW, StallF, StallD, FlushE, ForwardAE, ForwardBE);
    


endmodule