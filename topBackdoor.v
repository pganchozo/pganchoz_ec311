`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:13:20 04/19/2019 
// Design Name: 
// Module Name:    topBackdoor 
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

module topBackdoor(clk_in, rst, clr, ent, change, led, AN, sw, seven_out);

input clk_in, rst, clr, ent, change;
input [7:0] sw; 

output [5:0] led;
output [3:0] AN;
output [6:0] seven_out;

wire clkOut1, clkOut2, clkOut3;
wire clear, enter, changeWire;
wire [19:0]ssd;

clkDivider1 clk1(clk_in, rst, clkOut1); //ssd
clkDivider2 clk2(clk_in, rst, clkOut2);
clkDivider3 clk3(clk_in, rst, clkOut3); //backdoor

debouncer clear1(clkOut2, rst, clr, clear);
debouncer enter1(clkOut2, rst, ent, enter);
debouncer change1(clkOut2, rst, change, changeWire);

//implementing ASM
ASMBD asmbd(clkOut1, clkOut2, clkOut3, rst, clear, enter, changeWire, led, sw, AN, seven_out);




endmodule
