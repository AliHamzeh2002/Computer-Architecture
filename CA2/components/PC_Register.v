`define PCDefault 32'd0

module PC_Register(clk, rst, PCNext, PC);
    input clk, rst;
    input [31:0] PCNext;
    output reg [31:0] PC;

    always @(posedge clk or posedge rst) begin
        if (rst)
            PC = `PCDefault;
        else 
            PC = PCNext;
    end

endmodule