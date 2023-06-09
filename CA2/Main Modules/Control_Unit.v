`define lw   7'b0000011
`define sw   7'b0100011
`define RT   7'b0110011
`define BT   7'b1100011
`define IT   7'b0010011
`define jalr 7'b1100111
`define jal  7'b1101111
`define lui  7'b0110111

module Controller_SC(op, func3, func7, Zero, lt, JumpTargetSel,
    PCSrc, ResultSrc, MemWrite, ALUControl, ALUSrc, ImmSrc, RegWrite, done);
    
    input [6:0] op, func7;
    input [2:0] func3;
    input Zero, lt;

    output PCSrc;
    output reg JumpTargetSel, MemWrite, ALUSrc, RegWrite;
    output reg [1:0] ResultSrc;
    output reg [2:0] ImmSrc;
    output [2:0] ALUControl;
    output reg done;

    reg[1:0] aluOp;

    reg jmp, branch;

    wire beq, bne, blt, bge;

    assign beq = branch & (func3 == 3'b000);

    assign bne = branch & (func3 == 3'b001);

    assign blt = branch & (func3 == 3'b100);

    assign bge = branch & (func3 == 3'b101);

    assign PCSrc = jmp | (beq & Zero) | (bne & ~Zero) | (blt & lt) | (bge & ~lt);

    assign ALUControl = (aluOp == 2'b00)? 3'b000:

        (aluOp == 2'b01)? 3'b001:

        (aluOp == 2'b11)? 3'b100:

        (aluOp == 2'b10)? (func3 == 3'b000)? ((op == `RT & func7 == 7'b0100000)? 3'b001: 3'b000):

        (func3 == 3'b111)? 3'b010:

        (func3 == 3'b100)? 3'b111:

        (func3 == 3'b110)? 3'b011:

        (func3 == 3'b010)? 3'b101: 3'b000: 3'b000;



    always@(op, func3, func7) begin
        {JumpTargetSel, MemWrite, ALUSrc, RegWrite, jmp, branch, done} = 7'b0;

        ResultSrc = 2'b00;

        aluOp = 2'b00;

        ImmSrc = 3'b000;



     case(op)

      `lw:   begin RegWrite = 1; ALUSrc = 1; ResultSrc = 2'b01; end

      `sw:   begin ImmSrc = 3'b001; ALUSrc = 1; MemWrite = 1; end

      `RT:   begin RegWrite = 1; aluOp = 2'b10; end

      `BT:   begin ImmSrc = 3'b010; branch = 1; aluOp = 2'b01; end

      `IT:   begin RegWrite = 1; ALUSrc = 1; aluOp = 2'b10; end

      `jal:  begin RegWrite = 1; ImmSrc = 3'b011; ResultSrc = 2'b10; jmp = 1; end

      `jalr: begin RegWrite = 1; ALUSrc = 1; jmp = 1; JumpTargetSel = 1; end

      `lui:  begin RegWrite = 1; ImmSrc = 3'b100; aluOp = 2'b11; end
      default: done = 1;

    endcase

    end

endmodule