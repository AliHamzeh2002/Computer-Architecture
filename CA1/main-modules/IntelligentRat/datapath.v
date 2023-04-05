module datapath (clk, rst_reg, rst_counter, rst_frontq, ld_reg, ld_counter, ld_q, inc_counter, adder_sel,
                 inc_dec_sel, x_sel, y_sel, pop, push, dequeue, rd_mem, wr_mem, mem_din,
                 push_val, counter_ld_val, q_out, co, counter_val, pop_val, empty,
                 finishq, wall, finish);
    input clk, rst_reg, rst_counter, ld_reg, ld_counter, inc_counter, adder_sel, inc_dec_sel, x_sel, y_sel, pop, push, rd_mem, wr_mem, mem_din, rst_frontq, ld_q, dequeue;
    input [1:0] push_val, counter_ld_val;
    output co, wall, finish, empty, finishq;
    output [1:0] counter_val, pop_val, q_out;
    wire[3:0] cur_x, cur_y, mem_x, mem_y, adder_inp, adder_res;   
    wire cout, out_of_range, full, mem_dout;
    wire [1:0] stack_data [0:256];
    wire [8:0] stk_top_index;
    register4bit regx(clk, rst_reg, ld_reg, mem_x, cur_x);
    register4bit regy(clk, rst_reg, ld_reg, mem_y, cur_y);
    mux_2to1_4bit mux1(cur_y, cur_x, adder_sel, adder_inp);
    mux_2to1_4bit mux3(cur_y, adder_res, y_sel, mem_y);
    mux_2to1_4bit mux4(cur_x, adder_res, x_sel, mem_x);
    //adder addr(adder_inp, inc_dec, 0, adder_res, cout);
    inc_or_dec inc_dec(adder_inp, inc_dec_sel, adder_res);
    check_range chr(adder_res, inc_dec_sel, out_of_range);
    maze_memory mem(clk, rst_reg, rd_mem, wr_mem, mem_x, mem_y, mem_din, mem_dout);
    stack_2bit stk(clk, rst_reg, push, pop, push_val, pop_val, empty, full, stack_data, stk_top_index);
    queue_2bit queue(clk, rst, rst_frontq, dequeue, ld_q, stack_data, stk_top_index, q_out, finishq);
    counter counter(clk, rst_counter, ld_counter, inc_counter, counter_ld_val, counter_val, co);
    assign wall = out_of_range | mem_dout;
    assign finish = &{cur_x,cur_y};
    always @(cur_x or cur_y) begin
        $display("x: %d, y:%d", cur_x, cur_y);
    end
    always @(posedge clk) begin
        if (dequeue)
            $display("dequeueOUT: %d", q_out);
    end
endmodule