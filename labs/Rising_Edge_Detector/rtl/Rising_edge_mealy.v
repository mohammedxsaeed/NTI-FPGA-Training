`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 08:44:21 PM
// Design Name: 
// Module Name: Rising_edge_mealy
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


module Rising_edge_mealy(
input wire clk,
input wire rst,
input wire level,
output reg tick_mealy
    );
  localparam  
    ZERO=1'b0, /// Mealy States
    ONE=1'b1;
   
   reg present_state, next_state;
   /// Register Segment 
   always @(posedge clk, negedge rst)
   begin : Register_Segment 
   if(!rst)
   present_state<= ZERO;
   else
   present_state<=next_state;
   end
   // Mealy Segment Compinitional
    always @(*)
    begin : mealy_segment
    tick_mealy =0;
    next_state = present_state;
    case(present_state)
    ZERO: 
    case(level)
    0: next_state=ZERO;
    1: 
    begin 
    tick_mealy = 1;
    next_state=ONE;
    end
    endcase
    ONE:  
    begin
    tick_mealy =0;
    case(level)
    1: next_state=ONE;
    0: next_state=ZERO;
    endcase
    end
    default: next_state=ZERO;
    endcase
    end
    
endmodule

