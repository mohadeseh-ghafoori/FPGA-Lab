`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:08:31 06/22/2021 
// Design Name: 
// Module Name:    top_tranrec 
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
module top_tranrec(
    output [7:0] data_out,
    input [7:0] data,
    input start,
    input clk
    );
	 
    wire Tx,data_valid;
	 wire [3:0] cnt_trans;
	 wire [3:0] cnt_rec;

	transmitter t2(Tx,cnt_trans,data,~start,clk);
   receiver r2(data_valid,cnt_rec,data_out,clk,Tx);

endmodule
