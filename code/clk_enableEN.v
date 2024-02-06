`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/04/2023 01:08:01 PM
// Design Name: 
// Module Name: clk_enableEN
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


module clk_enableEN (
    input clk,
    input clr,
    output reg q );
    
    reg [27:0] S;
    always @(posedge clk or posedge clr)begin
    if (clr == 1) begin
    S = 2'b00;
   end 
   else if (S==9999999) begin
    S=0;
   q=1;   
    end
    else begin
        S= S + 1;
        q=0;
    end
    
    end
    
    

    
        
    
endmodule