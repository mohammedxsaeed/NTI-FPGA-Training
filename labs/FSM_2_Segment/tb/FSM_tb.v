`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/16/2026 10:47:47 PM
// Design Name: 
// Module Name: FSM_tb
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

module FSM_tb;
   reg a;
   reg b;
   reg clk;
   reg reset;
   wire y0;
   wire y1;
    
   localparam [1:0] S0 = 2'b00, S1 = 2'b01, S2 = 2'b10;
   
   wire [1:0] present_state, next_state;

FSM dut(
   .a(a),
  .b(b),
  .clk(clk),
  .reset(reset),
  .y0(y0),
  .y1(y1)
);   

    assign present_state = dut.present_state,
           next_state    = dut.next_state;

// Clock Generation
    always #5 clk=~clk;

    task derive_inputs(input in_a, input in_b);
      begin
       @(negedge clk)
        a=in_a;
        b=in_b;
       end
    endtask


   initial
   begin
   clk =   0;
   a   =   0;
   b   =   0;
   reset = 0;
   
   #20
   reset = 1;
       $monitor("Time = %0d | a=%b  b=%b | Present State: %b | Next State -> %b | y1=%b  y0=%b \n ", 
          $time, a, b, present_state, next_state, y1, y0);

      $display("\n a=0,b=0 ; Expected : Next State is S0  >> present state S0 "); 
   derive_inputs(0,0); // a=0,b=0 Next State is S0 , present state S0
  
     $display("\n a=0,b=1; Expected : Next State is S0 >> present state S0 ");
   derive_inputs(0,1); // a=0,b=1 Next State is still S0 and present state is S0
    
     $display("\n a=1,b=0; Expected : Next State is S1 >> present state S0 ");
   derive_inputs(1,0); // a=1 , b=0 Present State: S0 , Next State: S1
	
     $display("\n a=0,b=1; Expected : Next State is S1 >> present state S1 ");
   derive_inputs(0,1); // a=1 ,b=1 Present State:S1 --> S1
    
	$display("\n a=1,b=1; Expected : Next State is S0 >> present state S1 "); 
   derive_inputs(1,1); // a=1 ,b=1 Present State:S1 --> S0
    
    $display("\n a=1,b=1; Expected : Next State is S2 >> present state S0 ");
   derive_inputs(1,1); // a=1 ,b=1 Present State:S0 --> S2
	  
	$display("\n a=0,b=0; Expected : Next State is S0 >> present state S2 ");
   derive_inputs(0,0); // a=1 ,b=1 Present State:S2 --> S0
	
	#50;
   $finish;
   end
endmodule