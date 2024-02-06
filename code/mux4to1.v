`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2023 03:12:13 PM
// Design Name: 
// Module Name: mux4to1
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


module mux4to1(
input [1:0] S,
    input [3:0]Dig1,
    input [3:0]Dig2,
    input [3:0]Dig3,
    input [3:0]Dig4,
    output reg [3:0] x
    );
    always @(*) begin 
    case(S) 
        2'b00: x=Dig1; 
        2'b01: x=Dig2;
        2'b10: x=Dig3;
        2'b11: x=Dig4; 
        default: x=4'b1111; 
    endcase
    end
    
    
endmodule
