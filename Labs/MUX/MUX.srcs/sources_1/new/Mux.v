`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2026 10:19:28 PM
// Design Name: 
// Module Name: Mux
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


module Mux #(parameter WIDTH=5)(
  input wire  sel,
  input wire  [WIDTH-1:0] in0,
  input wire  [WIDTH-1:0] in1,
  output reg [WIDTH-1:0] mux_out
    );
    always @*
    begin
    if (!sel)
    mux_out=in0;
    else 
    mux_out=in1;
    end
endmodule
