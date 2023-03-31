module maze_memoryTB();
    reg clk, rst, rd, wr, data_in;
    reg[3:0] x_pos, y_pos;
    wire data_out;
    maze_memory MTB(clk, rst, rd, wr, x_pos, y_pos, data_in, data_out);
    always #10 clk = ~clk;
    initial begin
        clk = 0;
        rd = 0;
        wr = 0;
        data_in = 0;
        rst = 0;
        x_pos = 1;
        y_pos = 0;
        #17 rst = 1;
        #17 rst = 0;
        #13 rd = 1;
        #17 y_pos = 1;
        #17 rd = 0;
        #17 data_in = 1;
        #17 y_pos = 0;
        #17 wr = 1;
        #23 wr = 0;
        #17 rd = 1;
        #17 $stop;
    end
    
endmodule