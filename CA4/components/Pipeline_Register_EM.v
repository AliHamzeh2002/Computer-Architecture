module PipeLine_Register_EM (clk, RegWriteE, ResultSrcE, MemWriteE, ALUResultE, WriteDataE, RdE, PCPlus4E,
                                RegWriteM, ResultSrcM, MemWriteM, ALUResultM, WriteDataM, RdM, PCPlus4M);
    input clk, RegWriteE, MemWriteE;
    input [1:0] ResultSrcE;
    input [31:0] ALUResultE, WriteDataE, RdE, PCPlus4E;
    output reg RegWriteM, MemWriteM;
    output reg [1:0] ResultSrcM;
    output reg [31:0] ALUResultM, WriteDataM, RdM, PCPlus4M;

    always @(posedge clk) begin
        RegWriteM = RegWriteE;
        ResultSrcM = ResultSrcE;
        MemWriteM = MemWriteE;
        ALUResultM = ALUResultE;
        WriteDataM = WriteDataE;
        RdM = RdE;
        PCPlus4M = PCPlus4E;
    end

endmodule