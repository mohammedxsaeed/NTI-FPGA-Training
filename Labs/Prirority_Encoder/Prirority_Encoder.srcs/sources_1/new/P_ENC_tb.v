`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2026 09:11:00 PM
// Design Name: 
// Module Name: P_ENC_tb
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


module P_ENC_tb;
reg [3:0] D;
wire [1:0] Y_Z;
wire [1:0] Y_X;

P_ENC_Z test_Z(D,Y_Z);
P_ENC_X test_X(D,Y_X);

    initial begin
        $monitor("Time = %0d | Input D = %b | casez Output = %b | casex Output = %b", $time, D, Y_Z, Y_X);

        #10; D = 4'b000x;  
        #10; D = 4'b000z;  
        #10; D = 4'b000?;  
        #10; D = 4'b10x;  
        #10; D = 4'b01;  
        #10; D = 4'b0x00;  
        #10; D = 4'b0x;  
        #10; D = 4'bxx;  
        #10; D = 4'bx000;  
        #10; D = 4'b1xx0;  
        #10; D = 4'b00?0;  
        #10; D = 4'b001x;  
        #10; D = 4'b01??;  
        #10; D = 4'b0z0;  
        #10; D = 4'b1xxx;  
        #10; D = 4'b1zzz;  
        #10; D = 4'b1???;  
        #10; D = 4'b?000;  
        #10; D = 4'bz0;  
        #10; D = 4'b01xx;  
        #10; D = 4'b0xxx;  

        $stop;
    end


endmodule