module Extend(Imm, ImmSrc, ImmExt);
    input signed [31:7] Imm;
    input [2:0] ImmSrc;
    output reg signed [31:0] ImmExt;

	always @(Imm, ImmSrc) begin
	    case (ImmSrc)
	        3'b000: ImmExt = {{20{Imm[31]}}, Imm[31:20]};
	        3'b001: ImmExt = {{20{Imm[31]}}, Imm[31:25], Imm[11:7]};
	        3'b010: ImmExt = {{19{Imm[31]}}, Imm[31], Imm[7], Imm[30:25], Imm[11:8], 1'b0};
	        3'b011: ImmExt = {{11{Imm[31]}}, Imm[31], Imm[19:12], Imm[20], Imm[30:21], 1'b0};
	        3'b100: ImmExt = {Imm[31:12], 12'b0};
            default: ImmExt = 32'bx;
	    endcase
	end

endmodule
