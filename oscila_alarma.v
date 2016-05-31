`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:45:13 04/19/2016 
// Design Name: 
// Module Name:    oscila_alarma 
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
module oscila_alarma(
  input wire clk,reset,
    output wire clkm
    );

   reg [7:0] conta;
	reg salida;
   
   always @(posedge clk)
      if (reset) begin
         conta <= 0;
			salida <=0; end
      else if (conta==8'd248) begin
         salida <= ~salida;
			conta <= 8'd0; end
		else
			conta <=conta+ 8'd1;
			
assign clkm = salida;

endmodule

