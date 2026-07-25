`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/25/2026 03:30:35 AM
// Design Name: 
// Module Name: edge_detectors_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Testbench for both Mealy and Moore Edge Detectors
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module edge_detectors_tb;
   reg clk;
   reg rst;
   reg level;
   
   wire tick_mealy;
   wire tick_moore;

   // Test counters
   integer errors = 0;
   integer checks = 0;

   // Instantiate Mealy Edge Detector
   Rising_edge_mealy dut_mealy(
      .clk(clk),
      .rst(rst),
      .level(level),
      .tick_mealy(tick_mealy)
   );

   // Instantiate Moore Edge Detector
   Rising_edge_detector dut_moore(
      .clk(clk),
      .rst(rst),
      .level(level),
      .tick_moore(tick_moore)
   );

   // Clock Generation
   always #5 clk = ~clk;

   task derive_inputs(input in_level);
      begin
         @(negedge clk)
         level = in_level;
      end
   endtask

   // Checking Task for both outputs
   task check_outputs(input exp_mealy, input exp_moore, input [255:0] msg);
      begin
         checks = checks + 1;
         if (tick_mealy !== exp_mealy || tick_moore !== exp_moore) begin
            errors = errors + 1;
            $display("   [FAILED] %0s | Mealy = %b (Exp: %b) | Moore = %b (Exp: %b)", 
                     msg, tick_mealy, exp_mealy, tick_moore, exp_moore);
         end else begin
            $display("   [PASSED] %0s", msg);
         end
      end
   endtask

   initial
   begin
      clk   = 0;
      level = 0;
      rst   = 0;
      
      #20
      rst = 1;
      
      $monitor("Time = %0d | level=%b | tick_mealy=%b | tick_moore=%b", 
               $time, level, tick_mealy, tick_moore);

      $display("\n--- Test 1: Initial state (level=0) ---");
      derive_inputs(0);
      #2; // Wait slightly after negedge to let combinational logic settle
      check_outputs(0, 0, "Both outputs should be 0");

      //  Rising Edge Detection (Short pulse)
      $display("\n--- Test 2: Rising edge (level 0 -> 1) ---");
      derive_inputs(1);
      #2;
      // Mealy reacts immediately to input level, Moore waits for posedge
      check_outputs(1, 0, "Mealy reacts immediately, Moore still 0");
      
      @(posedge clk);
      #2;
      // After posedge, Moore enters EDG state, Mealy enters ONE state
      check_outputs(0, 1, "Moore reacts after posedge, Mealy turns 0");

      // Test Case 3: Falling edge (level 1 -> 0)
      $display("\n--- Test 3: Falling edge (level 1 -> 0) ---");
      derive_inputs(0);
      @(negedge clk)
      check_outputs(0, 0, " Falling edge: outputs should be 0");
      
      @(posedge clk);
      #2;
      check_outputs(0, 0, "After posedge: outputs remain 0");

      // Long press (level=1 for multiple clock cycles)
      $display("\n--- Test 4: Long press (Holding level=1) ---");
      derive_inputs(1);
      #2;
      check_outputs(1, 0, "Mealy detects edge");
      
      @(posedge clk);
      #2;
      check_outputs(0, 1, "Moore detects edge, Mealy off");
      
      @(posedge clk);
      #2;
      check_outputs(0, 0, "Cycle 3: Both outputs must be 0");
      
      @(posedge clk);
      #2;
      check_outputs(0, 0, "Cycle 4: Both outputs remain 0");

      if (errors == 0)
         $display(">>> ALL %0d TESTS PASSED <<<", checks);
      else
         $display(">>> %0d TESTS FAILED OUT OF %0d <<<", errors, checks);
      
      $finish;
   end
endmodule