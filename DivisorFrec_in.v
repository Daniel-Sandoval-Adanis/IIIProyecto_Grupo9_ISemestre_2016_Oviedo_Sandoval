`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:01:22 03/26/2016 
// Design Name: 
// Module Name:    DivisorFrec_in 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module DivisorFrec_in(
    input wire clk,reset,
    output wire clkm
    );

   reg [8:0] conta;
	reg salida;
   
   always @(posedge clk)
      if (reset) begin
         conta <= 0;
			salida <=0; end
      else if (conta==9'd499) begin
         salida <= ~salida;
			conta <= 9'd0; end
		else
			conta <=conta+ 9'd1;
			
assign clkm = salida;

endmodule
