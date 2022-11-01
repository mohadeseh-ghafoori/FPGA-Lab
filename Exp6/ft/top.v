`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:30:57 07/10/2021 
// Design Name: 
// Module Name:    top 
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
module top(
    output reg wr=1,
    output reg rd=1,
    input rxf,
    input txe,
    inout [7:0] data,
    input clk
    );
    
	 reg [7:0] thresh=0;
	 reg flag=0,flag2=0;
	 reg [7:0] cnt=0;
	 assign data=(rxf==1)? cnt:8'bz;
	 always @(posedge clk) begin 
	      if(rxf==0) rd<=0;
	      if(rd==0) begin 
			    thresh<=data;
				 rd<=1;
				 flag2<=1;
			end
	      if(flag2==1) begin
 			   if(txe==0)
				begin
        			flag<=1;
					if(flag==0)
					begin
					if(cnt<=thresh) cnt<=cnt+1;
					if (cnt==thresh) begin
					   flag2<=0;
					   cnt<=1;
					end
					end
				end
			  if (flag==1)
			  begin
			     wr<=0;
				  flag<=0;
			  end
	     end
	 if(wr==0) wr<=1;

	 
	 end

endmodule
