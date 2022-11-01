`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:57:29 05/08/2021
// Design Name:   top
// Module Name:   F:/fpga lab/exp3/transceiver/test_top.v
// Project Name:  transceiver
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
	reg [3:0] input_addr;
	reg start;
	reg clk;

	// Outputs
	wire out;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.out(out), 
		.input_addr(input_addr), 
		.start(start), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		input_addr = 0;
		start = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#50;
		@(negedge clk) input_addr = 5;
		  start=1;
		@(negedge clk) start=0;

	end
    always #20.83 clk<=~clk;   
endmodule

