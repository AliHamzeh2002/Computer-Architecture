module PipeLine_Register_FD(clk, EN, InstrF, PCF, PCPlus4F, InstrD, PCD, PCPlus4D);
    input clk, EN;
    input [31:0] InstrF, PCF, PCPlus4F;
    output reg [31:0] InstrD, PCPlus4D, PCD;

    always @(posedge clk) begin
        if (~EN)
            InstrD = InstrF;
            PCPlus4D = PCPlus4F;
            PCD = PCF;
    end


endmodule