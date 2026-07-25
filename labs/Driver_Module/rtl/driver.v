`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2026 10:30:25 PM
// Design Name: 
// Module Name: driver
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


module driver#(parameter WIDTH=8)(
    input wire [WIDTH-1:0] data_in,
    input wire  data_en,
    output reg [WIDTH-1:0] data_out
    );
   always @*
   begin 
    if (data_en)
     {data_out[WIDTH-1:0]} = {data_in[WIDTH-1:0]};
    else 
    data_out = 8'hZZ;
    end
endmodule

