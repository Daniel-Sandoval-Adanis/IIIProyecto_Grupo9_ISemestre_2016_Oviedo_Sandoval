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
module TOP_PicoBalze #(parameter N=8)(
	input wire clk, reset,ps2d,ps2c,
	output read_strobe,interrupt_ack,
	output wire AD,CS,WR,RD,
	inout [N-1:0] salient
    );

//Declaración de cables
wire	[11:0]	address;
wire	[17:0]	instruction;
wire			bram_enable;
wire	[N-1:0]		port_id;
wire	[N-1:0]		out_port;
reg	[N-1:0]		in_port;
wire			write_strobe;
wire			k_write_strobe;
//wire			read_strobe;
wire			interrupt;            //See note above
//wire			interrupt_ack;
wire			kcpsm6_sleep;         //See note above
wire			kcpsm6_reset;         //See note above

// Senales de conexion de los controladores
//salidas
reg	[N-1:0]	port_out00;
reg	[N-1:0]	port_out01;
reg	[1:0]	port_out02;
//Faltan los de la VGA
reg	[N-1:0] port_out0E;
//Entradas
wire	[N-1:0]	port_in00;
wire	[N-1:0]  port_in01;
wire	[N-1:0]  port_in02;

// Para ponerlos a GND
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
  memoria #(
	.C_FAMILY		   ("S6"),   	//Family 'S6' or 'V6' or 7S for 7-series
	.C_RAM_SIZE_KWORDS	(2),  	//Program size '1', '2' or '4'
	.C_JTAG_LOADER_ENABLE	(0))  	//Include JTAG Loader when set to '1' 
  program_rom (    				//Name to match your PSM file
 	.rdl 			(kcpsm6_reset),
	.enable 		(bram_enable),
	.address 		(address),
	.instruction 	(instruction),
	.clk 			(clk));
	
// controlador RTC
Controlador_RTC u1 (
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

// Controlador Teclado PS2
kb_code u2 (
    .clk(clk), 
    .reset(reset), 
    .ps2d(ps2d), 
    .ps2c(ps2c), 
    .port_in02(port_in02), 
    .port_in01(port_in01), 
    .port_out0E(port_out0E)
    );


// Declaración para las entradas:


  always @ (posedge clk)
  begin

      case (port_id[1:0]) 
      
        // Read input_port_a at port address 00 hex
        2'b00 : in_port <= port_in00;
		  2'b01 : in_port <= port_in01;
		  2'b10 : in_port <= port_in02;
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
      if (write_strobe == 1'b1 || k_write_strobe == 1'b1 ) begin

        // Write to output_port_w at port address 01 hex
        if (port_id[3:0] == 4'b0000) begin
          port_out00 <= out_port;
        end

        // Write to output_port_x at port address 02 hex
        if (port_id[3:0] == 4'b0001) begin
          port_out01 <= out_port;
        end

        // Write to output_port_y at port address 04 hex
        if (port_id[3:0] == 4'b0010) begin
          port_out02[1:0] <= out_port[1:0];
        end

        if (port_id[3:0] == 4'b1110) begin
          port_out0E <= out_port;
        end

      end

  end



endmodule
