`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2023 01:19:19 PM
// Design Name: 
// Module Name: anode_driver
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


module anode_driver(
    input clk,
    input clr,
    input clk_en,
    output reg[1:0]S,
    output reg[3:0]AN
    );
    always @(posedge clk)begin
    if (clr == 1) begin
    S = 2'b00;
   end 
   
   if(clk_en ) begin
    S= S + 1;
   //S=2'b11;
    end
    
    end
    
    
    
    always @(S) begin 
    if (S==2'b00) 
    AN = 4'b1110;
    else if (S==2'b01)
    AN = 4'b1101;
    else if (S==2'b10)
    AN= 4'b1011;
    else if (S==2'b11)
    AN = 4'b0111;
    end
    
endmodule
