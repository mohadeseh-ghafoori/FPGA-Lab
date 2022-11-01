`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:38:50 05/04/2021 
// Design Name: 
// Module Name:    transmitter 
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
module transmitter(
    output Tx,
	 output reg [3:0] cnt=0,
    input [7:0] data,
    input start,
    input clk
    );
 
    reg [9:0] shift_register=10'b1111_1111_11;
    reg start_flag=0;
	 reg [11:0] cnt_transmit=0;

    always @(posedge clk) begin 
	      if (start==1 && start_flag==0) begin  //DC_BOUNCING
			    start_flag<=1;
				 shift_register<={1'b1,data,1'b0};
			end
	      if (start_flag) cnt_transmit<=cnt_transmit+1;
			if ( cnt_transmit== 2500 ) begin 
			    cnt_transmit<=0;
				 cnt<=cnt+1;
				 if( cnt<11 ) shift_register<={1'b1,shift_register[9:1]};
			end
	      if(cnt==11) begin 
			   start_flag<=0;
			   cnt<=0;
			   shift_register<=10'b1111_1111_11;
			end
	 end
    assign Tx=shift_register[0];

endmodule
