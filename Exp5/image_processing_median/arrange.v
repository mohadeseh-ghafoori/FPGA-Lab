`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:47:05 06/05/2021 
// Design Name: 
// Module Name:    arrange 
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
module arrange(
    output reg [7:0] max=0,
    output reg [7:0] med=0,
    output reg [7:0] min=0,
    input [7:0] a,
    input [7:0] b,
    input [7:0] c,
    input clk
    );
	 
	 
	 always @(posedge clk) begin
	       if ( a<=b && b<=c ) begin // like 123 
			     min<=a;
				  med<=b;
			     max<=c;
			 end
	       if ( a>=b && b<=c && a<=c ) begin // like 213 
			     min<=b;
			     med<=a;
			     max<=c;
			 end
	       if ( a<=b && b>=c && a>=c ) begin  // like 231
			    min<=c;
				 med<=a;
			    max<=b;
			 end
	       if ( a>=b && b>=c ) begin  // like 321
			     min<=c;
				  med<=b;
				  max<=a;
			 end
	       if ( a>=b && b<=c && a>=c ) begin  // like 312
              min<=b;
              med<=c;
              max<=a;
			 end
	       if ( a<=b && b>=c && a<=c ) begin // like 132
			     min<=a;
			     med<=c;
			     max<=b;
			 end
	 end
	 


endmodule
