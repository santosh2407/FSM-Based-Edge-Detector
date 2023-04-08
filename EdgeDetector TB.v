`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.04.2023 23:58:06
// Design Name: 
// Module Name: edgeDetectortb
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


module edgeDetectortb;

 reg level;
 reg clk;
 reg rst;

 wire mealy_tick,moore_tick;

edgeDetector uut (.level(level),.clk(clk),.rst(rst),.mealy_tick(mealy_tick),.moore_tick(moore_tick));
 initial begin
 clk = 0;
 forever #5 clk = ~clk;
 end 
 initial begin
 clk <= 0;
		level <= 0;
		#15 level <= 1;
		#20 level <= 0;
		#15 level <= 1;
		#10 level <= 0;
		#20 $finish;
	end	
  
  	
initial begin
      	$dumpvars;
      $dumpfile("dump.vcd");
    end
     
endmodule

