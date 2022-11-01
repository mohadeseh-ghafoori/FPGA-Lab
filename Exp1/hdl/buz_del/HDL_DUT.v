// -------------------------------------------------------------
// 
// File Name: F:\fpga lab\exp1\hdl\buz_del\HDL_DUT.v
// Created: 2021-03-17 23:19:41
// 
// Generated by MATLAB 9.5 and HDL Coder 3.13
// 
// 
// -- -------------------------------------------------------------
// -- Rate and Clocking Details
// -- -------------------------------------------------------------
// Model base rate: 0.000125
// Target subsystem base rate: 0.000125
// 
// 
// Clock Enable  Sample Time
// -- -------------------------------------------------------------
// ce_out        0.000125
// -- -------------------------------------------------------------
// 
// 
// Output Signal                 Clock Enable  Sample Time
// -- -------------------------------------------------------------
// out                           ce_out        0.000125
// -- -------------------------------------------------------------
// 
// -------------------------------------------------------------


// -------------------------------------------------------------
// 
// Module: HDL_DUT
// Source Path: buz_del/HDL_DUT
// Hierarchy Level: 0
// 
// -------------------------------------------------------------

`timescale 1 ns / 1 ns

module HDL_DUT
          (clk,
           reset,
           clk_enable,
           in1,
           ce_out,
           out);


  input   clk;
  input   reset;
  input   clk_enable;
  input   signed [15:0] in1;  // sfix16_En15
  output  ce_out;
  output  signed [17:0] out;  // sfix18_En15


  wire enb;
  reg signed [15:0] Delay_out1;  // sfix16_En15
  reg signed [15:0] Delay1_out1;  // sfix16_En15
  wire signed [31:0] Gain_mul_temp;  // sfix32_En29
  wire signed [15:0] Gain_out1;  // sfix16_En14
  wire signed [17:0] Sum_stage2_sub_cast;  // sfix18_En15
  wire signed [17:0] Sum_stage2_sub_cast_1;  // sfix18_En15
  wire signed [17:0] Sum_op_stage2;  // sfix18_En15
  reg signed [15:0] Delay2_out1;  // sfix16_En15
  wire signed [17:0] Sum_stage3_add_cast;  // sfix18_En15
  wire signed [17:0] Sum_out1;  // sfix18_En15


  assign enb = clk_enable;

  always @(posedge clk or posedge reset)
    begin : Delay_process
      if (reset == 1'b1) begin
        Delay_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay_out1 <= in1;
        end
      end
    end



  always @(posedge clk or posedge reset)
    begin : Delay1_process
      if (reset == 1'b1) begin
        Delay1_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay1_out1 <= Delay_out1;
        end
      end
    end



  assign Gain_mul_temp = 16'sb0111100110111010 * Delay1_out1;
  assign Gain_out1 = Gain_mul_temp[30:15] + $signed({1'b0, Gain_mul_temp[14]});



  assign Sum_stage2_sub_cast = {{2{Delay_out1[15]}}, Delay_out1};
  assign Sum_stage2_sub_cast_1 = {Gain_out1[15], {Gain_out1, 1'b0}};
  assign Sum_op_stage2 = Sum_stage2_sub_cast - Sum_stage2_sub_cast_1;



  always @(posedge clk or posedge reset)
    begin : Delay2_process
      if (reset == 1'b1) begin
        Delay2_out1 <= 16'sb0000000000000000;
      end
      else begin
        if (enb) begin
          Delay2_out1 <= Delay1_out1;
        end
      end
    end



  assign Sum_stage3_add_cast = {{2{Delay2_out1[15]}}, Delay2_out1};
  assign Sum_out1 = Sum_op_stage2 + Sum_stage3_add_cast;



  assign out = Sum_out1;

  assign ce_out = clk_enable;

endmodule  // HDL_DUT

