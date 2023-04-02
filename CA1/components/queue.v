module queue_2bit (clk, rst, rst_front, dequeue, ld, ld_data, rear_index_in, data_out, finish);
    input clk, rst, rst_front, dequeue, ld;
    input [8:0] rear_index_in;
    input [1:0] ld_data [0:256];
    output reg[1:0] data_out;
    output finish;
    reg [1:0] queue_data[0:256];
    reg [8:0] rear_index, front_index;
    assign finish = (rear_index == front_index);
    integer i;
    always @(posedge clk, posedge rst) begin
        if (rst)begin
            rear_index <= 0;
            front_index <= 0;
        end
        else if (rst_front)
            front_index <= 0;
        else if (dequeue && !finish)begin
            data_out <= queue_data[front_index];
            front_index <= front_index + 1;
        end
        else if(ld)begin
            for (i = 0; i < 256; i = i + 1)
                queue_data[i] <= ld_data[i];
            rear_index <= rear_index_in;
            
        end 
    end
    // always @(rear_index) begin
    //     // for (i = 0; i < 256; i = i + 1)
    //     //         $display("%d", ld_data[i]);
    //     $display("REARINDEX: %d", rear_index);
    //     $display("MOVES:");
    //         for (i = 0; i < 256; i = i + 1)
    //             $display("%d", queue_data[i]);

    // end
endmodule