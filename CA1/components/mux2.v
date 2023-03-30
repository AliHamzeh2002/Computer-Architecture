module mux_2to1_4bit (i0, i1, sel, out);
    input [3:0] i0, i1;
    input sel;
    output reg [3:0] out;
    always @(i0 or i1 or sel)begin
        case (sel)
            1'b0 : out = i0;
            1'b1 : out = i1;
            default: out = 4'bx;
        endcase
    end
endmodule