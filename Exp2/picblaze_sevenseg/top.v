`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:36:39 04/09/2021 
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
    output  reg [7:0] out=0,
    output reg [3:0] en=1,
    input [3:0] a,
    input [3:0] b,
    input rst,
    input clk
    );
	 
	 
	 wire [11:0] address;
	 wire [17:0] instruction;
	 reg [7:0] in_port;
	 wire [7:0] out_port;
	 wire enable;
	 wire rdl;
	 wire [7:0] port_id;
	 reg en_sum=1;
	 reg en_sub=1;
	 reg [3:0] add=0;
	 reg [3:0] sub=0;
	 reg [10:0] counter=0;
	 reg clk1=0;
	 reg [31:0] cnt=0;
	 reg sleep=0;
	 wire [7:0] out_sum;
	 wire [7:0] out_sub;
	 wire reset;
	 or o1(reset,rdl,~rst);
	 
	 kcpsm6 pico (
    .address(address), 
    .instruction(instruction), 
    .bram_enable(enable), 
    .in_port(in_port), 
    .out_port(out_port), 
    .port_id(port_id), 
    .write_strobe(write_strobe), 
    .k_write_strobe(k_write_strobe), 
    .read_strobe(read_strobe), 
    .interrupt(interrupt), 
    .interrupt_ack(interrupt_ack), 
    .sleep(sleep), 
    .reset(reset), 
    .clk(clk1)
    );
	 
	 ADDORSUB adder (
    .address(address), 
    .instruction(instruction), 
    .enable(enable), 
    .rdl(rdl), 
    .clk(clk1)
    );
	 
	 always @(posedge clk) begin
	    if ( rst==1 ) begin
	        cnt<=cnt+1;
			  if ( cnt==12000000 ) begin 
			       clk1<=~clk1;
					 cnt<=0;
				end
			end
			else begin 
			    cnt<=0;
				 clk1<=0;
			end
	 end
	 
	 always @(posedge clk1) begin 
	        if ( port_id == 8'h81 ) in_port<={4'b0000,a};
			  else if ( port_id == 8'h82 ) in_port<={4'b0000,b};
			  else if ( port_id == 8'h83 ) add<=out_port;
			  else if ( port_id == 8'h84 ) sub<=out_port;
			  
	 end
	 always @(posedge clk) begin 
	         counter<=counter+1;
	     	  if( counter==0 ) begin
                out<=out_sum;
					 en<=4'b1110;
			  end 
			  else if ( counter==1024 ) begin			  
                out<=out_sub;
					 en<=4'b1101;
			  end
	 
	 
	 end
	 sevenseg_decoder sevenseg_add(out_sum,1'b0,add);
	 sevenseg_decoder sevenseg_sub(out_sub,1'b0,sub);

endmodule
