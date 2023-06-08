module PipeLine_Register_FD(clk, EN, InstrF, PCPlus4F, InstrD, PCPlus4D);
    input clk, EN;
    input [31:0] InstrF, PCPlus4F;
    output reg [31:0] InstrD, PCPlus4D;

    always @(posedge clk) begin
        if (~EN)
            InstrD = InstrF;
            PCPlus4D = PCPlus4F;
    end


endmodule