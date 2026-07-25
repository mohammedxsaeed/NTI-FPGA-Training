`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 07:26:49 PM
// Design Name: 
// Module Name: edge_detector
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


module Rising_edge_detector(
input wire clk,
input wire rst,
input wire level,
output reg tick_moore
    );
  localparam  
    ZERO =2'b00,  /// Moore States
    EDG =2'b01,
    ONE =2'b10;
    
   reg [1:0] present_state, next_state;
   /// Register Segment 
   always @(posedge clk , negedge rst)
   begin : Register_Segment 
   if(!rst)
   present_state<= ZERO;
   else
   present_state<=next_state;
   end
   // Moore Segment Compinitional
    always @(*)
    begin : moore_segment
    tick_moore =0;
    next_state = present_state;
    
    case(present_state)
    
    ZERO: 
    case(level)
    0: next_state=ZERO;
    1: next_state=EDG;
    endcase
    
    EDG: 
    begin
    tick_moore = 1;
    case(level)
    0: next_state=ZERO;
    1: next_state=ONE;
    endcase
    end
    ONE:  
    begin
    tick_moore =0;
    case(level)
    1: next_state=ONE;
    0: next_state=ZERO;
    endcase
    end
    default: next_state=ZERO;
    endcase

    end
    
endmodule

