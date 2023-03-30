module rat_in_maze(clk, rst, start, run, done, move, fail);
    input clk, rst, start, run;
    output fail, done;
    output [1:0] move;
    wire rst_reg, rst_counter, ld_reg, ld_counter, inc_counter,
        adder_sel,inc_dec_sel, x_sel, y_sel, pop, push,
        rd_mem, wr_mem, mem_din, co, empty, wall, finish;
    wire [1:0]  push_val, counter_ld_val, counter_val, pop_val;
    datapath dp(clk, rst_reg, rst_counter, ld_reg, ld_counter, inc_counter, adder_sel,
                 inc_dec_sel, x_sel, y_sel, pop, push, rd_mem, wr_mem, mem_din,
                 push_val, counter_ld_val, co, counter_val, pop_val, empty, wall, finish);
    controller cu(clk, rst, start, run, wall, finish, co, empty, counter_val, pop_val,
                  rst_reg, rst_counter, ld_reg, ld_counter, inc_counter, adder_sel, inc_dec_sel,
                  x_sel, y_sel, pop, push, rd_mem, wr_mem, mem_din, push_val, counter_ld_val, done, move, fail);

endmodule