`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2026 10:18:16 PM
// Design Name: 
// Module Name: FSM_multi_segment
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
module FSM_multi_segment(
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
  
  // Signals declaration 
  reg [1:0] present_state, next_state;
  
  // Segment 1: State Memory (Sequential)
  
  always @(posedge clk or negedge reset) begin : State_Register
      if(!reset)
          present_state <= S0;
      else 
          present_state <= next_state; 
  end
  
  // Segment 2: Next State Logic (Combinational)
  always @(*) begin : Next_State_Logic
      next_state = present_state; 

      case(present_state)
          S0: begin
              case({a,b})
                  2'b00: next_state = S0;
                  2'b10: next_state = S1;
                  2'b11: next_state = S2;
                  default: next_state = S0;
              endcase
          end
          S1: begin
              case(a)
                  1'b0: next_state = S1;
                  1'b1: next_state = S0;
              endcase
          end
          S2: begin
              next_state = S0;
          end
          default: next_state = S0;
      endcase
  end

  // Segment 3: Output Logic (Combinational)
  always @(*) begin : Output_Logic
      y0 = 1'b0;
      y1 = 1'b0;
      case(present_state)
          S0: begin
              y1 = 1'b1;
              y0 =a?  (b? 1'b1 : 1'b0) : 1'b0;
          end
          S1: begin
              y1 = 1'b1;
              y0 = 1'b0;
          end
          S2: begin
              y1 = 1'b0;
              y0 = 1'b0;
          end
      endcase
  end
endmodule