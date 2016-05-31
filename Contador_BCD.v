`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    08:19:04 03/26/2016 
// Design Name: 
// Module Name:    Contador_BCD 
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
module Contador_BCD(
	input wire clk, reset, EN, up, down,load,
	input wire [2:0] Cod,
	input wire [7:0] dato,
	output reg [3:0] BCD1, BCD0
    );

//Divisor para cumplir con tiempos del PicoBlaze.
reg clkm;
always @(clk)begin
clkm=~clkm;
end

reg [3:0] BCD1max, BCD0max;

always @* begin
	case(Cod)
		3'b000: begin
					BCD1max = 4'd0; // Formato
					BCD0max = 4'd1;
				end
		3'b001: begin
					BCD1max = 4'd1; // 12 horas
					BCD0max = 4'd2;
				end
		3'b010: begin
					BCD1max = 4'd2; // 24 horas
					BCD0max = 4'd3;
				end

		3'b011: begin
					BCD1max = 4'd5; // minutos/ segundos
					BCD0max = 4'd9;
				end
		3'b100: begin
					BCD1max = 4'd3; // dia
					BCD0max = 4'd1;
				end

		3'b101: begin
					BCD1max = 4'd1; //mes
					BCD0max = 4'd2;
				end
		3'b110: begin
					BCD1max = 4'd9; //año
					BCD0max = 4'd9;
				end
		3'b111: begin
					BCD1max = 4'd5; //otros segundos
					BCD0max = 4'd9;
				end				

		default:begin
					BCD1max = 4'd7; 
					BCD0max = 4'd7;
				end
	endcase
end




always @(posedge clkm)
begin
if (reset)
    begin
        BCD1 <= 0;
        BCD0 <= 0;
    end

else if(load)
		begin
			BCD1 <= dato[7:4]; // LOAD
			BCD0 <= dato[3:0];
		end 

else if (EN) begin
    if (up) begin
        if (BCD0 >= BCD0max && BCD1 >= BCD1max) begin
					BCD0 <= 0;
					BCD1 <= 0;
		  end
		  else if (BCD0 == 4'd9)
            begin
                BCD0 <= 0;
            if (BCD1 == 4'd9)
                BCD1 <= 0;
            else
                BCD1 <= BCD1 + 4'd1;
            end
        else
            BCD0 <= BCD0 + 4'd1;
    end
    else if (down) begin
	 
        if (BCD0 == 4'd0 && BCD1 == 4'd0) begin
					BCD0 <= BCD0max;
					BCD1 <= BCD1max;
		  end
		  else if (BCD0 == 4'd0)
            begin
                BCD0 <= 4'd9;
            if (BCD1 == 4'd0)
                BCD1 <= 4'd9;
            else
                BCD1 <= BCD1 - 4'd1;
            end
        else
            BCD0 <= BCD0 - 4'd1;
    end
	end
end
endmodule
