module PipeLine_Register_DE(clk, CLR, RegWriteD, ResultSrcD, MemWriteD, JumpD, BeqD, BneD, BltD, BgeD, ALUControlD, ALUSrcD, ImmSrcD, Rd1D, Rd2D, PCD, Rs1D, Rs2D, RdD, ExtImmD, PCPlus4D,
                                    RegWriteE, ResultSrcE, MemWriteE, JumpE, BeqE, BneE, BltE, BgeE, ALUControlE, ALUSrcE, ImmSrcE, Rd1E, Rd2E, PCE, Rs1E, Rs2E, RdE, ExtImmE, PCPlus4E);
    input clk, CLR, RegWriteD, MemWriteD, JumpD, BeqD, BneD, BltD, BgeD, ALUSrcD;
    input [1:0] ResultSrcD, ImmSrcD;
    input [2:0] ALUControlD;
    input [31:0] Rd1D, Rd2D, PCD, Rs1D, Rs2D, RdD, ExtImmD, PCPlus4D;
    output reg RegWriteE, MemWriteE, JumpE, BeqE, BneE, BltE, BgeE, ALUSrcE;
    output reg [1:0] ResultSrcE, ImmSrcE;
    output reg [2:0] ALUControlE;
    output reg [31:0] Rd1E, Rd2E, PCE, Rs1E, Rs2E, RdE, ExtImmE, PCPlus4E;

    always @(posedge clk) begin
        if (CLR)
            {RegWriteE, MemWriteE, JumpE, BeqE, BneE, BltE, BgeE, ALUSrcE, ResultSrcE,
             ImmSrcE, ALUControlE, Rd1E, Rd2E, PCE, Rs1E, Rs2E, RdE, ExtImmE, PCPlus4E} = 0;
        else begin
            RegWriteE = RegWriteD;
            ResultSrcE = ResultSrcD;
            MemWriteE = MemWriteD;
            JumpE = JumpD;
            BeqE = BeqD;
            BneE = BneD;
            BltE = BltD;
            BgeE = BgeE;
            ALUControlE = ALUControlD;
            ALUSrcE = ALUSrcD;
            ImmSrcE = ImmSrcD;
            Rd1E = Rd1D;
            Rd2E = Rd2D;
            PCE = PCD;
            Rs1E = Rs2D;
            Rs2E = Rs2D;
            RdE = RdD;
            ExtImmE = ExtImmD;
            PCPlus4E = PCPlus4D;
        end
    end
    
endmodule