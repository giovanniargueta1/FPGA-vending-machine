`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2023 03:00:22 PM
// Design Name: 
// Module Name: display
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


module display(
    input clr,
    input clk,
    input [3:0] Dig1,
    input [3:0] Dig2,
    input [3:0] Dig3,
    input [3:0]Dig4,
    output [3:0]AN,
    output [6:0] ca
    );
    wire q;
    wire [1:0] S;
    wire [3:0] x;
    
    clk_enable c1(
    .clk(clk), .clr(clr), .q(q));
    
    anode_driver an(.clk(clk),.clr(clr),.clk_en(q),.S(S),.AN(AN)); 
    
    mux4to1 m1(.Dig1(Dig1),.Dig2(Dig2),.Dig3(Dig3),.Dig4(Dig4),.S(S),.x(x));
    
    hex2sevseg hex(.x(x),.ca(ca)); 
    
   
    
endmodule
