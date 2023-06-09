module PipeLine_Register_FD(clk, rst, EN, CLR, InstrF, PCF, PCPlus4F, InstrD, PCD, PCPlus4D);
    input clk, rst, EN, CLR;
    input [31:0] InstrF, PCF, PCPlus4F;
    output reg [31:0] InstrD, PCPlus4D, PCD;

    always @(posedge clk, posedge rst) begin
        if (rst || CLR)
            {InstrD, PCPlus4D, PCD} = 0;
        else if (~EN)begin
            InstrD = InstrF;
            PCPlus4D = PCPlus4F;
            PCD = PCF;
        end
    end


endmodule