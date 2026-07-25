`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2026 11:00:07 PM
// Design Name: 
// Module Name: memory
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


module memory #(
    parameter AWIDTH=5,
    parameter DWIDTH=8 
)(
    input  wire              clk,
    input  wire              wr,
    input  wire              rd,
    input  wire [AWIDTH-1:0] addr,
    inout   [DWIDTH-1:0] data
);
    reg [DWIDTH-1:0] mem [0:(1<<AWIDTH)-1]; 
  
  assign  data = (rd && !wr)? mem[addr]  : 'bz ;
    always @(posedge clk) begin
        if (wr) begin
            mem[addr] <= data;
        end
    end
endmodule
