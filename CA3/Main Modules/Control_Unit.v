`define lw   7'b0000011
`define sw   7'b0100011
`define RT   7'b0110011
`define BT   7'b1100011
`define IT   7'b0010011
`define jalr 7'b1100111
`define jal  7'b1101111
`define lui  7'b0110111

`define S0  5'd0
`define S1  5'd1
`define S2  5'd2
`define S3  5'd3
`define S4  5'd4
`define S5  5'd5
`define S6  5'd6
`define S7  5'd7
`define S8  5'd8
`define S9  5'd9
`define S10 5'd10
`define S11 5'd11
`define S12 5'd12
`define S13 5'd13
`define S14 5'd14
`define S15 5'd15
`define S16 5'd16
`define S17 5'd17
`define S18 5'd18
`define S19 5'd19
`define S20 5'd20

module Controller_MC(clk, rst, op, func3, func7, Zero, lt,
    AdrSrc, ResultSrc, PCWrite, IRWrite, MemWrite, ALUControl, ALUSrcA, ALUSrcB, ImmSrc, RegWrite, done);

    // Input ports
    input clk, rst;
    input [6:0] op, func7;
    input [2:0] func3;
    input Zero, lt;
    // Output ports
    output reg AdrSrc, RegWrite, IRWrite, MemWrite, PCWrite, done;
    output reg [1:0] ResultSrc, ALUSrcA, ALUSrcB;
    output reg [2:0] ImmSrc;
    output [2:0] ALUControl;
    // Wire and regs
    reg[1:0] ALUOp;
    reg branch;
    wire beq, bne, blt, bge;
    reg[4:0] ns, ps = `S0;

    assign beq = branch & (func3 == 3'b000);
    assign bne = branch & (func3 == 3'b001);
    assign blt = branch & (func3 == 3'b100);
    assign bge = branch & (func3 == 3'b101);

    assign PCSrc = jmp | (beq & Zero) | (bne & ~Zero) | (blt & lt) | (bge & ~lt);

    assign ALUControl = 
        (ALUOp == 2'b00) ? 3'b000 :
        (ALUOp == 2'b01) ? 3'b001 :
        (ALUOp == 2'b11) ? 3'b100 :
        (ALUOp == 2'b10) ? 
        (func3 == 3'b000) ? ((op == `RT & func7 == 7'b0100000) ? 3'b001: 3'b000) :
        (func3 == 3'b111) ? 3'b010 :
        (func3 == 3'b100) ? 3'b111 :
        (func3 == 3'b110) ? 3'b011 :
        (func3 == 3'b010) ? 3'b101 : 3'b000 : 3'b000;



    always@(op, func3, func7) begin
        ns = `S0;
        {ResultSrc, AluSrcB, AluSrcA, AluOp, ImmSrc, PCWrite, AdrSrc, MemWrite, IRWrite, RegWrite, branch, done} = 18'd0;

        case(ps)
            `S0:  begin IRWrite = 1; ALUSrcB = 2'b10; ResultSrc = 2'b10; PCWrite = 1; ns = `S1; end
            `S1:  begin 
                ALUSrcB = 2'b01; 
                ALUSrcA = 2'b01;
                ImmSrc = 3'b010; 
                ns= (op == `lw) ? `S3 :
      	            (op == `sw) ?   `S6 :
      	            (op == `RT) ?   `S8 :
      	            (op == `BT) ?   `S2 :
      	            (op == `IT) ?   `S10 :
      	            (op == `jalr) ? `S12 :
      	            (op == `jal) ?  `S15 :
      	            (op == `lui) ?  `S18 : `S20;
            end
    	    `S2:  begin 
                ALUSrcA = 2'b10; 
                ALUOp = 2'b01;
                branch = 1;
                PCWrite = 
                    (beq & Zero) ? 1 :
					(bne & ~Zero) ? 1 :
					(blt & lt) ? 1 :
					(bge & ~lt) ? 1 : 0;
		        ns = `S0; 
            end
            `S3:  begin ALUSrcA = 2'b10; ALUSrcB = 2'b01; ns = `S4; end
            `S4:  begin AdrSrc = 1; ns = `S5; end
            `S5:  begin ResultSrc = 2'b01; RegWrite = 1; ns = `S0; end
            `S6:  begin ImmSrc = 3'b001; ALUSrcA = 2'b10; ALUSrcB = 2'b01; ns = `S7; end
            `S7:  begin AdrSrc = 1; MemWrite = 1; ns = `S0; end
            `S8:  begin ALUSrcA = 2'b10; ALUOp = 2'b10; ns = `S9; end
            `S9:  begin RegWrite = 1; ns = `S0; end
            `S10: begin ALUSrcA = 2'b10; ALUSrcB = 2'b01; ALUOp = 2'b10; ns = `S11; end
            `S11: begin RegWrite = 1; ns = `S0; end
            `S12: begin ALUSrcA = 2'b10; ALUSrcB = 2'b01; ns = `S13; end
            `S13: begin PCWrite = 1; ALUSrcA = 2'b01; ALUSrcB = 2'b10; ns = `S14; end
            `S14: begin RegWrite = 1; ns = `S0; end
            `S15: begin ALUSrcA = 2'b01; ALUSrcB = 2'b01; ImmSrc = 3'b011; ns = `S16; end
            `S16: begin PCWrite = 1; ALUSrcA = 2'b01; ALUSrcB = 2'b10; ns = `S17; end
            `S17: begin RegWrite = 1; ns = `S0; end
            `S18: begin ImmSrc = 3'b100; ALUSrcB = 2'b01; ALUOp = 2'b11; ns = `S19; end
            `S19: begin RegWrite = 1; ns = `S0; end
  	        `S20: begin done = 1; ns = `S20; end
        endcase

    end

    always@(posedge clk) begin
        ps <= ns;
    end

endmodule