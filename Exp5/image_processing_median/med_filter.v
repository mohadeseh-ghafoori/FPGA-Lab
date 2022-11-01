`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:29:07 06/04/2021 
// Design Name: 
// Module Name:    med_filter 
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
module med_filter(
    output  [7:0] out,
	 output LOCKED,
	 output reg [15:0] addr_med=-1,
	 output reg finished=0,
    input start,
    input clk_25
    );
   wire clk_75;
	wire clk25;
   wire [7:0] dout_im;
	reg [15:0] addr_im=0;
	reg [7:0] matrix [0:2][0:2];
	reg [1:0] i=0,j=0;
	reg [1:0] row_matrix=0;
	reg [1:0] row_matrix1=0;
	reg [1:0] row_matrix2=0;
	reg [7:0] row=0,col=0;
	reg start_flag=0;
	reg [7:0] a11=0,a12=0,a13=0,a21=0,a22=0,a23=0,a31=0,a32=0,a33=0;
	wire [7:0] maxr1,maxr2,maxr3,medr1,medr2,medr3,minr1,minr2,minr3;
   wire [7:0] maxc1,maxc2,maxc3,medc1,medc2,medc3,minc1,minc2,minc3;

  tripple_clock clk3
   (// Clock in ports
    .CLK_IN1(clk_25),      // IN
    // Clock out ports
    .CLK_OUT1(clk_75),     // OUT
    .CLK_OUT2(clk25),     // OUT
    // Status and control signals
    .RESET(0),// IN
    .LOCKED(LOCKED));      // OUT



image im_med (
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
         a11<=matrix[0][0];
         a12<=matrix[0][1];
			a13<=matrix[0][2];
			a21<=matrix[1][0];
			a22<=matrix[1][1];
			a23<=matrix[1][2];
			a31<=matrix[2][0];
			a32<=matrix[2][1];
			a33<=matrix[2][2];
			if ( out!=0 ) addr_med<=addr_med+1;
	  end
	  if ( addr_med==49284 ) begin 
       	  finished<=1;
		     row<=0;
			  col<=0;
			  start_flag<=0;
		     addr_im<=0;
		     row_matrix<=0;
	 end
   end
arrange r1(maxr1,medr1,minr1,a11,a12,a13,clk25);
arrange r2(maxr2,medr2,minr2,a21,a22,a23,clk25);
arrange r3(maxr3,medr3,minr3,a31,a32,a33,clk25);
arrange c1(maxc1,medc1,minc1,minr1,minr2,minr3,clk25);
arrange c2(maxc2,medc2,minc2,medr1,medr2,medr3,clk25);
arrange c3(maxc3,medc3,minc3,maxr1,maxr2,maxr3,clk25);
arrange total(,out,,minc3,medc2,maxc1,clk25);

endmodule
