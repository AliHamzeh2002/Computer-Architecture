module rat_in_mazeTB ();
    reg clk, rst, start, run;
    wire fail, done, wall_o, mem_dout, range, rd_fl;
    wire [1:0] move;
    wire [3:0] x_o , y_o;
    rat_in_maze RTB(clk, rst, start, run, done, move, fail, wall_o, mem_dout, range, x_o, y_o, rd_fl);
    always #10 clk = ~clk;
    initial begin
        start = 0;
        rst = 0;
        run = 0;
        clk = 0;
        #20 start = 1;
        #20 start = 0;  
        #1000000 $stop;
    end

    
endmodule