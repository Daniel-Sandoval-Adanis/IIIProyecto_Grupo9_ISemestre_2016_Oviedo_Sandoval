`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:06:44 05/17/2016 
// Design Name: 
// Module Name:    kb_code 
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
module kb_code(
    input wire clk, reset,
    input wire ps2d, ps2c,
    output reg [7:0] port_in02,// dato del codigo de la tecla
	 output reg [7:0] port_in01,//registro que le va a indicar al pico cuando debe leer el dato
	 input  wire [7:0] port_out0E//registro que me va a indicar si ya tomó el dato
   );

   // constant declaration
   localparam BRK = 8'hf0; // break code es f0, se modifico a ff para simular

   // symbolic state declaration
   localparam
      wait_brk = 2'b01,
      get_code = 2'b10,
		rx_disable = 2'b11;

   // signal declaration
   reg [1:0] state_reg, state_next;
   wire [7:0] scan_out;
	reg got_code_tick;
   wire scan_done_tick;
	reg rx_en;
	

   // body
   //====================================================
   // instantiation
   //====================================================
   // instantiate ps2 receiver
   PS2 ps2_rx_unit
      (.clk(clk), .reset(reset), .rx_en(rx_en),
       .ps2d(ps2d), .ps2c(ps2c),
       .rx_done_tick(scan_done_tick), .dout(scan_out));


   //=======================================================
   // FSM to get the scan code after F0 received
   //=======================================================
	//flip flop D	
  always @(posedge clk) begin//la entrada del flip flop es scan_out=dout.
      if (reset) begin
         port_in02 <= 8'd0;
      end else if (got_code_tick)begin
         port_in02 <= scan_out;
      end
	end
	
	// 
	
   // state registers
   always @(posedge clk, posedge reset)
      if (reset)
         state_reg <= wait_brk;
      else
         state_reg <= state_next;

   // next-state logic
   always @*
   begin
      got_code_tick = 1'b0;
      state_next = state_reg;
		rx_en=1'b1;
		port_in01=8'd0;
      case (state_reg)
         
			wait_brk:  // wait for F0 of break code
            if (scan_done_tick==1'b1 && scan_out==BRK)
               state_next = get_code;
         
			get_code:  // get the following scan code
            if (scan_done_tick)
               begin
                  got_code_tick =1'b1;//esta variable se pone en uno esta variable es la que me va a activar el flipflop
						rx_en = 1'b0;
                  state_next = rx_disable;//se devuelve al inicio
               end
			
			rx_disable: begin //desabilito el rx_en para que no lea más
				if (port_out0E==  8'b00000001) //si se activo el control de lectura y ya se tomó el dato
						state_next = wait_brk;// vaya al estado de inicio
				else
					state_next = rx_disable;// pero entonces quedese en este estado hasta que se cumpla la condición
				rx_en=1'b0;
				port_in01=8'd1;
				end
				
      endcase
   end

endmodule
