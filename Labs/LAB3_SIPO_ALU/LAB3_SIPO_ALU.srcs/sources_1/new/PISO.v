`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/09/2026 07:44:35 PM
// Design Name: 
// Module Name: PISO
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


module PISO #(parameter WIDTH=20)(
    input  wire clk,
    input  wire Rst_n,
    input  wire [WIDTH-1:0] parallel_in,
    output wire serial_out,
    output reg  valid,
    output reg EN_RAM
    );
    reg [WIDTH-1:0] shift_reg ;
    reg [4:0] count; // For 20 Clock cycle
    assign serial_out = shift_reg[WIDTH-1]; // MSB First
    always @(posedge clk or negedge Rst_n)
    begin
    if(!Rst_n) 
        begin
         shift_reg <= 0;
         count     <= 0;
         EN_RAM    <= 0;
         valid     <= 0;
        end 
     else 
        begin
            if (!count) // when COUNT at 0
              begin 
                EN_RAM <= 1; //After reset, PISO issues en = 1 to fetch the Data.
                valid  <= 0;
                count  <= count + 1;
              end 
            else if (count == 1) 
            begin
                EN_RAM    <= 0;
                count     <= count + 1;
            end 
           else if (count == 2) begin
                shift_reg[WIDTH-1:0] <= parallel_in[WIDTH-1:0];
                valid     <= 1;
                count     <= count + 1;
            end 
            else if (count >= 3 && count <= WIDTH+1) 
            begin
                valid     <= 1;
                shift_reg <= {shift_reg[WIDTH-2:0], 1'b0};
                count     <= count + 1;
            end 
            else begin
                valid <= 0;
                count <= 0;
            end
        end
    end
endmodule
        