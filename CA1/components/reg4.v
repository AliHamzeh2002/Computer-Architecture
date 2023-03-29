module register4bit (clk, rst, ld, data_in, data_out);
    input clk, rst, ld;
    input[3:0] data_in;
    output reg[3:0] data_out;
    always @(posedge clk or posedge rst) begin
        if (rst)
            data_out <= 4'b0000;
        else if(ld)
            data_out <= data_in;
    end
endmodule