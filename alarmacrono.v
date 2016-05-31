`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:40 04/16/2016 
// Design Name: 
// Module Name:    alarmacrono 
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
module alarmacrono(
	input wire clk, reset ,IRQN,
	output reg salida
	);
//Divisores

wire clkm1,clkm2,clkm3;

DivisorFrec_in u1 (
    .clk(clk), 
    .reset(reset), 
    .clkm(clkm1)
    );

DivisorFrec_in u2 (
    .clk(clkm1), 
    .reset(reset), 
    .clkm(clkm2)
    );
	 
oscila_alarma u3 (
    .clk(clkm2), 
    .reset(reset), 
    .clkm(clkm3)
    );
// Timer 
reg Trst;
wire [3:0] timer;
Timer T0 (
    .clk(clkm3), 
    .Trst(Trst), 
    .timer(timer)
    );

// s y m b o l i c s t a t e d e c l a r a t i o n
localparam [3:0] 	inicia = 4'b0000,
						a = 4'b0001,
						b = 4'b0010,
						c = 4'b0011,
						d = 4'b0100,
						e = 4'b0101,
						f = 4'b0110,
						g = 4'b0111,
						h = 4'b1000,
						i = 4'b1001,
						j = 4'b1010,
						k = 4'b1011;
						
// s i g n a l d e c l a r a t i o n
reg [3:0] state_reg ,state_next;

// s t a t e r e g i s t e r
always @(posedge clk , posedge reset)
	if (reset)
		state_reg <= inicia;
	else
		state_reg <=state_next;
		
// n e x t - s t a t e l o g i c
always @*
begin
Trst=1'b1;
salida=1'b0;
	case (state_reg)
		inicia:begin 					 
				if (IRQN)
					state_next=a;
				else
					state_next=inicia;
				end
		a: begin
				state_next=b;
			end
				
		b:  begin	
				if(timer == 4'd10)// Parpadea la señal de alarma
					state_next=inicia;
				else begin
					Trst=0;
					state_next=b; end
					salida=clkm3;
			end
			
		default: state_next= inicia;
	endcase
end
endmodule
