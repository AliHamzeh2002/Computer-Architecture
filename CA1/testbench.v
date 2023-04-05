module rat_in_mazeTB ();
    reg clk, rst, start, run;
    wire fail, done;
    wire [1:0] move;
    rat_in_maze RTB(clk, rst, start, run, done, move, fail);
    always #10 clk = ~clk;
    initial begin
        start = 0;
        rst = 0;
        run = 0;
        clk = 0;
        #30 start = 1;
        #20 start = 0;  
        #100000 run = 1;
        #40 run = 0;
        #100000 $stop;
    end



    
endmodule