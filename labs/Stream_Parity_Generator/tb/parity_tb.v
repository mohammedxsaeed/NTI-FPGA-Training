`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2026 07:20:48 PM
// Design Name: 
// Module Name: parity_tb
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


module stream_parity_gen_tb;
    reg clk;
    reg rst;
    reg serial_in;
    wire parity_out;
    stream_parity_gen even_parity (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .parity_out(parity_out)
    );

    always #5 clk = ~clk;
    
    initial begin
        clk = 0;
        rst = 1;
        serial_in = 0;
        
        $monitor("Time = %0d | serial_in = %b | Internal stream_in = %b | parity_out = %b", $time, serial_in, even_parity.stream_in, parity_out);
        #10;
        rst = 0;
        @(posedge clk) serial_in = 1'b0;
        @(posedge clk) serial_in = 1'b0;
        @(posedge clk) serial_in = 1'b1;
        @(posedge clk) serial_in = 1'b0;
        @(posedge clk) serial_in = 1'b1;
        @(posedge clk) serial_in = 1'b1;
        @(posedge clk) serial_in = 1'b0;
        @(posedge clk) serial_in = 1'b1; 
        @(posedge clk) serial_in = 1'b1;
        @(posedge clk) serial_in = 1'b0;
        #30;
        $finish;
    end

endmodule