`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 03:20:45 PM
// Design Name: 
// Module Name: counter2_struct
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


module counter2_struct(
input wire clock,    
input wire reset,   // asynchronous, active-high 
input wire up,     // 1 = count up, 0 = count down 
output [1:0] count 
    );
    wire [1:0]next_state ;
     next_state_D next_count( .current_count (count), .control_in (up), .D (next_state));
    
     D_FF count0 (.clk(clock),.rst(reset),.d(next_state [0]),.q(count [0]));
     D_FF count1 (.clk(clock),.rst(reset),.d(next_state [1]),.q(count [1]));
endmodule
