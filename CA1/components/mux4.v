module mux_4to1_4bit (i0, i1, i2, i3, sel, out);
    input [3:0] i0, i1, i2, i3;
    input [1:0] sel;
    output reg [3:0] out;
    always @(i0 or i1 or i2 or i3 or sel)begin
        case (sel)
            2'b00 : out = i0;
            2'b01 : out = i1;
            2'b10 : out = i2;
            2'b11 : out = i3;
            default: out = 4'bx;
        endcase
    end
endmodule