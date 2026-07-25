`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/23/2026 05:26:35 PM
// Design Name: 
// Module Name: Counter_TB
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

module Counter_TB();

    // Inputs
    reg clock;
    reg reset;
    reg up;

    // Outputs from the 3 different modules
    wire [1:0] count_behav;
    wire [1:0] count_gate;
    wire [1:0] count_struct;


    // 1. Instantiate Behavioral Module
	
    counter2_behav DUT_behav (
        .clock(clock),
        .reset(reset),
        .up(up),
        .count(count_behav)
    );

    // 2. Instantiate Gate-Level Module
	
    counter_gate_level DUT_gate (
        .clock(clock),
        .reset(reset),
        .up(up),
        .count(count_gate)
    );
	
    // 3. Instantiate Structural Module
    counter2_struct DUT_struct (
        .clock(clock),
        .reset(reset),
        .up(up),
        .count(count_struct)
    );

    // Clock Generation 
    always #5 clock = ~clock;

    function [1:0] expected_count(input [1:0] current_count, input up_down, input rst);
        begin
            if (rst) 
                expected_count = 2'b00;
            else if (up_down) 
                expected_count = current_count + 1;
            else 
                expected_count = current_count - 1;
        end
    endfunction


	task test_display();		
	begin
            @(negedge clock); 
            $display(" Time=%0d | UP=%b | RST=%b || Behavioral=%b | Gate-Level=%b | Structural=%b | Next Count =%b", 
                      $time, up, reset, count_behav, count_gate, count_struct, expected_count(count_behav, up, reset));
            
            // Self-checking mechanism if any module mismatches
            if ((count_behav !== count_gate) || (count_behav !== count_struct)) begin
                $display(" Mismatch ERROR detected across modules at time %0d", $time);
            end
			else 
			$display(" TEST PASSED at Time %0d \n", $time);
			end
	endtask
	
    initial begin
	
        clock = 0;
        reset = 1;
        up = 1;

        #20 reset = 0;  /// all counts must be zero after reset

        // Test Case 1: Counting UP 
        $display("*** Testing UP Counting ***");
        up = 1;
        repeat(5) test_display(); // expected 0 , 1 , 2 , 3 , 0

        // Test Case 2: Counting DOWN
        $display("\n *** Testing DOWN Counting ***");
        up = 0;
        repeat(5) test_display(); // expected 0 , 3  , 2 , 1 ,  0

        // Test Case 3: Asynchronous Reset during counting
        $display("\n *** Testing Asynchronous Reset ***");
        #3 reset = 1; 
        $display("RESET Asserted at Time=%0d", $time);
        #10 reset = 0; // posedge resset 
        $display("[RESET De-asserted at Time=%0d", $time);
        up = 1;
        repeat(2) test_display();
        
        $stop;
    end

endmodule