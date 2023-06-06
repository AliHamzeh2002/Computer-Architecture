module TB();

    reg clk = 1'b0, rst = 1'b1;
    wire done;

    risc_v risc5(clk, rst, done);

    always #20 clk = ~clk;

    always @(posedge done) #10 $stop;
	initial #10 rst = 1'b0;

endmodule