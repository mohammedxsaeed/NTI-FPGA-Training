`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 03:34:58 PM
// Design Name: 
// Module Name: next_state_D
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


module next_state_D(
    input  [1:0] current_count,
    input  control_in,
    output   [1:0] D
    );
    
    assign D[0] = ~ current_count[0] ,  //  not Q0 
           D[1] = ~( current_count[0] ^ current_count[1] ^ control_in  );  // ~( Q[0] ^ Q[1] ^ UP  ) 
endmodule
