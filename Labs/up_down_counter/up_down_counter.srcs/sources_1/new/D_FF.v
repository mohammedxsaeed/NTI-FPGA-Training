`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 02:49:26 PM
// Design Name: 
// Module Name: D_FF
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

module D_FF(
    input clk,
    input rst, // Asyncrounus Reset high enable
    input d,
    output reg q
    );

    always@(posedge clk or posedge rst)
    begin
     if(rst)
        q <= 1'b0; 
     else
        q <= d;
        end
        
endmodule
