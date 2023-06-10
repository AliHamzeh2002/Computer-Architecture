module Data_Memory(clk, rst, A, WD, WE, RD);
    input clk, rst;
    input signed [31:0] A, WD;
    input WE;
    
    output signed [31:0] RD;

    reg signed [31:0] Mem[15999:0];

	assign RD = Mem[A>>2];

	always @(posedge clk or posedge rst) begin
        if (rst)
            $readmemh("tests/test1/DataMemory.txt", Mem);

		else if (WE) 
            Mem[A>>2] = WD;

	end
    
endmodule
