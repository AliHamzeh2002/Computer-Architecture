module counter(clk, rst, ld, inc, ld_val, cur_val, cout);
    input clk, rst, ld, inc;
    input [1:0] ld_val;
    output reg[1:0] cur_val;
    output reg cout;
    assign cout = &cur_val;
    always @(posedge clk or posedge rst) begin
        if (rst)
            cur_val <= 2'b00;
        else if (ld)
            cur_val <= ld_val;
        else if(inc)
            cur_val <= cur_val + 1;
    end
    
endmodule