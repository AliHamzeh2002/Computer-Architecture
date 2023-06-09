module Hazard_Unit(Rs1D, Rs2D, Rs1E, Rs2E, RdE, PCSrcE, ResultSrcE0, RdM, RdW, RegWriteM, RegWriteW, StallF, StallD, FlushD, FlushE, ForwardAE, ForwardBE);
    input ResultSrcE0, RegWriteM, RegWriteW, PCSrcE;
    input [4:0] Rs1D, Rs2D, Rs1E, Rs2E, RdE, RdM, RdW;
    output StallF, StallD, FlushD, FlushE;
    output reg [1:0] ForwardAE, ForwardBE;
    reg LWStall;
    assign StallD = LWStall;
    assign StallF = LWStall;
    assign FlushD = PCSrcE;
    assign FlushE = LWStall | PCSrcE;
    always @(Rs1D, Rs2D, Rs1E, Rs2E, RdE, ResultSrcE0, RdM, RdW, RegWriteM, RegWriteW) begin
        if (Rs1E == RdM && RegWriteM && Rs1E != 0)
            ForwardAE = 2'b10;
        else if (Rs1E == RdW && RegWriteW && Rs1E != 0)
            ForwardAE = 2'b01;
        else
            ForwardAE = 2'b00;
        if (Rs2E == RdM && RegWriteM && Rs2E != 0)
            ForwardBE = 2'b10;
        else if (Rs2E == RdW && RegWriteW && Rs2E != 0)
            ForwardBE = 2'b01;
        else
            ForwardBE = 2'b00;
        LWStall = ((Rs1D == RdE) | (Rs2D == RdE)) & ResultSrcE0;
    end


endmodule