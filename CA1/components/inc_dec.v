module inc_or_dec (data_in, inc_dec_sel, result);
    input inc_dec_sel;
    input [3:0] data_in;    
    output reg [3:0] result;
    reg cout;
    always @(data_in or inc_dec_sel) begin
        case (inc_dec_sel)
            1'b1: {cout, result} = data_in + 1;
            1'b0: {cout, result} = data_in - 1;
        endcase
    end
endmodule