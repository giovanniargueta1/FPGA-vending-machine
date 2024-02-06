`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/25/2023 11:22:35 PM
// Design Name: 
// Module Name: top
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


module top(
input clk, input reset , input conf_switch, input i_nickel , input i_dime, input i_quarter, 
input sw0, input sw1, input sw2, input sw3, output  oled_Soda, output  oled_Chips, output oled_ProteinBar,
output oled_Water, output oled_Error, output LED15,

output [6:0] ca, output [3:0] AN,

	output wire CS,
	output wire SDIN,
	output wire SCLK,
	output wire DC,
	output wire RES,
	output wire VBAT,
	output wire VDD
	
	
    );
    wire [3:0]o_moneyMSB; wire [3:0] o_moneyLSB;
    wire [3:0]o_costMSB; wire [3:0] o_costLSB;
    wire clk_en;
    wire clk_en2;
  
	wire[127:0] Page0, Page1, Page2, Page3;
	
	//mapping EN to 10hz clock
	clk_enableEN clkenable3(
	.clk(clk),.clr(reset),.q(clk_en2));
	
	//mapping 1hz clock to LED15
    clk_enablevmc clkdivider2(
    .clk(clk),.clr(reset),.q(LED15));
    
    clk_enablevmc clkdivider(
    .clk(clk),.clr(reset),.q(clk_en));
    
    Vending_Machine_Controller uut2(
    .clk(clk_en), .reset(reset),.conf_switch(conf_switch), .i_nickel(i_nickel), 
    .i_dime(i_dime), .i_quarter(i_quarter), .sw0(sw0), .sw1(sw1), .sw2(sw2),.sw3(sw3),.oled_Soda(oled_Soda),
    .oled_Chips(oled_Chips),.oled_ProteinBar(oled_ProteinBar),.oled_Water(oled_Water),
    .oled_Error(oled_Error),
    .o_moneyMSB(o_moneyMSB),.o_moneyLSB(o_moneyLSB),
    .o_costMSB(o_costMSB), .o_costLSB(o_costLSB),
    .Page0(Page0), .Page1(Page1), .Page2(Page2),.Page3(Page3)
    );
    
    display ddut(
    .clr(reset), .clk(clk), .Dig4(o_costMSB),.Dig3(o_costLSB), .Dig2(o_moneyMSB),.Dig1(o_moneyLSB), .ca(ca), .AN(AN));
 
    PmodOLEDCtrl test2 (
    
		.CLK(clk),
		.RST(reset),
		.EN(clk_en2),
        .Page0(Page0),
        .Page1(Page1),
        .Page2(Page2),
        .Page3(Page3),
		.CS(CS),
		.SDIN(SDIN),
		.SCLK(SCLK),
		.DC(DC),
		.RES(RES),
		.VBAT(VBAT),
		.VDD(VDD)
		
	);

    
    
endmodule
