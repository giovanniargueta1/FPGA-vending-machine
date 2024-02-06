`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/08/2023 01:17:49 PM
// Design Name: 
// Module Name: Vending_Machine_Controller
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


module Vending_Machine_Controller(
input clk, input reset, input  conf_switch,input i_nickel, input i_dime, input i_quarter,
input sw0, input sw1, input sw2, input sw3,
output reg  oled_Soda, output reg  oled_Chips, output reg  oled_ProteinBar,
output reg  oled_Water,output reg oled_Error, 
//output reg [1:0] state,
 output reg [3:0] o_costMSB, output reg  [3:0] o_costLSB, 
 output reg [3:0] o_moneyMSB, output reg [3:0] o_moneyLSB,
 output reg [127:0] Page0, output reg [127:0] Page1, output reg [127:0] Page2, output reg [127:0] Page3
    );
    //sw0 = Water, sw1= chips, sw2= ProteinBar, sw3 = Soda
    parameter init = 2'b00;
    parameter selection = 2'b01;
    parameter dispense = 2'b10;
    parameter change = 2'b11;
    
    //wire [1:0] state_int;
    
    reg [7:0] bit1;
    reg [7:0]bit2;
    reg [7:0]bit3;
    reg [7:0]bit4;
    
    reg [1:0] state;
    reg [1:0] next_state;
    integer money;
    integer cost; // product cost
    integer Water = 25;
    integer Chips = 50;
    integer ProteinBar = 65;
    integer Soda= 80;
    integer nickel= 5;
    integer dime = 10;
    integer quarter = 25;
    integer flag1 = 0;
    integer flag2 = 0;
    integer flag3 =0;
    integer flag4 =0;
    integer moneyCalculated = 0;
   
  
    //95 % 10 = 5, gives ls digit,  
    //95 /10 = 9 , integer division (rounding down) gives MS digit
    // change demical(digits) to 4 bit, decoder
    
    
    always @(posedge clk , posedge reset)
   // assign state_int = state;
    //    assign o_state = state_int;
    if (reset == 1) begin 
    state <= init;
    end 
    else begin state <= next_state;
    end
    
    always @(posedge clk)
        begin 
      
        case (state)
        
            init: begin 
            
    // "ENEB344"
     Page0 <= {8'h45, 8'h4E, 8'h45, 8'h42, 8'h33, 8'h34, 8'h34, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20};
    // "Vending Machine"
     Page1 <= {8'h56, 8'h65, 8'h6E, 8'h64, 8'h69, 8'h6E, 8'h67, 8'h20, 8'h4D, 8'h61, 8'h63, 8'h68, 8'h69, 8'h6E, 8'h65, 8'h20};
    // "Giovanni Argueta"
     Page2 <= {8'h47, 8'h69, 8'h6F, 8'h76, 8'h61, 8'h6E, 8'h6E, 8'h69, 8'h20, 8'h41, 8'h72, 8'h67, 8'h75, 8'h65, 8'h74, 8'h61};
    // "blank"
     Page3 <= {8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20};
   
                oled_Soda =0;
                oled_Chips =0;
                oled_ProteinBar =0;
                oled_Water =0;
                oled_Error=0;
                cost = 0;
                o_costMSB = 4'b0000;
                o_costLSB= 4'b0000;
                o_moneyMSB= 4'b0000;
                o_moneyLSB= 4'b0000;
                money =0;
                flag1=0;
                flag2=0;
                flag3=0;
                flag4=0;
                moneyCalculated = 0;
               
                bit1=8'h30;
                bit2=8'h30;
                bit3=8'h30;
                bit4=8'h30;
              
      next_state= selection;
    end
        selection: begin
        oled_Error=0;
      
          if (sw0==1) begin
            if (flag1 ==0) begin
            cost = cost + Water;
            flag1 =1;
            bit1= 8'h31;
           end
           end
           else if (sw0 == 0) begin
           if (flag1 ==1) begin
           cost = cost - Water;
           flag1 = 0;
            bit1= 8'h30;
           end
           end
           
          if (sw1==1) begin
            if(flag2 ==0) begin
          cost = cost + Chips;
          flag2 = 1;
           bit2= 8'h31;
          end
          end
          else if(sw1 == 0) begin
          if (flag2 == 1) begin
          cost = cost- Chips;
          flag2 = 0;
           bit2= 8'h30;
          end 
          end
          
          if (sw2==1) begin
          if(flag3 ==0) begin
            cost = cost + ProteinBar;
            flag3= 1;
             bit3= 8'h31;
            end
            end
            else if (sw2 ==0) begin
            if(flag3 ==1) begin
            cost = cost - ProteinBar;
            flag3 =0;
             bit3= 8'h30;
            end 
            end
          
            if (sw3==1) begin
            if(flag4==0) begin
            cost = cost + Soda;
            flag4 =1;
             bit4= 8'h31;
            end
            end
            else if (sw3==0) begin
            if (flag4 ==1) begin
            cost = cost - Soda;
            flag4 =0;
             bit4= 8'h30;
            end
            end
           
    
    // "Water:SW3=(1/0)"
      Page0 <= {8'h57, 8'h61, 8'h74, 8'h65, 8'h72, 8'h3A, 8'h53, 8'h57, 8'h33, 8'h3D, bit1, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20};
    // "Chips:SW2=(1/0)"
    Page1 <= {8'h43, 8'h68, 8'h69, 8'h70, 8'h73, 8'h3A, 8'h53, 8'h57, 8'h32, 8'h3D, bit2, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20};
    // "PB:SW1=1DC:SW0=1"
     Page2 <= {8'h50, 8'h42, 8'h3A, 8'h53, 8'h57, 8'h31, 8'h3D, bit3, 8'h44, 8'h43, 8'h3A, 8'h53, 8'h57, 8'h30, 8'h3D, bit4};
    // "Buy: SW4=1"
     Page3 <= {8'h42, 8'h75, 8'h79, 8'h3A, 8'h20, 8'h53, 8'h57, 8'h34, 8'h3D, 8'h31, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20};
    
    
    if( cost <= 96) begin
        
     case (cost / 10)
                    0: o_costMSB = 4'b0000;
                    1: o_costMSB = 4'b0001;
                    2: o_costMSB = 4'b0010;
                    3: o_costMSB = 4'b0011;
                    4: o_costMSB = 4'b0100;
                    5: o_costMSB = 4'b0101;
                    6: o_costMSB = 4'b0110;
                    7: o_costMSB = 4'b0111;
                    8: o_costMSB = 4'b1000;
                    9: o_costMSB = 4'b1001;
                    default: o_costMSB = 4'b0000; // Default case, display 0
                endcase
                
             case (cost % 10)
                    0: o_costLSB = 4'b0000;
                    1: o_costLSB = 4'b0001;
                    2: o_costLSB = 4'b0010;
                    3: o_costLSB = 4'b0011;
                    4: o_costLSB = 4'b0100;
                    5: o_costLSB = 4'b0101;
                    6: o_costLSB = 4'b0110;
                    7: o_costLSB = 4'b0111;
                    8: o_costLSB = 4'b1000;
                    9: o_costLSB = 4'b1001;
                    default: o_costLSB = 4'b0000; // Default case, display 0
                endcase
        end
    
           
         // bonus feature 
       /*  if( sw0 && sw2) begin
          cost = cost - Water;
          cost = cost - ProteinBar;
          cost = cost + 80;
          end */
           // bonus feature 
        
          // add msb and lsb for cost
          if (money <= 95) begin
          if (i_nickel ==1) begin money = money + nickel;
          end
          if (i_dime==1)begin money = money + dime;
         end
          if (i_quarter==1) begin money = money + quarter;
         end
         end
         if (money <=95) begin
          case (money / 10)
                    0: o_moneyMSB = 4'b0000;
                    1: o_moneyMSB = 4'b0001;
                    2: o_moneyMSB = 4'b0010;
                    3: o_moneyMSB = 4'b0011;
                    4: o_moneyMSB = 4'b0100;
                    5: o_moneyMSB = 4'b0101;
                    6: o_moneyMSB = 4'b0110;
                    7: o_moneyMSB = 4'b0111;
                    8: o_moneyMSB = 4'b1000;
                    9: o_moneyMSB = 4'b1001;
                    default: o_moneyMSB = 4'b0000; // Default case, display 0
                endcase
        case (money % 10)
                    0: o_moneyLSB = 4'b0000;
                    1: o_moneyLSB = 4'b0001;
                    2: o_moneyLSB = 4'b0010;
                    3: o_moneyLSB = 4'b0011;
                    4: o_moneyLSB = 4'b0100;
                    5: o_moneyLSB = 4'b0101;
                    6: o_moneyLSB = 4'b0110;
                    7: o_moneyLSB = 4'b0111;
                    8: o_moneyLSB = 4'b1000;
                    9: o_moneyLSB = 4'b1001;
                    default: o_moneyLSB = 4'b0000; 
                endcase
       
         end
        
       if (money >=95)begin
        money = 95;
        end 
       if (conf_switch == 1) begin
            if((cost==0)) begin
                 next_state= selection;
                    oled_Error =1;
                     //Select a prod
                     Page3 <= {8'h53, 8'h65, 8'h6c, 8'h65, 8'h63, 8'h74, 8'h20, 8'h61, 8'h20, 8'h70, 8'h72, 8'h6F, 8'h64, 8'h20, 8'h20, 8'h20};
                     end   
              if ( (money < cost) || (money==0)) begin
                    next_state = selection;
                     oled_Error = 1;
                    //Enter more money
                    Page3 <= {8'h45, 8'h6E, 8'h74, 8'h65, 8'h72, 8'h20, 8'h6D, 8'h6F, 8'h72, 8'h65, 8'h20, 8'h6D, 8'h6F, 8'h6E, 8'h65, 8'h79};
                     end 
                  if( (money <cost) && (cost >95)) begin
                    next_state= selection;
                    oled_Error=1;
                    //Deselect prod(s)
                    Page3 <= {8'h44, 8'h65, 8'h73, 8'h65, 8'h6C, 8'h65, 8'h63, 8'h74, 8'h20, 8'h70, 8'h72, 8'h6F, 8'h64, 8'h28, 8'h73, 8'h29};
                     end 
                      else if((money >=cost) && (money>0) &&  (cost >0) && (cost<=95))begin
                      next_state=dispense;
                    end
                   end
                    else next_state= selection;
                     end
                 
                
          dispense: begin
            
    // "blank"
     Page0 <= {8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20};
    // "blank"
     Page1 <= {8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20};
    // " ....Dispensing... "
     Page2 <= {8'h2E, 8'h2E, 8'h2E, 8'h2E, 8'h44, 8'h69, 8'h70, 8'h65, 8'h6E, 8'h73, 8'h69, 8'h6E, 8'h67, 8'h2E, 8'h2E, 8'h2E};
    // "blank"
     Page3 <= {8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20};
   
          oled_Error =0;
          if( sw0 && sw2) begin
          cost = cost - Water;
          cost = cost - ProteinBar;
          cost = cost + 80;
          //Discount!20c off
          Page3 <= {8'h44, 8'h69, 8'h73, 8'h63, 8'h6F, 8'h75, 8'h6E, 8'h74, 8'h21, 8'h32, 8'h30, 8'h63, 8'h20, 8'h6F, 8'h66, 8'h66};
          end
          
        if( cost<=96) begin
     case (cost / 10)
                    0: o_costMSB = 4'b0000;
                    1: o_costMSB = 4'b0001;
                    2: o_costMSB = 4'b0010;
                    3: o_costMSB = 4'b0011;
                    4: o_costMSB = 4'b0100;
                    5: o_costMSB = 4'b0101;
                    6: o_costMSB = 4'b0110;
                    7: o_costMSB = 4'b0111;
                    8: o_costMSB = 4'b1000;
                    9: o_costMSB = 4'b1001;
                    default: o_costMSB = 4'b0000; // Default case, display 0
                endcase
                
             case (cost % 10)
                    0: o_costLSB = 4'b0000;
                    1: o_costLSB = 4'b0001;
                    2: o_costLSB = 4'b0010;
                    3: o_costLSB = 4'b0011;
                    4: o_costLSB = 4'b0100;
                    5: o_costLSB = 4'b0101;
                    6: o_costLSB = 4'b0110;
                    7: o_costLSB = 4'b0111;
                    8: o_costLSB = 4'b1000;
                    9: o_costLSB = 4'b1001;
                    default: o_costLSB = 4'b0000; // Default case, display 0
                endcase
                end
    /* if( sw0 && sw2) begin
          cost = cost - Water;
          cost = cost - ProteinBar;
          cost = cost + 80;
          end */
       
            if(sw0) begin
            oled_Water = 1;
            end
            if (sw1) begin
            oled_Chips =1;
            end 
            if (sw2) begin
            oled_ProteinBar =1;
            end
            if (sw3) begin
            oled_Soda =1;
            end 
            
            if(money >= cost) begin
           next_state = change;
          end
        
         
          end
          
     
          change: begin
            
    // "Here's your"
    Page0 <= {8'h48, 8'h65, 8'h72, 8'h65, 8'h27, 8'h73, 8'h20, 8'h79, 8'h6F, 8'h75, 8'h72, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20};
    // "Change"
     Page1 <= {8'h43, 8'h68, 8'h61, 8'h6E, 8'h67, 8'h65, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20};
    // "Turn off all sws"
     Page2 <= {8'h54, 8'h75, 8'h72, 8'h6E, 8'h20, 8'h6F, 8'h66, 8'h66, 8'h20, 8'h61, 8'h6C, 8'h6C, 8'h20, 8'h73, 8'h77, 8'h73};
    // "to buy again"
     Page3 <= {8'h74, 8'h6F, 8'h20, 8'h62, 8'h75, 8'h79, 8'h20, 8'h61, 8'h67, 8'h61, 8'h69, 8'h6E, 8'h20, 8'h20, 8'h20, 8'h20};
    
             if (!moneyCalculated && (money >= cost)) begin
            money = money - cost;
            moneyCalculated =1 ; 
        end  
        if(money <=95)begin
                case (money / 10)
                    0: o_moneyMSB = 4'b0000;
                    1: o_moneyMSB = 4'b0001;
                    2: o_moneyMSB = 4'b0010;
                    3: o_moneyMSB = 4'b0011;
                    4: o_moneyMSB = 4'b0100;
                    5: o_moneyMSB = 4'b0101;
                    6: o_moneyMSB = 4'b0110;
                    7: o_moneyMSB = 4'b0111;
                    8: o_moneyMSB = 4'b1000;
                    9: o_moneyMSB = 4'b1001;
                    default: o_moneyMSB = 4'b0000; 
                endcase
        case (money % 10)
                    0: o_moneyLSB = 4'b0000;
                    1: o_moneyLSB = 4'b0001;
                    2: o_moneyLSB = 4'b0010;
                    3: o_moneyLSB = 4'b0011;
                    4: o_moneyLSB = 4'b0100;
                    5: o_moneyLSB = 4'b0101;
                    6: o_moneyLSB = 4'b0110;
                    7: o_moneyLSB = 4'b0111;
                    8: o_moneyLSB = 4'b1000;
                    9: o_moneyLSB = 4'b1001;
                    default: o_moneyLSB = 4'b0000; 
                endcase
                end
               if ((sw0 == 0) && (sw1 == 0) && (sw2 ==0) && (sw3 ==0))
               next_state = init;
        end
        
 
       endcase
        
        
           
              
       end
endmodule
