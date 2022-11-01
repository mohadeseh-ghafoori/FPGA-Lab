`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:50:26 05/26/2021
// Design Name:   filtering
// Module Name:   F:/fpga lab/exp5/image_processing/test_image.v
// Project Name:  image_processing
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: filtering
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_image;

	// Inputs
	reg start;
	reg clk_25;

	// Outputs
	wire [7:0] out;
	wire LOCKED;
	wire finished;
	wire [15:0] addr_edge;
	reg [7:0] outfile [0:222*222-1];
	integer fd;
	integer i=0;

	// Instantiate the Unit Under Test (UUT)
	filtering uut (
		.out(out), 
		.LOCKED(LOCKED),
      .finished(finished),
      .addr_edge(addr_edge),		
		.start(start), 
		.clk_25(clk_25)
	);

	initial begin
		// Initialize Inputs
		start = 0;
		clk_25 = 0;

		// Wait 100 ns for global reset to finish
		#100;
		wait ( LOCKED==1 ) start=1;
		@(negedge clk_25) start=0;
        
		// Add stimulus here

	end
	initial begin 
	fd=$fopen("output.txt","w");
	end
	always @(posedge finished) begin 
	  for (i=0;i<222*222;i=i+1) begin 
	      $fwrite(fd,"%d\n",outfile[i][7:0]);
	  end
	  $fclose(fd);
	end
	always @(posedge clk_25) begin 
	  if( finished==0 ) outfile[addr_edge]<=out;
	end
 always #20 clk_25<=~clk_25;     
endmodule

