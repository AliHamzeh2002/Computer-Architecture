module datapath (clk, rst_reg, rst_counter, ld_reg, ld_counter, inc_counter, adder_sel,
                 inc_dec_sel, x_sel, y_sel, pop, push, rd_mem, wr_mem, mem_din,
                 push_val, counter_ld_val, co, counter_val, pop_val, empty, wall, finish, mem_dout, range, x_o, y_o, rd_fl);
    input clk, rst_reg, rst_counter, ld_reg, ld_counter, inc_counter, adder_sel, inc_dec_sel, x_sel, y_sel, pop, push, rd_mem, wr_mem, mem_din;
    input [1:0] push_val, counter_ld_val;
    output co, wall, finish, empty;
    output [1:0] counter_val, pop_val;
    wire[3:0] cur_x, cur_y, mem_x, mem_y, adder_inp, inc_dec, adder_res;   
    wire cout, out_of_range, full;//, mem_dout;
    output mem_dout, range, rd_fl;
    output [3:0] x_o, y_o;
    assign x_o = mem_x;
    assign y_o = mem_y;
    assign rd_fl = rd_mem;
    assign range = out_of_range;
    register4bit regx(clk, rst_reg, ld_reg, mem_x, cur_x);
    register4bit regy(clk, rst_reg, ld_reg, mem_y, cur_y);
    mux_2to1_4bit mux1(cur_y, cur_x, adder_sel, adder_inp);
    mux_2to1_4bit mux2(4'b1111, 4'b0001, inc_dec_sel, inc_dec);
    mux_2to1_4bit mux3(cur_y, adder_res, y_sel, mem_y);
    mux_2to1_4bit mux4(cur_x, adder_res, x_sel, mem_x);
    adder addr(adder_inp, inc_dec, 0, adder_res, cout);
    check_range chr(adder_res, inc_dec, cout, out_of_range);
    maze_memory mem(clk, rst_reg, rd_mem, wr_mem, mem_x, mem_y, mem_din, mem_dout);
    stack_2bit stk(clk, rst_reg, push, pop, push_val, pop_val, empty, full);
    counter counter(clk, rst_counter, ld_counter, inc_counter, counter_ld_val, counter_val, co);
    assign wall = out_of_range | mem_dout;
    assign finish = &{cur_x,cur_y};
    always @(cur_x or cur_y) begin
        $display("x: %d, y:%d", cur_x, cur_y);
    end
endmodule