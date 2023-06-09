module riscV_PL_TB();

    reg clk = 1'b0, rst = 1'b1;
    wire done;

    RISC_V_PL risc5_SC(clk, rst, done);

    always #20 clk = ~clk;

    // always begin
         
    //      #50;
    //      if (done)
    //         #50 $stop;

    // end

	initial begin
        #10 rst = 1'b0;
        #10000 $stop;
    end

endmodule