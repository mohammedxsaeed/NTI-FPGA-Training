`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2026 05:26:56 PM
// Design Name: 
// Module Name: FA_1B
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

// Behavioral Design

module  FA_1B (
 input wire in1,
 input wire in2,
 input wire Cin,
 output sum,
 output Cout
    );
assign {Cout,sum}=in1+in2+Cin;

endmodule

/*  OR
module Full_Adder(

    input A,

    input B,

    input Cin,

    output  reg Sum ,Cout

    );

    always @(*)

    begin

     Sum <= A^B^Cin;

     Cout<= (A&B)|( A ^ B)& Cin;

    end
    
    */
