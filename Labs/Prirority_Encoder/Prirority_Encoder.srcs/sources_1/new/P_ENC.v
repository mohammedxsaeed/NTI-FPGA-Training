`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2026 09:11:00 PM
// Design Name: 
// Module Name: P_ENC
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


module P_ENC_X(
    input wire [3:0] D,
    output reg [1:0] Y
    );
    // D0 D1 D2 D3   Y1  Y0
    // 1  0   0 0     0  0
    // x  1  0 0      0  1
    // x  x  1 0      1  0
    // x  x  x 1      1  1
    
    always@*
    begin
    casex(D)
    4'b1xxx: Y='b11;
    4'b01xx: Y='b10;
    4'b001x: Y='b01;
    4'b0001: Y='b00;
    4'b0000: Y='bxx;
    default: Y='bxx;
    endcase
    end
    
endmodule

