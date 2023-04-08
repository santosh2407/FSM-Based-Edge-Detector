`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2023 23:56:52
// Design Name: 
// Module Name: edgeDetector
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module edgeDetector
(
    input wire clk, reset, 
    input wire level, 
    output reg Mealy_tick, Moore_tick
);

localparam 
    zeroMealy = 1'b0,
    oneMealy =  1'b1;
    
localparam [1:0] 
    zeroMoore = 2'b00,
    edgeMoore = 2'b01, 
    oneMoore = 2'b10;

reg stateMealy_reg, stateMealy_next; 
reg[1:0] stateMoore_reg, stateMoore_next;

always @(posedge clk, posedge reset)
begin
    if(reset) 
        begin
        stateMealy_reg <= zeroMealy;
        stateMoore_reg <= zeroMoore;
        end
    else
        begin
        stateMealy_reg <= stateMealy_next;
        stateMoore_reg <= stateMoore_next;
        end
end
always @(stateMealy_reg, level)
begin
    
    stateMealy_next = stateMealy_reg; 
    
    Mealy_tick = 1'b0;
    case(stateMealy_reg)
        zeroMealy:
            if(level)  
                begin
                    stateMealy_next = oneMealy; 
                    Mealy_tick = 1'b1;
                end
        oneMealy: 
            if(~level) 
                stateMealy_next = zeroMealy; 
    endcase
end

always @(stateMoore_reg, level)
begin
   
    stateMoore_next = stateMoore_reg;
    
    Moore_tick = 1'b0; 
    case(stateMoore_reg)
        zeroMoore: 
            if(level) 
                stateMoore_next = edgeMoore; 
        edgeMoore:
            begin
                Moore_tick = 1'b1; 
                if(level) 
                    stateMoore_next = oneMoore;
                else    
                    stateMoore_next = zeroMoore; 
            end
        oneMoore: 
            if(~level) 
                stateMoore_next = zeroMoore;
     endcase
end
endmodule 
