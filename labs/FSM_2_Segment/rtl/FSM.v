`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2026 09:23:03 PM
// Design Name: 
// Module Name: FSM
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

module FSM(
  input wire a,
  input wire b,
  input wire clk,
  input wire reset,
  
  output reg y0,
  output reg y1
);

  // State Encoding
  localparam [1:0] S0 = 2'b00,
                   S1 = 2'b01,
                   S2 = 2'b10;
  
  // Signals/Registers declaration 
  reg [1:0] present_state, next_state;
  
  // State Memory Segment (Sequential)
  always @(posedge clk or negedge reset)
   begin : State_Register
      if(!reset)
          present_state <= S0;
      else 
          present_state <= next_state;
  end
  
  //  Next State & Output Logic Segment (Combinational)
  always @(*)
   begin : Next_State_and_Output
      next_state = present_state; 
      y0 = 1'b0;
      y1 = 1'b0;
      case(present_state)
          S0: begin
              y1 = 1'b1;
              case({a,b})
                  2'b00: begin
                      next_state = S0;
                      y0 = 1'b0;
                  end
                  2'b10: begin 
                      next_state = S1;
                      y0 = 1'b0;
                  end
                  2'b11: begin
                      next_state = S2;
                      y0 = 1'b1;
                  end
                  default: begin
                      next_state = S0;
                      y0 = 1'b0;
                  end
              endcase
          end
          S1: begin
              y0 = 1'b0;
              y1 = 1'b1;
              next_state = a? S0 : S1;
          end
          S2: begin
              y1 = 1'b0;
              y0 = 1'b0;
              next_state = S0;
          end
          default: next_state = S0;
      endcase
  end
endmodule