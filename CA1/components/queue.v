module queue_2bit (clk, rst, rst_front, enqueue, dequeue, data_in, data_out, finish, full);
    input clk, rst, rst_front, enqueue, dequeue;
    input [1:0] data_in;
    output reg[1:0] data_out;
    output finish, full;
    reg [1:0] queue_data[0:256];
    reg [8:0] rear_index, front_index;
    assign finish = (rear_index == front_index);
    assign full = (rear_index == 256);
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
        else if (enqueue && !full)begin
            queue_data[rear_index] <= data_in;
            rear_index <= rear_index + 1;
        end
    end
endmodule