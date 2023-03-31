module check_range (val, op, cout, out_of_range);
    input [3:0] val;
    input [3:0] op;
    input cout;
    output out_of_range;
    assign out_of_range = (op == 4'b0001 && val == 4'b0000) | (op == 4'b1111 && val == 4'b1111);
endmodule