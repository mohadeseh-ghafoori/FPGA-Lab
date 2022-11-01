`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   21:29:47 07/14/2021
// Design Name:   top
// Module Name:   F:/fpga lab/exp6/ft/test_top.v
// Project Name:  ft
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_top;

	// Inputs
	reg rxf;
	reg txe;
	reg clk;

	// Outputs
	wire wr;
	wire rd;

	// Bidirs
	wire [7:0] data;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.wr(wr), 
		.rd(rd), 
		.rxf(rxf), 
		.txe(txe), 
		.data(data), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		rxf = 1;
		txe = 1;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#100;
       force data=8;
		 rxf=0;
		 #50;
		 release data;
		 rxf=1;
		 txe=0;

	end
  always #20.83 clk<=~clk;    
endmodule

