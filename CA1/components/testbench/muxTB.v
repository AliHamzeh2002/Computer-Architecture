module muxTB ();
    reg[3:0] i0, i1, i2, i3;
    reg[1:0] sel;
    wire[3:0] out;
    mux_4to1_4bit MUXTB(i0, i1, i2, i3, sel, out);
    initial begin
        i0 = 0;
        i1 = 0;
        i2 = -1;
        i3 = 1;
        sel = 0;
        repeat(10)
            #10 sel = sel + 1;
        #20 $stop;
    end
    
endmodule