`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 08:49:52 PM
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


module edge_detector(
   input wire clk,
    input wire rst,
    input wire level,
    output reg tick
    );
  localparam  
    ZERO =2'b00,  /// Moore States
    EDG =2'b01,
    ONE =2'b10;

   reg [1:0] present_state, next_state;
   
   /// State Segment 
   always @(posedge clk)
   begin : State_Segment 
   if(!rst)
   present_state<= ZERO;
   else
   present_state<=next_state;
   end
   // Moore Segment Compinitional
    always @(*)
    begin : moore_segment
    tick=0;
    next_state = present_state;
    
    case(present_state)
    ZERO: 
    case(level)
    0: next_state=ZERO;
    1: next_state=EDG;
    endcase
    EDG: 
    begin
    tick = 1;
    case(level)
    0: next_state=ZERO;
    1: next_state=ONE;
    endcase
    end
    
    ONE:  
    begin
    tick =0;
    case(level)
    1: next_state=ONE;
    0: next_state=EDG;
    endcase
    end
    default: next_state=ZERO;
    endcase

    end
endmodule