`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/17/2023 10:21:35 PM
// Design Name: 
// Module Name: hex2sevseg
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


module hex2sevseg(
    input [3:0] x,
    output reg [6:0] ca
);

// Define 7-segment display patterns for hexadecimal digits
always @(*)
begin
    case (x)
        4'b0000: ca = 7'b0000001; 
        4'b0001: ca = 7'b1001111; 
        4'b0010: ca = 7'b0010010; 
        4'b0011: ca = 7'b0000110; 
        4'b0100: ca = 7'b1001100; 
        4'b0101: ca = 7'b0100100; 
        4'b0110: ca = 7'b0100000; 
        4'b0111: ca = 7'b0001111; 
        4'b1000: ca = 7'b0000000; 
        4'b1001: ca = 7'b0000100; 
        4'b1010: ca = 7'b0001000; 
        4'b1011: ca = 7'b1100000; 
        4'b1100: ca = 7'b0110001; 
        4'b1101: ca = 7'b1000010; 
        4'b1110: ca = 7'b0110000; 
        4'b1111: ca = 7'b0111000; 
        default: ca = 7'bxxxxxxx; 
    endcase
end

endmodule
