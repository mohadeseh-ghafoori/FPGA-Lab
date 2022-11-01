`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:44:14 05/10/2021 
// Design Name: 
// Module Name:    road 
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
module road(
    output [7:0] timer,
	 output reg en=0,
    output green_main,
    output yellow_main,
    output red_main,
    output green_secondary,
    output yellow_secondary,
    output red_secondary,
    input sensor,
    input clk
    );


    parameter highway_green=2'b00,highway_yellow=2'b01,secondary_green=2'b10,secondary_yellow=2'b11;
	 reg [1:0] present_state=0,next_state=0;
    reg [28:0] cnt=0;
	 reg [3:0] in_7seg=0;
	 wire [7:0] out_7seg;
	 always @(posedge clk) present_state <= next_state;
    always @(*) begin 
	   case ( present_state ) 
	        highway_green :begin 
			                  if ( sensor==0 ) next_state=highway_green;
			                  if ( sensor==1 && cnt>0  ) next_state=highway_green;
									if ( sensor==1 && cnt==0 ) next_state=highway_yellow;
			                 end
	        highway_yellow:begin
			                  if ( sensor==1 && cnt > 0 ) next_state=highway_yellow; 
			                  if( sensor==1 && cnt==0 ) next_state=secondary_green;
	                       end
	        secondary_green:begin 
			                  if ( sensor==0 ) next_state=secondary_yellow;
			                  if ( sensor==1 && cnt > 0 ) next_state=secondary_green;
			                  if ( sensor==1 && cnt==0 ) next_state=secondary_yellow;
			                  end
			  secondary_yellow:begin 
			                     if ( cnt >0 ) next_state=secondary_yellow;
	                           if ( cnt==0 ) next_state=highway_green;
	                         end
	   endcase
	 
	 end

    always @(posedge clk) begin 
           if ( sensor==0 && present_state==highway_green) cnt<=360000000;
           if ( sensor==1 && present_state==highway_green ) cnt<=cnt-1;
           if ( cnt==0 && next_state==highway_yellow ) cnt<=48000000;
           if ( sensor==1 && present_state==highway_yellow ) cnt<=cnt-1;
           if ( cnt==0 && next_state==secondary_green ) cnt<=120000000;
			  if ( sensor==1 && present_state==secondary_green ) cnt<=cnt-1;
           if ( next_state==secondary_yellow ) cnt<=48000000;
			  if ( present_state==secondary_yellow ) cnt<=cnt-1;
           if ( cnt==0 && next_state==highway_green ) cnt<=360000000;
    end	
    always @(posedge clk) begin 
           if ( cnt<24000000 ) in_7seg<=0;
           if ( cnt>=24000000 && cnt<48000000 ) in_7seg<=1;
           if ( cnt>=48000000 && cnt<72000000 ) in_7seg<=2;
			  if ( cnt>=72000000 && cnt<96000000 ) in_7seg<=3;
           if ( cnt>=96000000 && cnt<120000000 ) in_7seg<=4;
           if ( cnt>=120000000 && cnt<144000000 ) in_7seg<=5;
			  if ( cnt>=144000000 && cnt<168000000 ) in_7seg<=6;				 			
           if ( cnt>=168000000 && cnt<192000000 ) in_7seg<=7;
           if ( cnt>=192000000 && cnt<216000000 ) in_7seg<=8;
			  if ( cnt>=216000000 && cnt<240000000 ) in_7seg<=9;
           if ( cnt>=240000000 && cnt<264000000 ) in_7seg<=10;
           if ( cnt>=264000000 && cnt<288000000 ) in_7seg<=11;
			  if ( cnt>=288000000 && cnt<312000000 ) in_7seg<=12;
           if ( cnt>=312000000 && cnt<336000000 ) in_7seg<=13;
           if ( cnt>=336000000 && cnt<360000000 ) in_7seg<=14;
			  if ( cnt==360000000 ) in_7seg<=15;
	 
	 end
    sevenseg_decoder s1(out_7seg,1'b0,in_7seg) ;
    assign green_main= ( present_state==highway_green )  ?  1 : 0;
    assign yellow_main= ( present_state==highway_yellow ) ? 1: 0;
	 assign red_main= ( present_state==secondary_green || present_state==secondary_yellow ) ? 1: 0;
	 assign green_secondary= ( present_state==secondary_green ) ? 1: 0;
    assign yellow_secondary= ( present_state==secondary_yellow ) ? 1: 0;
	 assign red_secondary= ( present_state==highway_green || present_state==highway_yellow ) ? 1: 0;
    assign timer=out_7seg; 

endmodule
