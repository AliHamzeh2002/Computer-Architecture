module stack_2bit (clk, rst, push, pop, data_in, data_out, empty, full);
    input clk, rst, push, pop;
    input [1:0] data_in;
    output reg [1:0] data_out;
    output reg empty, full;
    reg [1:0] stack_data [0:256];
    reg [8:0] top_index;
    assign empty = (top_index == 0);
    assign full = (top_index == 256);
    always @(posedge clk or posedge rst) begin
        if (rst)
            top_index <= 0;
        else if(pop && !empty) begin
            data_out <= stack_data[top_index - 1];
            top_index <= top_index - 1;
        end
        else if (push && !full) begin
            stack_data[top_index] <= data_in;
            top_index <= top_index + 1; 
        end
    end
endmodule