`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2026 08:14:12 PM
// Design Name: 
// Module Name: FA_Struct
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


module FA_Struct(
    input in1,
    input in2,
    input cin,
    output sum,
    output Cout
    );
    
    FA_1B FA1 (.in1(),.in2(),.Cin(),.sum(),.Cout());
    FA_1B FA2 (.in1(),.in2(),.Cin(),.sum(),.Cout());
    endmodule
