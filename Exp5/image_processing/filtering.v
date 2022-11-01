`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:20:11 05/26/2021 
// Design Name: 
// Module Name:    filtering 
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
module filtering(
    output reg [7:0] out=0,
	 output reg [15:0] addr_edge=-1,
	 output reg finished=0,
	 output LOCKED,
    input start,
    input clk_25
    );

   wire clk_75;
   wire [7:0] dout_im;
	reg [15:0] addr_im=0;
	reg [7:0] matrix [0:2][0:2];
	reg [1:0] i=0,j=0;
	reg [1:0] row_matrix=0;
	reg [1:0] row_matrix1=0;
	reg [1:0] row_matrix2=0;
	reg [7:0] row=0,col=0;
	reg start_flag=0;
	reg signed [10:0] Ax=0;
	reg signed [10:0] Ay=0;
	reg [9:0] abs_Ax=0;
	reg [9:0] abs_Ay=0;
	reg [10:0] A=0;

  tripple_clock clk3
   (// Clock in ports
    .CLK_IN1(clk_25),      // IN
    // Clock out ports
    .CLK_OUT1(clk_75),     // OUT
    // Status and control signals
    .RESET(0),// IN
    .LOCKED(LOCKED));      // OUT



image im_sobel (
  .clka(clk_75), // input clka
  .addra(addr_im), // input [15 : 0] addra
  .douta(dout_im) // output [7 : 0] douta
);


   initial begin 
	   for(i=0;i<3;i=i+1) begin  
	       for(j=0;j<3;j=j+1) begin
	           matrix[i][j][7:0]=0;
				  if(i==3 && j==3) {i,j}=2'b00;
	       end
	   end
	end

   always @(posedge clk_75) begin
     if ( start ) start_flag<=1;
     if( start_flag==1 && LOCKED==1 ) begin		 
	    row_matrix<=row_matrix+1;
		 row_matrix1<=row_matrix;
		 row_matrix2<=row_matrix1;
		 addr_im<=224*(row+row_matrix)+col;
		 
		 if( row_matrix==2 ) begin 
		     row_matrix<=0;
		     col<=col+1;
			  if ( col==223) begin 
		     row<=row+1;
			  col<=0;
		     end
		 end

		if((row==0 && row_matrix<2 && col==0))
		   matrix[row_matrix2][2]<=0;
		else
		
	    matrix[row_matrix2][2]<=dout_im;
		 matrix[row_matrix2][1]<=matrix[row_matrix2][2];
	    matrix[row_matrix2][0]<=matrix[row_matrix2][1];
	  end
	  if ( col>=2 && row_matrix==2 ) begin 
	      Ax<=matrix[0][0]+2*matrix[1][0]+matrix[2][0]-matrix[0][2]-2*matrix[1][2]-matrix[2][2];
         Ay<=matrix[0][0]+2*matrix[0][1]+matrix[0][2]-matrix[2][0]-2*matrix[2][1]-matrix[2][2];
         if ( Ax<0 )  abs_Ax<=-Ax;
         else 		abs_Ax<=Ax;	
         if ( Ay<0 )  abs_Ay<=-Ay;
         else 		abs_Ay<=Ay;	  
	      A<=abs_Ax+abs_Ay;
			if ( A>=200 ) out<=0;
			else out<=255;
			addr_edge<=addr_edge+1;
	  end
	  if ( addr_edge==49284 ) begin 
	      finished<=1;
		   row<=0;
			start_flag<=0;
			 col<=0;
			 addr_im<=0;
			 row_matrix<=0;
			
		end
   end

endmodule
