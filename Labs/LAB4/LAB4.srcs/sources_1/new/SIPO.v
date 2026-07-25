`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2026 05:25:34 PM
// Design Name: 
// Module Name: SIPO
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


module SIPO #(parameter WIDTH=20)(
    input  clk,
    input  rst_n,
    input  shift_en,
    input  serial_in,
    output reg [WIDTH-1:0] parallel_out
    );
    always @(posedge clk , negedge rst_n)
    begin
    if(!rst_n)
    parallel_out <= 0;
    else if(shift_en)
    parallel_out <= {parallel_out[WIDTH-2:0], serial_in};
    else 
    parallel_out <= parallel_out ;
    end

endmodule
