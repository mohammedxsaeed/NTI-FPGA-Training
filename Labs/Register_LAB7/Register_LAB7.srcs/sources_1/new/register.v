`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2026 04:02:26 PM
// Design Name: 
// Module Name: register
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
//`default_nettype none 

module register #(parameter WIDTH=8)(
    input wire clk,
    input wire rst,
    input wire load,
    input wire [WIDTH-1:0] data_in,
    output reg [WIDTH-1:0] data_out
    );
    
    always @(posedge clk) 
    begin 
    if(rst)
    data_out <= 'b0;
    else if(load)
    data_out <= data_in;
    else data_out <= data_out;
 end
endmodule
