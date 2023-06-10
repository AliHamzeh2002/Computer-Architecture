module RISCV_MC(clk, rst, done);
    input clk, rst;
    output done;
    wire [6:0] op, func7;
    wire [2:0] func3, ImmSrc, ALUControl;
    wire Zero, lt, MemWrite, RegWrite, PCWrite, AdrSrc, IRWrite;
    wire [1:0] ResultSrc, ALUSrcA, ALUSrcB;
    
    Controller_MC CU(clk, rst, op, func3, func7, Zero, lt, 
        AdrSrc, ResultSrc, PCWrite, IRWrite, MemWrite, ALUControl, ALUSrcA, ALUSrcB, ImmSrc, RegWrite, done);

    Datapath_MC DP(clk, rst, PCWrite, AdrSrc, IRWrite, RegWrite, MemWrite, ResultSrc, ALUControl,
        ALUSrcA, ALUSrcB, ImmSrc, op, func7, func3, lt, Zero);

endmodule