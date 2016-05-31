`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:17:53 05/23/2016 
// Design Name: 
// Module Name:    imagenes 
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
module imagenes(
	output wire [7:0] rgb,
	input wire [3:0] dig0, dig1,dig2, dig3,dig4, dig5,dig6, dig7,dig8, dig9,dig10, dig11,dig12, dig13,dig14, dig15,dig16, dig17,
	input wire clk, reset_i,
	input wire [7:0] dato0,// formato  24/12
	input wire [7:0] dato2,//  am/pm
	input wire  crontermino,
	output wire hsync_o, vsync_o
	);
	wire [9:0] pixel_x_o, pixel_y_o;
	reg clk1 = 0;		//need a downcounter to 25MHz
	//parameter Mickey = 13'd6960;	//overall there are 6960 pixels
	parameter Gimpy = 13'd6400;	//overall there are 6400 pixels
	parameter GimpyXY = 7'd80;	//Gimp has 80x80 pixels

always @(posedge clk)begin     
	
	clk1 <= ~clk1;	//Slow down the counter to 25MHz
end	
 vgasync vga (	
 .clk_i(clk1), .reset_i(reset_i),.hsync_o(hsync_o), .vsync_o(vsync_o),.pixel_x_o(pixel_x_o), .pixel_y_o(pixel_y_o));


	//VGA Interface gets values of ADDRH & ADDRV and by puting COLOUR_IN, gets valid output COLOUR_OUT
	//Also gets a trigger, when the screen is refreshed
	wire [12:0] STATE;
	wire [12:0] STATE1;
	wire [12:0] STATE2;
	wire [12:0] STATE3;
	wire [12:0] STATE4;
	wire [12:0] STATE5;
	wire [12:0] STATE6;
	wire [12:0] STATE7;
	wire [12:0] STATE8;
	wire [12:0] STATE9;
	wire [12:0] STATE10;
	wire [12:0] STATE11;
	wire [12:0] STATE12;
	wire [12:0] STATE13;
	wire [12:0] STATE14;	
	wire [12:0] STATE15;
	wire [12:0] STATE16;
	wire [12:0] STATE17;
	reg [7:0] COLOUR_DATA [0:Gimpy-1];
	reg [7:0] COLOUR_DATA1 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA2 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA3 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA4 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA5 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA6 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA7 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA8 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA9 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA10 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA11 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA12 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA13 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA14 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA15 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA16 [0:Gimpy-1];
	reg [7:0] COLOUR_DATA17 [0:Gimpy-1];
	reg [7:0] rg;/// registro máscara de la salida de rgb
	
	//==================================================================
	parameter[10:0]X = 11'd0;//maximo en x
	parameter [9:0]Y = 10'd0;//maximo en y

	parameter[10:0]X1 = 11'd80;//maximo en x dia
	parameter[9:0]Y1 = 10'd0;//maximo en y
	//
	parameter [10:0]X2 = 11'd160;//maximo en x mes
	parameter [9:0]Y2 = 10'd0;//maximo en y
	//
	parameter [10:0]X3 = 11'd240;//maximo en x  año
	parameter [9:0]Y3 = 10'd0;//maximo en y
	//
	parameter [10:0]X4 = 11'd0;//maximo en x relojbon
	parameter [9:0]Y4 = 10'd160;//maximo en y
   //	
	parameter [10:0]X5 = 11'd80;//maximo en x hora
	parameter [9:0]Y5 = 10'd160;//maximo en y
	//
	parameter[10:0]X6 = 11'd160;//maximo en x minutos
	parameter [9:0]Y6 = 10'd160;//maximo en y
	//
	parameter [10:0]X7 = 11'd240;//maximo en x segundos
	parameter [9:0]Y7 = 10'd160;//maximo en y
//
	parameter[10:0]X8 = 11'd0;//maximo en x cronometro
	parameter [9:0]Y8 = 10'd320;//maximo en y
	
	parameter [10:0]X9 = 11'd80;//maximo en x horas
	parameter [9:0]Y9 = 10'd320;//maximo en y
//
	parameter [10:0]X10 = 11'd160;//maximo en x minutos
	parameter [9:0]Y10 = 10'd320;//maximo en y
	
	parameter [10:0]X11 = 11'd240;//maximo en x segundos
	parameter [9:0]Y11 = 10'd320;//maximo en y
	
	//
	parameter [10:0]X12 = 11'd320;//maximo en x AM
	parameter [9:0]Y12 = 10'd160;//maximo en y
		//
	parameter [10:0]X13 = 11'd400;//maximo en x PM
	parameter [9:0]Y13 = 10'd160;//maximo en y
		//
	parameter [10:0]X14 = 11'd400;//maximo en x ring
	parameter [9:0]Y14 = 10'd320;//maximo en y
	//////
	parameter [10:0]X15 = 11'd560;//maximo en x AM
	parameter [9:0]Y15 = 10'd0;//maximo en y
		//
	parameter [10:0]X16 = 11'd560;//maximo en x PM
	parameter [9:0]Y16 = 10'd80;//maximo en y
		//
	parameter [10:0]X17 = 11'd560;//maximo en x ring
	parameter [9:0]Y17 = 10'd160;//maximo en y
	

	initial
	begin
	$readmemh ("fecha.list", COLOUR_DATA);//Lee la imagen en hexadecimal
	

	//initial
	$readmemh ("dia.list", COLOUR_DATA1);//Lee la imagen en hexadecimal
	//
	//initial
	$readmemh ("mes.list", COLOUR_DATA2);//Lee la imagen en hexadecimal
	//
	//initial
	$readmemh ("ano.list", COLOUR_DATA3);//Lee la imagen en hexadecimal
	
	//initial
	$readmemh ("re.list", COLOUR_DATA4);//Lee la imagen en hexadecimal
	//
	//initial
	$readmemh ("horabon.list", COLOUR_DATA5);//Lee la imagen en hexadecimal
	//
	//initial
	$readmemh ("min.list", COLOUR_DATA6);//Lee la imagen en hexadecimal
	//initial
	$readmemh ("segundos.list", COLOUR_DATA7);//Lee la imagen en hexadecimal
	//
	//initial
	$readmemh ("cr.list", COLOUR_DATA8);//Lee la imagen en hexadecimal
	///
	//initial
	$readmemh ("AM.list", COLOUR_DATA12);//Lee la imagen en hexadecimal
	//
	//initial
	$readmemh ("PM.list", COLOUR_DATA13);//Lee la imagen en hexadecimal
	//
	//initial
	$readmemh ("ring.list", COLOUR_DATA14);//Lee la imagen en hexadecimal
	
	
	$readmemh ("instrucciones0.list", COLOUR_DATA15);//Lee la imagen en hexadecimal
	$readmemh ("instrucciones01.list", COLOUR_DATA16);//Lee la imagen en hexadecimal
	$readmemh ("instrucciones02.list", COLOUR_DATA17);//Lee la imagen en hexadecimal
	end
	
	
	
	assign STATE = (pixel_x_o-X)*GimpyXY+pixel_y_o-Y;
	assign STATE1 = (pixel_x_o-X1)*GimpyXY+pixel_y_o-Y1;
	assign STATE2 = (pixel_x_o-X2)*GimpyXY+pixel_y_o-Y2;
	assign STATE3 = (pixel_x_o-X3)*GimpyXY+pixel_y_o-Y3;
	assign STATE4 = (pixel_x_o-X4)*GimpyXY+pixel_y_o-Y4;
	assign STATE5 = (pixel_x_o-X5)*GimpyXY+pixel_y_o-Y5;	
	assign STATE6 = (pixel_x_o-X6)*GimpyXY+pixel_y_o-Y6;
	assign STATE7	= (pixel_x_o-X7)*GimpyXY+pixel_y_o-Y7;
	assign STATE8 = (pixel_x_o-X8)*GimpyXY+pixel_y_o-Y8;	
	assign STATE9 = (pixel_x_o-X9)*GimpyXY+pixel_y_o-Y9;
	assign STATE10	= (pixel_x_o-X10)*GimpyXY+pixel_y_o-Y10;
	assign STATE11 = (pixel_x_o-X11)*GimpyXY+pixel_y_o-Y11;
	assign STATE12 = (pixel_x_o-X12)*GimpyXY+pixel_y_o-Y12;
	assign STATE13	= (pixel_x_o-X13)*GimpyXY+pixel_y_o-Y13;
	assign STATE14 = (pixel_x_o-X14)*GimpyXY+pixel_y_o-Y14;
	assign STATE15 = (pixel_x_o-X15)*GimpyXY+pixel_y_o-Y15;
	assign STATE16	= (pixel_x_o-X16)*GimpyXY+pixel_y_o-Y16;
	assign STATE17 = (pixel_x_o-X17)*GimpyXY+pixel_y_o-Y17;
	//=======================================================================================================================
	//=================letras======================================================================================================
	



	 // signal declaration
   wire [10:0] rom_addr;
   reg [6:0] char_addr, char_addr_r, char_addr_s, char_addr_g;//
   reg [3:0] row_addr;
   wire [3:0] row_addr_r, row_addr_s, row_addr_g;//
   reg [2:0] bit_addr;
   wire [2:0] bit_addr_r, bit_addr_s, bit_addr_g;//,
   wire [7:0] font_word;
   wire font_bit, rule_on, score_on, cron_on;//
   wire [7:0] rule_rom_addr, cron_rom_addr;
		 // instantiate font ROM
 fontroom instance_name (
    .clk_i(clk1), .addr(rom_addr), .data(font_word));

  

   //-------------------------------------------
   // score region
   //  - display two-digit score, ball on top left
   //  - scale to 16-by-32 font                      _o
   //  - line 1, 16 chars: "Score:DD Ball:D"
   //-------------------------------------------
   assign score_on = ((pixel_y_o[9:4])<10  && (7<(pixel_y_o[9:4])) && (10<(pixel_x_o[9:3]))&&  (pixel_x_o[9:6])<5  );
   assign row_addr_s = pixel_y_o[4:1];
   assign bit_addr_s = pixel_x_o[3:1];
   always @*
      case (pixel_x_o[7:4])
         4'h0: char_addr_s = {3'b011, dig4};// año  {3'b011, dig4};
         4'h1: char_addr_s = {3'b011, dig5};// año  {3'b011, dig5};
         4'h2: char_addr_s = 7'h00;// 
         4'h3: char_addr_s = 7'h00;// 
         4'h4: char_addr_s = 7'h00;// 
         4'h5: char_addr_s = 7'h00;
         4'h6: char_addr_s = {3'b011, dig0}; // digit 10 {3'b011, dig0};
         4'h7: char_addr_s = {3'b011, dig1}; // digit 10 {3'b011, dig1};
         4'h8: char_addr_s = 7'h00;
         4'h9: char_addr_s = 7'h00; 
         4'ha: char_addr_s = 7'h00; 
         4'hb: char_addr_s = 7'h00;
         4'hc: char_addr_s = {3'b011, dig2};// digit 10{3'b011, dig2};
         4'hd: char_addr_s = {3'b011, dig3};// digit 10 {3'b011, dig3};
	   	4'he: char_addr_s = 7'h00;
		   4'hf: char_addr_s = 7'h00;
			 
          
      endcase
//=====================================================
   assign rule_on = ((pixel_y_o[9:6])<5  && (17<(pixel_y_o[9:4])) && (10<(pixel_x_o[9:3]))&&  (pixel_x_o[9:6])<5 );
   assign row_addr_r = pixel_y_o[4:1];
   assign bit_addr_r = pixel_x_o[3:1];
	
   always @*
      case (pixel_x_o[7:4])
         4'h0: char_addr_r = {3'b011, dig10};///   {3'b011, dig10};  segundos
         4'h1: char_addr_r = {3'b011, dig11};////  {3'b011, dig11};  segundos
         4'h2: char_addr_r = 7'h00;// 
         4'h3: char_addr_r = 7'h00;// 
         4'h4: char_addr_r = 7'h00;// 
         4'h5: char_addr_r = 7'h00;
         4'h6: char_addr_r = {3'b011, dig6}; // digit 10  {3'b011, dig6}; horas
         4'h7: char_addr_r = {3'b011, dig7};// digit 10   {3'b011, dig7};  horas
         4'h8: char_addr_r = 7'h00;
         4'h9: char_addr_r = 7'h00; 
         4'ha: char_addr_r = 7'h00; 
         4'hb: char_addr_r = 7'h00;
         4'hc: char_addr_r = {3'b011, dig8};// digit 10    {3'b011, dig8};   minutos
         4'hd: char_addr_r = {3'b011, dig9};// digit 10    {3'b011, dig9}; minutos
	   	4'he: char_addr_r = 7'h00;
		   4'hf: char_addr_r = 7'h00; // 
			 
 endcase
//=======================================================================================================

   assign cron_on = ((pixel_y_o[9:5])<15  && (27<(pixel_y_o[9:4])) && (10<(pixel_x_o[9:3]))&&  (pixel_x_o[9:6])<5 );
   assign row_addr_g = pixel_y_o[4:1];
   assign bit_addr_g = pixel_x_o[3:1];
	
   always @*
      case (pixel_x_o[7:4])
         4'h0: char_addr_g = {3'b011, dig16};//////////   {3'b011, dig16};
         4'h1: char_addr_g = {3'b011, dig17};////////////  {3'b011, dig17};
         4'h2: char_addr_g = 7'h00;// 
         4'h3: char_addr_g = 7'h00;// 
         4'h4: char_addr_g = 7'h00;// 
         4'h5: char_addr_g = 7'h00;
         4'h6: char_addr_g = {3'b011, dig12}; // digit 10  {3'b011, dig12};
         4'h7: char_addr_g = {3'b011, dig13};// digit 10   {3'b011, dig13};
         4'h8: char_addr_g = 7'h00;
         4'h9: char_addr_g = 7'h00; 
         4'ha: char_addr_g = 7'h00; 
         4'hb: char_addr_g = 7'h00;
         4'hc: char_addr_g = {3'b011, dig14};// aqui iban   {3'b011, di14};
         4'hd: char_addr_g = {3'b011, dig15};//             {3'b011, dig15};
	   	4'he: char_addr_g = 7'h00;
		   4'hf: char_addr_g = 7'h00; // 
			 
 endcase
   //-------------------------------------------
	

	
	
	//=======================================================================================================================
	//=======================================================================================================================
	always@* begin// Indica la posición en donde se ubicara la imagen si esta se encuentra dentro del margen definido 
		
		char_addr=7'b0000000;
		row_addr=4'b0000;
		bit_addr=3'b000;
      rg = 8'b00000000; 
		
		if (pixel_x_o>=X && pixel_x_o<X+GimpyXY
			&& pixel_y_o>=Y && pixel_y_o<Y+GimpyXY)
				rg = COLOUR_DATA[{STATE}];
		else if (pixel_x_o>=X1 && pixel_x_o<X1+GimpyXY && pixel_y_o>=Y1 && pixel_y_o<Y1+GimpyXY)
				rg = COLOUR_DATA1[{STATE1}];
				//
		else if (pixel_x_o>=X2 && pixel_x_o<X2+GimpyXY && pixel_y_o>=Y2 && pixel_y_o<Y2+GimpyXY)
				rg = COLOUR_DATA2[{STATE2}];
				//
		else if (pixel_x_o>=X3 && pixel_x_o<X3+GimpyXY && pixel_y_o>=Y3 && pixel_y_o<Y3+GimpyXY)
				rg = COLOUR_DATA3[{STATE3}];
				//
		else if (pixel_x_o>=X4 && pixel_x_o<X4+GimpyXY && pixel_y_o>=Y4 && pixel_y_o<Y4+GimpyXY)
				rg = COLOUR_DATA4[{STATE4}];
				//
		else if (pixel_x_o>=X5 && pixel_x_o<X5+GimpyXY && pixel_y_o>=Y5 && pixel_y_o<Y5+GimpyXY)
				rg = COLOUR_DATA5[{STATE5}];
				//
		else if (pixel_x_o>=X6 && pixel_x_o<X6+GimpyXY && pixel_y_o>=Y6 && pixel_y_o<Y6+GimpyXY)
				rg = COLOUR_DATA6[{STATE6}];
				//
		else if (pixel_x_o>=X7 && pixel_x_o<X7+GimpyXY && pixel_y_o>=Y7 && pixel_y_o<Y7+GimpyXY)
				rg = COLOUR_DATA7[{STATE7}];
				//
		else if (pixel_x_o>=X8 && pixel_x_o<X8+GimpyXY && pixel_y_o>=Y8 && pixel_y_o<Y8+GimpyXY)
				rg = COLOUR_DATA8[{STATE8}];
				//
		else if (pixel_x_o>=X9 && pixel_x_o<X9+GimpyXY && pixel_y_o>=Y9 && pixel_y_o<Y9+GimpyXY)
				rg = COLOUR_DATA5[{STATE9}];
				//
		else if (pixel_x_o>=X10 && pixel_x_o<X10+GimpyXY && pixel_y_o>=Y10 && pixel_y_o<Y10+GimpyXY)
				rg = COLOUR_DATA6[{STATE10}];
				//
		else if (pixel_x_o>=X11 && pixel_x_o<X11+GimpyXY && pixel_y_o>=Y11 && pixel_y_o<Y11+GimpyXY)
				rg = COLOUR_DATA7[{STATE11}];
				//
		else if (pixel_x_o>=X12 && pixel_x_o<X12+GimpyXY && pixel_y_o>=Y12 && pixel_y_o<Y12+GimpyXY && dato2 && dato0)// &&señal de AM/PM
				rg = COLOUR_DATA12[{STATE12}];
				//
		else if (pixel_x_o>=X13 && pixel_x_o<X13+GimpyXY && pixel_y_o>=Y13 && pixel_y_o<Y13+GimpyXY && ~dato2 && dato0)//&& ~señal de AM/PM
				rg = COLOUR_DATA13[{STATE13}];
				//
		else if (pixel_x_o>=X14 && pixel_x_o<X14+GimpyXY && pixel_y_o>=Y14 && pixel_y_o<Y14+GimpyXY && crontermino)// && crontermino
				rg = COLOUR_DATA14[{STATE14}];
				
		else if (pixel_x_o>=X15 && pixel_x_o<X15+GimpyXY && pixel_y_o>=Y15 && pixel_y_o<Y15+GimpyXY)// 
				rg = COLOUR_DATA15[{STATE15}];
				
				//====================================
		else if (pixel_x_o>=X16 && pixel_x_o<X16+GimpyXY && pixel_y_o>=Y16 && pixel_y_o<Y16+GimpyXY)// 
				rg = COLOUR_DATA16[{STATE16}];
				///=======================================
		else if (pixel_x_o>=X17 && pixel_x_o<X17+GimpyXY && pixel_y_o>=Y17 && pixel_y_o<Y17+GimpyXY)// 
				rg = COLOUR_DATA17[{STATE17}];
				///////=============mux combinacional==============================
		  else if (score_on)
         begin
            char_addr = char_addr_s;
            row_addr = row_addr_s;
            bit_addr = bit_addr_s;
            if (font_bit)
               rg = 8'b00000111;
         end

      else if (rule_on)
         begin
            char_addr = char_addr_r;
            row_addr = row_addr_r;
            bit_addr = bit_addr_r;
            if (font_bit)
               rg = 8'b00000111;
         end
		else if (cron_on)
         begin
            char_addr = char_addr_g;
            row_addr = row_addr_g;
            bit_addr = bit_addr_g;
            if (font_bit)
               rg = 8'b00000111;
         end
		else
			begin
			rg = 8'b00000000;
			end		
	end
assign rgb=rg; // Se asigna el valor de la salida del sistema
	assign rom_addr = {char_addr, row_addr};
   assign font_bit = font_word[~bit_addr];
endmodule

