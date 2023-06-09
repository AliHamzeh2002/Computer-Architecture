module Instruction_Memory(A, RD);
    input [31:0] A;
    output [31:0] RD;

    reg [31:0] InstMem[15999:0];

    initial begin
        $readmemh("tests/test1/AssemblyHexCode.txt", InstMem);
    end

    assign RD = InstMem[A>>2];

endmodule