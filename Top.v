`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:54:00 04/15/2019 
// Design Name: 
// Module Name:    Top 
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
module Top(clk_in, rst, clr, ent, change, led, AN, sw, seven_out);

input clk_in, rst, clr, ent, change;
input [3:0] sw; 

output reg [5:0] led;
output [3:0] AN;
output [6:0] seven_out;

wire clkOut1, clkOut2;
wire clear, enter, changeWire;

clkDivider1 clk1(clk_in, rst, clkOut1);
clkDivider2 clk2(clk_in, rst, clkOut2);

debouncer clearr(clkOut2, rst, clr, clear);
debouncer enterr(clkOut2, rst, ent, enter);
debouncer changee(clkOut2, rst, change, changeWire);


//implementing ASM
ASM asm(.ssd_clk(clkOut1), .clk(clkOut2), .rst(rst), .clr(clear), .ent(enter), .change(changeWire), led, ssd, sw, AN, seven_out);

endmodule
