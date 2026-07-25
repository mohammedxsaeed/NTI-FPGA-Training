`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2026 05:14:03 PM
// Design Name: 
// Module Name: Counter_up_down
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


module counter2_behav ( 
input wire clock,    
input wire reset,   // asynchronous, active-high 
input wire up,     // 1 = count up, 0 = count down 
output reg [1:0] count 
); 


always @(posedge clock , posedge reset)
begin
if(reset)
count <=0;
else 
    begin
        if(up)
        count <= count + 1;
        
        else
        count <= count - 1;
         end
end

endmodule