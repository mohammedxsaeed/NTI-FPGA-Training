`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2026 08:25:53 PM
// Design Name: 
// Module Name: RAM
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

module RAM #(parameter DATA_WIDTH=20, ADDR_WIDTH=8,DEPTH=256) (
    input clk,
    input rst_n,
    input WR,
    input RD,
    input [DATA_WIDTH-1:0] data_in,
    input [ADDR_WIDTH-1:0] addr,
    output reg [DATA_WIDTH-1:0] data_out,
    output reg  valid
    );
    
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    
    always @(posedge clk or negedge rst_n)
     begin
            if (!rst_n)
                begin
                data_out <= 0;
                valid <= 'b0;
                end
            else
                begin
                valid <= RD;
            if (WR) begin
                mem[addr] <= data_in;
                valid <= 'b0;
                    end
            if (RD) 
                data_out <= mem[addr]; 
                end
     end
endmodule