`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:00:02 04/03/2021 
// Design Name: 
// Module Name:    sevenseg_decoder 
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
    output [6:0] out,
	 input EN,
    input [3:0] in
    );
	 wire [6:0] w1;
	 assign w1= (in==4'b0000 )?  7'b0111111:
	            ( in==4'b0001 )?  7'b0110000:
					( in==4'b0010 )?  7'b1011011:
					( in==4'b0011 )?  7'b1001111:
					( in==4'b0100 )?  7'b1100110:
					( in==4'b0101 )?  7'b1101101:
					( in==4'b0110 )?  7'b1111101: 
					( in==4'b0111 )?  7'b0000111:
					( in==4'b1000 )?  7'b1111111:
					( in==4'b1001 )?  7'b1101111:
					( in==4'b1010 )?  7'b1110111:
					( in==4'b1011 )?  7'b1111100:
					( in==4'b1100 )?  7'b0111001:
					( in==4'b1101 )?  7'b1011110:
					( in==4'b1110 )?  7'b1111001: 7'b1110001;
	 assign out=(EN)? w1 : 7'b0000000;


endmodule
