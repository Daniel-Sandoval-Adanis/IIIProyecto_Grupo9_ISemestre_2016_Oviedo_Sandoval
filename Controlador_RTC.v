`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:45:09 05/12/2016 
// Design Name: 
// Module Name:    Controlador_RTC 
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
module Controlador_RTC#(parameter N=8)(
input wire clk,reset,
input [N-1:0] port_out00,port_out01,
input [1:0] port_out02, // En el bit 0 el I, en el bit 1 el OP.
output [N-1:0] port_in00,
output AD,CS,WR,RD,
inout [N-1:0] salient
    );
wire enviardato,leerdato;
//FSM RTC, genera las señales de control del dispositivo
FSM_Write u1 (
    .clk(clk), 
    .reset(reset), 
    .I(port_out02[0]), 
    .OP(port_out02[1]), 
    .AD(AD), 
    .CS(CS), 
    .WR(WR), 
    .RD(RD), 
    .enviardato(enviardato), 
    .leerdato(leerdato)
    );

// Bus bidireccional para comuniar el RTC con el PicoBlaze
Bus_AD u2 (
    .clk(clk), 
    .leerdato(leerdato), 
    .enviardato(enviardato), 
    .AD(AD), 
    .direccion(port_out01), 
    .datoout(port_out00), 
    .datoin(port_in00), 
    .salient(salient)
    );

endmodule
