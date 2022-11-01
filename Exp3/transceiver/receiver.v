`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:38:07 05/03/2021 
// Design Name: 
// Module Name:    receiver 
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
module receiver(
    output reg data_valid=0,
	 output reg [3:0] cnt=0,
    output reg [7:0] data_out=0,
    input clk,
    input Rx
    );
    reg [7:0] register=0;
	 reg start_flag=0;
	 reg [10:0] cnt_start=0;
	 reg [11:0] cnt_sample=0;
	 
	 always @(posedge clk) begin
	      if ( Rx==0 ) cnt_start<=cnt_start+1;
	      if ( cnt_start==1250 ) begin
			    cnt_start<=0;
				 start_flag<=1;
			end
	      if ( start_flag==1 ) cnt_sample<=cnt_sample+1;
			if ( cnt_sample==2500 ) begin 
			     cnt_sample<=0;
	           cnt<=cnt+1;
	           if(cnt<8) register <= {Rx,register[7:1]};
	             if ( cnt==8 & Rx==1 ) begin
	                   data_out <= register;
	                   data_valid<=1;
							 start_flag<=0;
	             end
	       end
			 if (cnt==9)  begin
	             cnt<=cnt+1;
	             register<=0;
	             data_valid<=0;
	       end
	       if(cnt==10) cnt<=0;
	 
	 end


endmodule
