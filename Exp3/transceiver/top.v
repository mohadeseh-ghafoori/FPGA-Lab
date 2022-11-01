`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:16:52 05/04/2021 
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
    output reg out=0,
    input [3:0] input_addr,
    input start,
    input clk
    );
	 
	 wire Tx,data_valid;
	 wire [3:0] cnt_trans;
	 wire [3:0] cnt_rec;
	 wire [7:0] doutm1,doutm2,data_out;
	 reg [3:0] addrm1=0,addrm2=0;
	 reg wem2=1;
	 reg start_trans=0;
	 reg flag=0;
	 
	 trans_mem m1 (
  .clka(clk), // input clka
  .addra(addrm1), // input [2 : 0] addra
  .douta(doutm1) // output [7 : 0] douta
   );
	 
	receive_mem m2 (
  .clka(clk), // input clka
  .wea(wem2), // input [0 : 0] wea
  .addra(addrm2-1), // input [2 : 0] addra
  .dina(data_out), // input [7 : 0] dina
  .douta(doutm2) // output [7 : 0] douta
   ); 
	 
	transmitter t1(Tx,cnt_trans,doutm1,start_trans,clk);
   receiver r1(data_valid,cnt_rec,data_out,clk,Tx);	
	 always @(posedge clk) begin 
	     if (~start) begin 
		     start_trans<=1;
           addrm1<=0;
			  addrm2<=0;
			  wem2<=1;
        end	
        else if ( ~start==0 & cnt_trans!=11 ) start_trans<=0;		  
		  
		  if(addrm2<=8 && wem2==1)
		  begin
			  if(cnt_trans==11 && addrm1<8) begin 
					addrm1<=addrm1+1;
					start_trans<=1;
			  end 
			  if(cnt_rec==10) 
			  begin
			     addrm2<=addrm2+1;
			     if(addrm2==8)
				     wem2<=0;
			  end
		  end
		  if(wem2==0)
		  begin
				addrm1<=input_addr;
				addrm2<=input_addr+1; 
				 if ( doutm1==doutm2) out<=1;
				 else out<=0;
         end
	 
	 end


endmodule
