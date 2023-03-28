module maze_memory(clk, rst, rd, wr, x_pos, y_pos, data_in, data_out);
    input clk, rst, rd, wr, data_in;
    input[3:0] x_pos, y_pos;
    output reg data_out;
    reg[0:16] memory[0:16];
    integer i;

    always @(posedge clk, posedge rst, posedge rd) begin
        if (rst)begin
            $readmemh("map.data", memory);
            //for (i = 0; i < 16; i = i + 1)
               // $display("%b", memory[i][0]);
        end
        else if (rd)
            data_out = memory[y_pos][x_pos];
        else if (wr)
            memory[y_pos][x_pos] <= data_in; 
    end
endmodule