module queueTB ();
    reg clk, rst, rst_front, enqueue, dequeue;
    reg [1:0] data_in;
    wire [1:0] data_out;
    wire finish, full;
    queue_2bit QTB(clk, rst, rst_front, enqueue, dequeue, data_in, data_out, finish, full);
    always #10 clk = ~clk;
    initial begin
        clk = 1'b0;
        rst = 1'b1;
        rst_front = 1'b0;
        enqueue = 1'b0;
        dequeue = 1'b0;
        data_in = 2'b00;
        #11 rst = 1'b0;
        #13 dequeue = 1;
        #7 dequeue = 0;
        #17 enqueue = 1;
        repeat(10)
            #23 data_in = data_in + 1;
        #11 enqueue = 0;
        #13 dequeue = 1;
        #360 dequeue = 0;
        #23 rst_front = 1'b1;
        #20 rst_front = 1'b0;
        #13 dequeue = 1;    
        #360 $stop;
    end  
endmodule