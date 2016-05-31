`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:52:46 05/25/2016 
// Design Name: 
// Module Name:    contador 
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
module contador(
    input clk, 
    input hush, 
   // input [3:0] note, 
    output ampPWM //speaker port 
 // output vcc, 
    ); 
	  reg [15:0] counter; //binary counter; 16 bits wide 
   // The audio amplifier needs to be enabled, by 
   // default it will be disabled without this:   
    localparam TCQ = 1; 

always @ (posedge clk or negedge hush) 
    if ( hush == 1'b0) 
        counter <= 1'b0; 
    else 
        counter <= counter + 1'b1; 

assign ampPWM = counter[15];     

endmodule















/*`timescale 1ns / 1ps 
module soundtest ( 
    input clk, 
    input hush, 
    input [3:0] note, 
    output ampPWM, 
    output vcc 
    ); 

   localparam TCQ = 1; 
   assign vcc = 1'b1; 

   reg [15:0] counter; 
   reg ampPWM; 

    always @(posedge clk) 
     begin 
        if(counter == 53628) //rounded half period clck cycle count for desired freq 
            begin 
            counter <= 0; 
            ampPWM <= ~ampPWM; 
            end 
        else 
        counter <= counter+1; 
     end 

    endmodule */
