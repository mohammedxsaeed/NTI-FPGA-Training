`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/14/2026 07:20:48 PM
// Design Name: 
// Module Name: stream_parity_gen_tb
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

module stream_parity_gen_tb #(parameter WIDTH=8);
    reg clk;
    reg rst;
    reg serial_in;
    wire parity_out;
    
    // Test counters and variables
    integer errors = 0;
    integer checks = 0;
    integer i;
    integer j;
    reg [WIDTH-1:0] stream = 0;
    reg expected_parity;

    stream_parity_gen dut (
        .clk(clk),
        .rst(rst),
        .serial_in(serial_in),
        .parity_out(parity_out)
    );

    always #5 clk = ~clk;
            
    initial begin
        clk = 0;
        rst = 1;
        serial_in = 1'b0;
        
        #20;
        rst = 0;
  $monitor("Time = %0d | serial_in = %b | Internal stream_in = %b | parity_out = %b", $time, serial_in, stream, parity_out);
        for (i = 0; i < 256; i = i + 1) begin : Check_All_values
            
            stream = i;
            expected_parity = ^stream; // Calculates expected Even Parity using XOR reduction
            
            // Drive the 8 bits serially
            for (j = 7; j >= 0; j = j - 1) begin
                @(negedge clk);
                serial_in = stream[j];
            end        
            
            // Wait for the 8th bit to be processed
            @(posedge clk);
            #2; 
            
            // Self-checking logic
            checks = checks + 1;
            if (parity_out !== expected_parity) begin
                errors = errors + 1;
                $display("   [FAILED] Stream = %b | Got Parity = %b | Expected = %b", 
                         stream, parity_out, expected_parity);
            end
            
            // Reset for the next sequence
            @(negedge clk);
            rst = 1;
            serial_in = 1'b0; 
            @(negedge clk);
            rst = 0;

        end

        // Final Results
        if (errors == 0)
            $display(">>>  ALL %0d TESTS PASSED <<<", checks);
        else
            $display(">>>%0d TESTS FAILED OUT OF %0d <<<", errors, checks);

        #20;
        $finish;
    end

endmodule