module check_range (val, op, cout, out_of_range);
    input [3:0] val;
    input [3:0] op;
    input cout;
    output out_of_range;
    assign out_of_range = cout | (op == 4'b1111 && val == 4'b1111);
endmodule