module mux_4to1 (i0, i1, i2, i3, sel, out);
    input i0, i1, i2, i3;
    input [1:0] sel;
    output reg out;

    always @(i0 or i1 or i2 or i3 or sel)begin
        case (sel)
            2'b00 : out = i0;
            2'b01 : out = i1;
            2'b10 : out = i2;
            2'b03 : out = i3;
            default: out = 1'bx;
        endcase
    end

endmodule