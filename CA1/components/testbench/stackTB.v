module stackTB ();
    reg clk, rst, push, pop;
    reg [1:0] data_in;
    wire [1:0] data_out;
    wire empty, full;
    stack_2bit STB(clk, rst, push, pop, data_in, data_out, empty, full);
    always #10 clk = ~clk;
    initial begin
        clk = 1'b0;
        rst = 1'b1;
        push = 1'b0;
        pop = 1'b0;
        data_in = 2'b00;
        #11 rst = 1'b0;
        #13 pop = 1;
        #7 pop = 0;
        #17 push = 1;
        repeat(10)
            #13 data_in = data_in + 1;
        #11 push = 0;
        repeat(10)
            #13 pop = 1;
        #20 $stop;
    end  
endmodule