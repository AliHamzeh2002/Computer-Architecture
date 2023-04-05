module maze_memory(clk, rst, rd, wr, x_pos, y_pos, data_in, data_out);
    input clk, rst, rd, wr, data_in;
    input[3:0] x_pos, y_pos;
    output reg data_out;
    reg[0:15] memory[0:15];
    always @(posedge clk or posedge rst or posedge rd) begin
        if (rst)
            $readmemh("testcases/map11.data", memory);
        else if (rd)
            data_out = memory[y_pos][x_pos];
        else if (wr)
            memory[y_pos][x_pos] <= data_in; 
    end
endmodule