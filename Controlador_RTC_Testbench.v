`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:51:49 05/12/2016
// Design Name:   Controlador_RTC
// Module Name:   C:/Users/Daniel/Documents/PicoBalze_IIIProyecto/III_Proyecto_PicoBlaze/Controlador_RTC_Testbench.v
// Project Name:  III_Proyecto_PicoBlaze
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Controlador_RTC
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module Controlador_RTC_Testbench;

	// Inputs
	reg clk;
	reg reset;
	reg [7:0] port_out00;
	reg [7:0] port_out01;
	reg [1:0] port_out02;

	// Outputs
	wire [7:0] port_in00;
	wire AD;
	wire CS;
	wire WR;
	wire RD;

	// Bidirs
	wire [7:0] salient;

	// Instantiate the Unit Under Test (UUT)
	Controlador_RTC uut (
		.clk(clk), 
		.reset(reset), 
		.port_out00(port_out00), 
		.port_out01(port_out01), 
		.port_out02(port_out02), 
		.port_in00(port_in00), 
		.AD(AD), 
		.CS(CS), 
		.WR(WR), 
		.RD(RD), 
		.salient(salient)
	);

 parameter PERIOD = 10;

always begin
      clk = 1'b0;
      #(PERIOD/2) clk = 1'b1;
      #(PERIOD/2);
   end 

	initial begin
		// Initialize Inputs
		clk = 0;
		reset = 1;
		port_out00 = 0;
		port_out01 = 0;
		port_out02 = 0;

		// Wait 100 ns for global reset to finish
		#50;
		// Add stimulus here
		reset=0;
		#40;
		port_out00 = 8'h12;
		port_out01 = 8'h23;
		port_out02 = 2'b01;
		#80;
		port_out02 = 2'b00;
		#700;
		port_out02 = 2'b11;
		#80;
		port_out02 = 2'b10;
		#1000;

	$stop;
	end
      
endmodule

