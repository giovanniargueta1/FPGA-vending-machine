`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/10/2023 10:55:28 PM
// Design Name: 
// Module Name: vending_fsm_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vending_fsm_tb;
 reg clk;reg reset;reg conf_switch;reg nickel;reg dime;reg quarter; 
reg sw0;reg sw1;reg sw2;reg sw3;
wire oled_Soda;wire  oled_Chips; wire oled_ProteinBar; wire oled_Water;
wire oled_Error;
wire [1:0] state;
wire [3:0] o_costMSB; wire [3:0] o_costLSB;
wire [3:0] o_moneyMSB; wire [3:0] o_moneyLSB;
 
Vending_Machine_Controller uut (
 .clk(clk), .reset(reset), .conf_switch(conf_switch), .i_nickel(nickel),.i_dime(dime),.i_quarter(quarter),
 .sw0(sw0), .sw1(sw1), .sw2(sw2), .sw3(sw3), .oled_Soda(oled_Soda), 
 .oled_Chips(oled_Chips),.oled_ProteinBar(oled_ProteinBar), .oled_Water(oled_Water),.oled_Error(oled_Error),
  .state(state),.o_costMSB(o_costMSB), .o_costLSB(o_costLSB),
 .o_moneyMSB(o_moneyMSB), .o_moneyLSB(o_moneyLSB)
 );
 initial begin
 clk= 0;
 forever #5 clk = ~clk;

 end
 initial begin
 reset=1;
 #10
 reset=0;
 #10
 conf_switch =0;
 nickel =0;
 dime = 0;
 quarter =0;
 sw0 =0;
 sw1= 0;
 sw2= 0;
 sw3 = 0;
#10
sw0=1;
#10
sw3=1;
 quarter=1;
 #10
 quarter=0;
 #10
 quarter=1;
 #10
 quarter=0;
 #10
 quarter =1;
 #10
 quarter =0;
 #10
 dime=1;
 #10
 dime=0;
 #10
 dime=1;
 #10
 dime=0;
 #10
 
 conf_switch =1; 
#100

 conf_switch=0;
 sw0=0;
 sw1=1;
 
 end
  
endmodule
