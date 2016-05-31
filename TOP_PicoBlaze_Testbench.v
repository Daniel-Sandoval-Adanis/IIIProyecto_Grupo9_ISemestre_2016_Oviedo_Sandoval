`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   12:47:22 05/16/2016
// Design Name:   TOP_PicoBalze
// Module Name:   C:/Users/Daniel/Documents/PicoBalze_IIIProyecto/III_Proyecto_PicoBlaze/TOP_PicoBlaze_Testbench.v
// Project Name:  III_Proyecto_PicoBlaze
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: TOP_PicoBalze
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TOP_PicoBlaze_Testbench;

	// Inputs
	reg clk;
	reg reset;
	reg ps2d;
	reg ps2c;

	// Outputs
	wire read_strobe;
	wire interrupt_ack;
	wire [2:0] text_rgb;
	wire AD;
	wire CS;
	wire WR;
	wire RD;
	wire hsync;
	wire vsync;

	// Bidirs
	wire [7:0] salient;

	// Instantiate the Unit Under Test (UUT)
	TOP_PicoBalze uut (
		.clk(clk), 
		.reset(reset),
		.ps2d(ps2d),
		.ps2c(ps2c),
		.read_strobe(read_strobe), 
		.interrupt_ack(interrupt_ack),
		.text_rgb(text_rgb),
		.AD(AD), 
		.CS(CS), 
		.WR(WR), 
		.RD(RD),
		.hsync(hsync),
		.vsync(vsync),
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
		ps2d=0;
		ps2c=0;
		#50;
		reset=0;

		// Wait 100 ns for global reset to finish
		#20000;
      $stop;
		// Add stimulus here

	end
      
endmodule

