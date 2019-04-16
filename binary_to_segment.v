`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:26:31 04/15/2019 
// Design Name: 
// Module Name:    binary_to_segment 
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
module binary_to_segment(bin_in, seven_out);
input [4:0] bin_in;
output reg [6:0] seven_out;

always @(bin_in)
begin
	case(bin_in)
		5'b00000: seven_out= 7'b0000001; //0
		5'b00001: seven_out= 7'b1001111; //1
		5'b00010: seven_out= 7'b0010010; //2
		5'b00011: seven_out= 7'b0000110; //3
		5'b00100: seven_out= 7'b1001100; //4
		5'b00101: seven_out= 7'b0100000; //5
		5'b00110: seven_out= 7'b0001111; //6
		5'b00111: seven_out= 7'b0000000; //7
		5'b01000: seven_out= 7'b0000100; //8
		5'b01001: seven_out= 7'b0001000; //9
		
		5'b01111: seven_out = 7'b0110001; //C
		5'b01101: seven_out = 7'b1110001; //L
		5'b10100: seven_out = 7'b1000010; //d

		5'b00000: seven_out = 7'b0000001; //O
		5'b10010: seven_out = 7'b0011000; //P
		5'b01110: seven_out = 7'b0110000; //E
		5'b01100: seven_out = 7'b1101010; //n

		5'b10001: seven_out = 7'b1111110; //tire aka dash
		//5'b01010;

		default: seven_out = 7'h1;
		
	endcase
end

endmodule