`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/15/2026 10:36:05 PM
// Design Name: 
// Module Name: even_parity_generate
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

module stream_parity_Generator_Channel#(parameter WIDTH=8)(
 input wire clk,
 input wire rst,
 input wire serial_in,
 output reg parity_out
    );
    wire [WIDTH-1:0]stream_in;
    
    // Register Instantiation 
    genvar i; 
    generate 
    for(i=0;i<WIDTH;i=i+1)
    begin: Shift_Register
    if(!i)
    begin
    register my_reg0 (.data_in(serial_in),
    .clk(clk),
    .rst(rst),
    .data_out(stream_in[0])); 
    end
    else 
     begin
    register my_regi (.data_in(stream_in[i-1]),
    .clk(clk),
    .rst(rst),
    .data_out(stream_in[i])); 
    end
    end
    endgenerate
   function even_parity_generator;
   input [WIDTH-1:0] bit_stream;
   even_parity_generator = ^ bit_stream [WIDTH-1:0];
    endfunction
    
    always @(posedge clk)
    begin
    if(rst)
      begin
       parity_out <='b0;
      end
      else begin
      parity_out <= even_parity_generator(stream_in[WIDTH-1:0]);
      end
    end

endmodule

// Register Module instead of Using reg
module register( 
    input wire data_in,
    input wire clk,
    input wire rst,
    output reg data_out
     );

  always @(posedge clk) 
    begin: register
  if(rst) 
   data_out <='b0;
   else 
   data_out <= data_in;
    end    
 

endmodule

// using Generate Blcok To Get 8 Channels of Stream parity Generator 
module even_parity_generate#(parameter WIDTH=8)(
 input wire clk,
 input wire rst,
 input wire [WIDTH-1:0]serial_in,
 output wire [WIDTH-1:0]parity_out
    );
    genvar i;
    generate 
    for(i=0;i<WIDTH;i=i+1)
    begin : Channels_Stream
    stream_parity_Generator_Channel#(.WIDTH(WIDTH)) dynamic_stream (.clk(clk), .rst(rst),.serial_in(serial_in[i]),.parity_out(parity_out[i]));
    end
    endgenerate
    endmodule