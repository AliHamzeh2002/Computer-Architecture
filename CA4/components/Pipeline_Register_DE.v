module PipeLine_Register_DE(clk, rst, CLR, RegWriteD, ResultSrcD, MemWriteD, JumpSelD, JumpD, BeqD, BneD, BltD, BgeD, ALUControlD, ALUSrcD, ImmSrcD, Rd1D, Rd2D, PCD, Rs1D, Rs2D, RdD, ExtImmD, PCPlus4D,
                                    RegWriteE, ResultSrcE, MemWriteE, JumpSelE, JumpE, BeqE, BneE, BltE, BgeE, ALUControlE, ALUSrcE, ImmSrcE, Rd1E, Rd2E, PCE, Rs1E, Rs2E, RdE, ExtImmE, PCPlus4E);
    input clk, rst, CLR, RegWriteD, MemWriteD, JumpSelD, JumpD, BeqD, BneD, BltD, BgeD, ALUSrcD;
    input [1:0] ResultSrcD;
    input [2:0] ALUControlD, ImmSrcD;
    input [4:0] Rs1D, Rs2D, RdD;
    input [31:0] ExtImmD, PCPlus4D, Rd1D, Rd2D, PCD;
    output reg RegWriteE, MemWriteE, JumpSelE, JumpE, BeqE, BneE, BltE, BgeE, ALUSrcE;
    output reg [1:0] ResultSrcE;
    output reg [2:0] ALUControlE, ImmSrcE;
    output reg [4:0]   Rs1E, Rs2E, RdE;
    output reg [31:0] ExtImmE, PCPlus4E, Rd1E, Rd2E, PCE;

    always @(posedge clk, posedge rst) begin
        if (CLR || rst)
            {RegWriteE, MemWriteE, JumpE, BeqE, BneE, BltE, BgeE, ALUSrcE, ResultSrcE,
             ImmSrcE, ALUControlE, Rd1E, Rd2E, PCE, Rs1E, Rs2E, RdE, ExtImmE, PCPlus4E} = 0;
        else begin
            RegWriteE = RegWriteD;
            ResultSrcE = ResultSrcD;
            MemWriteE = MemWriteD;
            JumpSelE = JumpSelD;
            JumpE = JumpD;
            BeqE = BeqD;
            BneE = BneD;
            BltE = BltD;
            BgeE = BgeD;
            ALUControlE = ALUControlD;
            ALUSrcE = ALUSrcD;
            ImmSrcE = ImmSrcD;
            Rd1E = Rd1D;
            Rd2E = Rd2D;
            PCE = PCD;
            Rs1E = Rs1D;
            Rs2E = Rs2D;
            RdE = RdD;
            ExtImmE = ExtImmD;
            PCPlus4E = PCPlus4D;
        end
    end
    
endmodule