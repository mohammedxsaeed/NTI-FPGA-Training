`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 03:46:16 AM
// Design Name: 
// Module Name: counter_gate_level
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


module counter_gate_level(
input wire clock,    
input wire reset,   // asynchronous, active-high 
input wire up,     // 1 = count up, 0 = count down 
output [1:0] count 
); 
wire [1:0]D;
not (D[0],count[0]); // D0 = ~ Q0

xnor(D[1], count[0],count[1], up); // D1 = ~ (UP ^ Q0 ^ Q1)

D_FF count0 ( .clk(clock), .rst(reset), .d(D[0]), .q(count[0]));
D_FF count1 ( .clk(clock), .rst(reset), .d(D[1]), .q(count[1]));

endmodule
