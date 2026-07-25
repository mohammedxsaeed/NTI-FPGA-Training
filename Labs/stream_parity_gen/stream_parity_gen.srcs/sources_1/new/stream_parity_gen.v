`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2026 05:13:00 PM
// Design Name: 
// Module Name: stream_parity_gen
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


module stream_parity_gen(
 input wire clk,
 input wire rst,
 input wire serial_in,
 output reg parity_out
    );
    reg [7:0]stream_in;
   function even_parity_generator;
   input [7:0] bit_stream;
   even_parity_generator = ^ bit_stream [7:0];

    endfunction
    always @(posedge clk)
    begin
    if(rst)
      begin
       parity_out <='b0;
       stream_in <='b0;
      end
      else begin
      stream_in <= {stream_in[6:0], serial_in};
      parity_out <= even_parity_generator({stream_in[6:0], serial_in});
      end
    end
  

endmodule

