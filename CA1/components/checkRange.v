module check_range (init_val, cur_val, cout, out_of_range);
    input [3:0] init_val, cur_val;
    input cout;
    output out_of_range;
    assign out_of_range = cout | (init_val == 4'b0000 && cur_val == 4'b1111);
endmodule