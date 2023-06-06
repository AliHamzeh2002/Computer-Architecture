module Register_File(clk, rst, A1, A2, A3, WD3, WE3, RD1, RD2);
    input clk, rst;
    input [4:0] A1, A2, A3;
    input [31:0] WD3;
    input WE3; // Write Enable
    output signed [31:0] RD1, RD2;

    reg signed [31:0] Regs[31:0];

    assign RD1 = Regs[A1];

	assign RD2 = Regs[A2];

    always @(posedge clk, posedge rst) begin
        if (rst) 
            $readmemh("tests/test1/RegFileDefault.txt", Regs);

        else if (WE3 & (A3 != 5'd0))
            Regs[A3] = WD3;
    end

endmodule