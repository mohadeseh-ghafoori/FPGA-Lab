`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   19:58:25 05/08/2021
// Design Name:   transmitter
// Module Name:   F:/fpga lab/exp3/transceiver/test_transmiiterandreceiver.v
// Project Name:  transceiver
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: transmitter
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test_transmiiterandreceiver;

	// Inputs
	reg [7:0] data;
	reg start;
	reg clk;

	// Outputs
	wire Tx;
	wire Rx;
	wire oTx,ob;
	wire [3:0] cnt;
	wire [3:0] cnt1;
   wire data_valid;
	wire [7:0] data_out;
	// Instantiate the Unit Under Test (UUT)
	transmitter uut (
		.Tx(Tx), 
		.cnt(cnt), 
		.data(data), 
		.start(start), 
		.clk(clk)
	);
	receiver uuut (
	   .data_valid(data_valid),
		.cnt(cnt1),
		.data_out(data_out),
		.clk(clk),
		.Rx(Rx)
	);

	initial begin
		// Initialize Inputs
		data = 0;
		start = 0;
		clk = 0;

		// Wait 100 ns for global reset to finish
		#50;
		@(negedge clk) data=67;
		  start=1;
		@(negedge clk) start=0;
        
		// Add stimulus here

	end
	OBUFDS o1(
	   .I(Tx),
		.O(oTx),
		.OB(ob)
		);
	IBUFDS o2(
	   .I(oTx),
	   .IB(ob),
	   .O(Rx)
		 );
	always @(posedge clk) begin 
	   if ( cnt==11 ) begin 
		    start<=1;
		    data<=76;
		end
		else start<=0;
	
	end
   always #20.83 clk<=~clk;   
endmodule

