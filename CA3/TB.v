module RISCV_MC_TB();

    reg clk = 1'b0, rst = 1'b1;
    wire done;

    RISCV_MC RISC5_MC(clk, rst, done);

    always #20 clk = ~clk;

    always @(posedge done) #10 $stop;
	initial #10 rst = 1'b0;

endmodule