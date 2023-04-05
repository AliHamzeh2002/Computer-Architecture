module check_range (val, op, out_of_range);
    input [3:0] val;
    input op;
    output out_of_range;
    assign out_of_range = (op == 1'b1 && val == 4'b0000) | (op == 1'b0 && val == 4'b1111);
endmodule