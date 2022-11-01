`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   23:34:27 05/18/2021
// Design Name:   road
// Module Name:   F:/fpga lab/exp4/controlling/test_road.v
// Project Name:  controlling
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: road
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_road;

	// Inputs
	reg sensor;
	reg clk;

	// Outputs
	wire [7:0] timer;
	wire en;
	wire green_main;
	wire yellow_main;
	wire red_main;
	wire green_secondary;
	wire yellow_secondary;
	wire red_secondary;

	// Instantiate the Unit Under Test (UUT)
	road uut (
		.timer(timer), 
		.en(en), 
		.green_main(green_main), 
		.yellow_main(yellow_main), 
		.red_main(red_main), 
		.green_secondary(green_secondary), 
		.yellow_secondary(yellow_secondary), 
		.red_secondary(red_secondary), 
		.sensor(sensor), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		sensor = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#40;
		sensor = 1;
        
		// Add stimulus here

	end
   always #20.83 clk<=~clk;       
endmodule

