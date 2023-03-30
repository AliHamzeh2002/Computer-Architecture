module datapath (clk, rst_reg, rst_counter, ld_reg, ld_counter, inc_counter, adder_sel,
                 inc_dec_sel, x_sel, y_sel, pop, push, rd_mem, wr_mem, mem_din,
                 push_val, counter_ld_val, co, counter_val, pop_val, empty, wall, finish);
    input clk, rst_reg, rst_counter, ld_reg, ld_counter, inc_counter, adder_sel, inc_dec_sel, x_sel, y_sel, pop, push, rd_mem, wr_mem, mem_din;
    input [1:0] push_val, counter_ld_val;
    output co, wall, finish, empty;
    output reg[1:0] counter_val, pop_val;
    wire[3:0] cur_x, cur_y, mem_x, mem_y, adder_inp, inc_dec, adder_res;   
    wire cout, out_of_range, mem_dout, full;
    register4bit(clk, rst_reg, ld_reg, mem_x, cur_x);
    register4bit(clk, rst_reg, ld_reg, mem_y, cur_y);
    mux_2to1_4bit(cur_y, cur_x, adder_sel, adder_inp);
    mux_2to1_4bit(4'b1111, 4'b0001, inc_dec_sel, inc_dec);
    mux_2to1_4bit(cur_y, adder_res, y_sel, mem_y);
    mux_2to1_4bit(cur_x, adder_res, x_sel, mem_x);
    adder(adder_inp, inc_dec, 0, adder_res, cout);
    check_range(adder_res, inc_dec, cout, out_of_range);
    maze_memory(clk, rst_reg, rd_mem, wr_mem, mem_x, mem_y, mem_din, mem_dout);
    stack(clk, rst_reg, push, pop, push_val, pop_val, empty, full);
    counter(clk, rst_counter, ld_counter, inc_counter, counter_ld_val, counter_val, co);
    assign wall = out_of_range | mem_dout;
    assign finish = &{cur_x,cur_y};
endmodule