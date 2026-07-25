`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/25/2026 03:07:15 AM
// Design Name: 
// Module Name: debouncing_circuit_tb
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

module debouncing_circuit_tb;
   reg clk;
   reg rst;
   reg sw;
   wire db;
   
   wire m_tick;

   // Test counters
   integer errors = 0;
   integer checks = 0;

debouncing_circuit dut(
  .clk(clk),
  .rst(rst),
  .sw(sw),
  .db(db)
);   

    assign m_tick = dut.m_tick;

// Clock Generation
    always #5 clk=~clk;

    task derive_inputs(input in_sw);
      begin
       @(negedge clk)
        sw=in_sw;
       end
    endtask

    // Checking Task
    task check_db(input expected_db);
      begin
        checks = checks + 1;
        if (db !== expected_db) begin
            errors = errors + 1;
            $display("   [FAILED] db = %b | Expected = %b", db, expected_db);
        end else begin
            $display("   [PASSED] db = %b", db);
        end
      end
    endtask

   initial
   begin
   clk =   0;
   sw  =   0;
   rst =   0;
   
   #20
   rst = 1;
       $monitor("Time = %0d | sw=%b | m_tick=%b | Output db -> %b \n ", 
          $time, sw, m_tick, db);

      $display("\n sw=1 ; Expected : Output db is 1 after settling >> present db 0 "); 
   derive_inputs(1); 
   #40000; // Wait for debounce cycles
   check_db(1);
  
     $display("\n sw=0 (bouncy release); Expected : Output db is 0 >> present db 1 ");
   derive_inputs(0); 
   #20;
   derive_inputs(1);
   #20;
   derive_inputs(0);
   #20;
   derive_inputs(1);
   #20;
   derive_inputs(0);
   #40000; // <--- تم التعديل هنا: لازم نستنى نفس الوقت عشان الـ Release يحصل
   check_db(0);
    
     $display("\n sw=1 (short glitch); Expected : Output db is 0 >> present db 0 ");
   derive_inputs(1); 
   #100;
   derive_inputs(0);
   #40000; // <--- تم التعديل هنا: عشان نضمن إن الدايرة رجعت لحالة الصفر تماماً
   check_db(0);
	
     $display("\n sw=1 (clean press); Expected : Output db is 1 >> present db 0 ");
   derive_inputs(1); 
   #40000;
   check_db(1);
    
	$display("\n Async reset mid-transition; Expected : Output db is 0 >> present db 1 "); 
   #2 rst = 0;
   #2; // Wait slightly for async reset to propagate
   check_db(0);
   #20 rst = 1;
	
	#50;
   
   // Final Results
   if (errors == 0)
       $display(">>> FINAL RESULT: ALL %0d TESTS PASSED <<<", checks);
   else
       $display(">>> FINAL RESULT: %0d TESTS FAILED OUT OF %0d <<<", errors, checks);
   
   $finish;
   end
endmodule