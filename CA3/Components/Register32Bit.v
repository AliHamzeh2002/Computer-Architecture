`define DefaultValue 32'd0

module Register32Bit(clk, rst, we, nxt, cur);
    input clk, rst, we;
    input [31:0] nxt;
    output reg [31:0] cur;

    always @(posedge clk or posedge rst) begin
        if (rst)
            cur = `DefaultValue;
        else if (we == 1'b1)
            cur = nxt;
    end

endmodule