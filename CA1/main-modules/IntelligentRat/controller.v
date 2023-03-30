`define S0 4'b0000
`define S1 4'b0001
`define S2 4'b0010
`define S3 4'b0011
`define S4 4'b0100
`define S5 4'b0101
`define S6 4'b0110
`define S7 4'b0111
`define S8 4'b1000
`define S9 4'b1001
`define S10 4'b1010
`define S11 4'b1011
`define S12 4'b1100
`define S13 4'b1101
`define S14 4'b1110
`define S15 4'b1111
module controller (clk, rst, start, run, wall, finish, co, empty, counter_val, pop_val,
                  rst_reg, rst_counter, ld_reg, ld_counter, inc_counter, adder_sel, inc_dec_sel,
                  x_sel, y_sel, pop, push, rd_mem, wr_mem, mem_din, push_val, counter_ld_val, done, move, fail);
    input clk, rst, start, run, wall, finish, co, empty; 
    input [1:0] counter_val, pop_val;
    output reg rst_reg, rst_counter, ld_reg, ld_counter, inc_counter, adder_sel, inc_dec_sel, x_sel, y_sel, pop, push, rd_mem, wr_mem, mem_din;
    output reg [1:0] push_val, move, counter_ld_val;
    output reg done, fail;
    reg [3:0] ns, ps;
    always @(posedge clk or posedge rst) begin
        if (rst)
            ps <= `S11;
        ps <= ns;
    end
    always @(ps or start or finish or wall or co or empty) begin
        case (ps)
            `S0: ns = start ? `S1 : `S0;
            `S1: ns = `S2;
            `S2: ns = finish ? `S10 : `S3;
            `S3: ns = `S4;
            `S4: ns = wall ? `S5 : `S9;
            `S5: ns = co ? `S6 : `S3;
            `S6: ns = empty ? `S7 : `S8;
            `S7: ns = `S0;
            `S8: ns = `S5;
            `S9: ns = `S2;
            `S10: ns = `S0;
            `S11: ns = `S0;   
            default: ns = `S0;
        endcase
    end
    assign adder_sel = ^counter_val;
    assign inc_dec_sel = counter_val[0]; 
    always @(ps) begin
        {rst_reg, rst_counter, ld_reg, ld_counter, inc_counter,
        x_sel, y_sel, pop, push, rd_mem, wr_mem, adder_sel, inc_dec_sel,
        mem_din, push_val, counter_ld_val, move, done, fail} = 21'b000_000_000_000_000_000_000;
        case (ps)
            `S0:;
            `S1: rst_reg = 1'b1;
            `S2: {rst_counter, wr_mem, mem_din} = 3'b111;
            `S3: 
                begin
                    adder_sel = ^counter_val;
                    inc_dec_sel = counter_val[0]; 
                    x_sel = adder_sel;
                    y_sel = ~x_sel;
                    rd_mem = 1'b1;
                end
            `S4:;
            `S5: inc_counter = 1'b1;
            `S6: {wr_mem, pop, mem_din} = 3'b110;
            `S7: fail = 1'b1;
            `S8: 
                begin
                    adder_sel = ^pop_val;
                    inc_dec_sel = pop_val[0];
                    x_sel = adder_sel;
                    y_sel = ~x_sel;
                    ld_counter = 1;
                    ld_reg = 1;
                    counter_ld_val = pop_val;
                 end
            `S9:
                begin
                    adder_sel = ^counter_val;
                    inc_dec_sel = counter_val[0]; 
                    x_sel = adder_sel;
                    y_sel = ~x_sel;
                    ld_reg = 1'b1;
                    push = 1;
                    push_val = counter_val;
                end
            `S10: done = 1'b1;
            `S11: rst_reg = 1'b1;
            default:;
        endcase
    end
endmodule