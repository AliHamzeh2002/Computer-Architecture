module adderTB ();
    reg[3:0] a,b;
    wire[3:0]out;
    wire cout;
    adder ATB(a, b, 0, out, cout);
    initial begin
        #10 a = 4'b1010;   
        #10 b = 4'b1111;
        #10 $stop;
    end
    
endmodule