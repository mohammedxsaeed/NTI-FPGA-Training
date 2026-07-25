`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/06/2026 09:42:00 PM
// Design Name: 
// Module Name: Full_Adder
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

//// Gate-Level 
module Full_Adder(
    input A,
    input B,
    input Cin,
    output Sum ,Cout
    );
    wire S1,S2,W1,W2;
    xor (S1,A,B);        //A^B
    xor S (sum,S1,Cin);  //A^B^Cin
    and (W1,A,B);        //(A&B)
    and (W2,S1,Cin);    //( A ^ B)& Cin
    or Carry (Cout,W1,W2);
    
endmodule
