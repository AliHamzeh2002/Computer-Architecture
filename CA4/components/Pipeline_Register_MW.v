module PipeLine_Register_MW(clk, rst, RegWriteM, ResultSrcM, ALUResultM, ReadDataM, RdM, PCPlus4M,
                            RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W);
    input clk, rst, RegWriteM;
    input [1:0] ResultSrcM;
    input [4:0] RdM;
    input [31:0] ALUResultM, ReadDataM, PCPlus4M;
    output reg RegWriteW;
    output reg [1:0] ResultSrcW;
    output reg [4:0] RdW;
    output reg [31:0] ALUResultW, ReadDataW, PCPlus4W;

    always @(posedge clk, posedge rst) begin
        if (rst)
            {RegWriteW, ResultSrcW, ALUResultW, ReadDataW, RdW, PCPlus4W} = 0;
        else 
            RegWriteW = RegWriteM;
            ResultSrcW = ResultSrcM;
            ReadDataW = ReadDataM;
            RdW = RdM;
            PCPlus4W = PCPlus4M;
            ALUResultW = ALUResultM;
    end

endmodule