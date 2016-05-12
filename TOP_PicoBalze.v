`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:35:55 05/12/2016 
// Design Name: 
// Module Name:    TOP_PicoBalze 
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
module TOP_PicoBalze(
    );

//Declaración de cables
wire	[11:0]	address;
wire	[17:0]	instruction;
wire			bram_enable;
wire	[7:0]		port_id;
wire	[7:0]		out_port;
reg	[7:0]		in_port;
wire			write_strobe;
wire			k_write_strobe;
wire			read_strobe;
wire			interrupt;            //See note above
wire			interrupt_ack;
wire			kcpsm6_sleep;         //See note above
reg			kcpsm6_reset;         //See note above


assign kcpsm6_sleep = 1'b0; //No se utilizan
assign interrupt = 1'b0; // No se utilizan 

// PicoBlaze
 kcpsm6 #(
	.interrupt_vector	(12'h3FF),
	.scratch_pad_memory_size(64),
	.hwbuild		(8'h00))
  processor (
	.address 		(address),
	.instruction 	(instruction),
	.bram_enable 	(bram_enable),
	.port_id 		(port_id),
	.write_strobe 	(write_strobe),
	.k_write_strobe 	(k_write_strobe),
	.out_port 		(out_port),
	.read_strobe 	(read_strobe),
	.in_port 		(in_port),
	.interrupt 		(interrupt),
	.interrupt_ack 	(interrupt_ack),
	.reset 		(kcpsm6_reset),
	.sleep		(kcpsm6_sleep),
	.clk 			(clk)); 

// Memoria de Programa
  <your_program> #(
	.C_FAMILY		   ("V6"),   	//Family 'S6' or 'V6' or 7S for 7-series
	.C_RAM_SIZE_KWORDS	(2),  	//Program size '1', '2' or '4'
	.C_JTAG_LOADER_ENABLE	(1))  	//Include JTAG Loader when set to '1' 
  program_rom (    				//Name to match your PSM file
 	.rdl 			(kcpsm6_reset),
	.enable 		(bram_enable),
	.address 		(address),
	.instruction 	(instruction),
	.clk 			(clk));
	



// Declaración para las entradas:


  always @ (posedge clk)
  begin

      case (port_id[1:0]) 
      
        // Read input_port_a at port address 00 hex
        2'b00 : in_port <= input_port_a;

        // Read input_port_b at port address 01 hex
        2'b01 : in_port <= input_port_b;

        // Read input_port_c at port address 02 hex
        2'b10 : in_port <= input_port_c;

        // Read input_port_d at port address 03 hex
        2'b11 : in_port <= input_port_d;

        // To ensure minimum logic implementation when defining a multiplexer always
        // use don't care for any of the unused cases (although there are none in this 
        // example).

        default : in_port <= 8'bXXXXXXXX ;  

      endcase

  end
  
  
// DEclaración para las salidas

 always @ (posedge clk)
  begin

      // 'write_strobe' is used to qualify all writes to general output ports.
      if (write_strobe == 1'b1) begin

        // Write to output_port_w at port address 01 hex
        if (port_id[0] == 1'b1) begin
          output_port_w <= out_port;
        end

        // Write to output_port_x at port address 02 hex
        if (port_id[1] == 1'b1) begin
          output_port_x <= out_port;
        end

        // Write to output_port_y at port address 04 hex
        if (port_id[2] == 1'b1) begin
          output_port_y <= out_port;
        end

        // Write to output_port_z at port address 08 hex
        if (port_id[3] == 1'b1) begin
          output_port_z <= out_port;
        end

      end

  end



endmodule
