`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2026 08:40:40 PM
// Design Name: 
// Module Name: counter
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


module counter_func#(parameter WIDTH=5 )(

  input wire clk,  
  input wire rst,  
  input wire load ,
  input wire enab ,
  input wire [WIDTH-1:0] cnt_in,
  output reg [WIDTH-1:0] cnt_out
    );
    
    function [WIDTH-1:0] counter;
    input [WIDTH-1:0] cnt;
    input [WIDTH-1:0] current; 
    
    if (load)
    counter=cnt;
    
    else if (enab)
    counter=current+1;

    else
    counter=current; 
    
    endfunction
    
    always @(posedge clk)
    begin : Generic_Counter_Block
   
    if(rst)
    cnt_out<=0;
    else 
    cnt_out<=counter(cnt_in, cnt_out);
    end
endmodule