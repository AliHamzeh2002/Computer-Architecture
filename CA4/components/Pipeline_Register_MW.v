module PipeLine_Register_MW(clk, RegWriteM, ResultSrcM, ReadDataM, RdM, PCPlus4M,
                            RegWriteW, ResultSrcW, ReadDataW, RdW, PCPlus4W);
    input clk, RegWriteM;
    input [1:0] ResultSrcM;
    input [31:0] ReadDataM, RdM, PCPlus4M;
    output reg RegWriteW;
    output reg [1:0] ResultSrcW;
    output reg [31:0] ReadDataW, RdW, PCPlus4W;

    always @(posedge clk) begin
        RegWriteW = ReadDataM;
        ResultSrcW = ResultSrcM;
        ReadDataW = ReadDataM;
        RdW = RdM;
        PCPlus4W = PCPlus4M;
    end

endmodule