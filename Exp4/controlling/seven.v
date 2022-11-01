`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:44:52 05/18/2021 
// Design Name: 
// Module Name:    seven 
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
module sevenseg_decoder(
    output [7:0] out,
	 input EN,
    input [3:0] in
    );
	 wire [7:0] w1;
	 assign w1= (in==4'b0000 )?  8'b00111111:
	            ( in==4'b0001 )?  8'b00110000:
					( in==4'b0010 )?  8'b01011011:
					( in==4'b0011 )?  8'b01001111:
					( in==4'b0100 )?  8'b01100110:
					( in==4'b0101 )?  8'b01101101:
					( in==4'b0110 )?  8'b01111101: 
					( in==4'b0111 )?  8'b00000111:
					( in==4'b1000 )?  8'b01111111:
					( in==4'b1001 )?  8'b01101111:
					( in==4'b1010 )?  8'b01110111:
					( in==4'b1011 )?  8'b01111100:
					( in==4'b1100 )?  8'b0111001:
					( in==4'b1101 )?  8'b01011110:
					( in==4'b1110 )?  8'b01111001: 8'b01110001;
	 assign out=(EN==0)? ~w1 : 8'b00000000;


endmodule
