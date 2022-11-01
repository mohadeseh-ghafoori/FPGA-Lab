`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   09:40:25 04/10/2021
// Design Name:   top
// Module Name:   F:/fpga lab/exp2/picblaze_sevenseg/test_top.v
// Project Name:  picblaze_sevenseg
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
	reg [3:0] a;
	reg [3:0] b;
	reg rst;
	reg clk;

	// Outputs
	wire [7:0] out;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.out(out), 
		.a(a), 
		.b(b), 
		.rst(rst), 
		.clk(clk)
	);

	initial begin
		// Initialize Inputs
		a = 0;
		b = 0;
		rst = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#30;
		a = 3;
		b = 2;
        
		// Add stimulus here

	end
	always @(posedge clk) begin 
	   if (  out==8'b00110000 ) begin 
		      a=4;
				b=2;
		end
	
	end 
	always #20.83 clk<=~clk;
      
endmodule

