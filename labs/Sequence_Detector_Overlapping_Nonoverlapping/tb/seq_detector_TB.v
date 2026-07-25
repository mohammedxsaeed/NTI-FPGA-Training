`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/22/2026 02:23:19 AM
// Design Name: 
// Module Name: seq_detector_TB
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

///// Testing All modules
 /* 
    S0 =3'b000,
    S1 =3'b001,
    S2 =3'b010,
    S3 =3'b011,
    S4 =3'b100,
    S5 =3'b101;
    S6 =3'b110;
    */
module seq_detector_TB();

    // Inputs
    reg clk;
    reg rst;
    reg serial_in;

    // Outputs
    wire detect_mealy_over;
    wire detect_mealy_non;
    wire detect_moore_over;
    wire detect_moore_non;

    // Instantiation of the 4 Sequence Detectors
    overlapping_seq_detector_mealy mealy_over (
        .clk(clk), .rst(rst), .serial_in(serial_in), .detect(detect_mealy_over)
    );

    non_overlapping_seq_detector_mealy mealy_non (
        .clk(clk), .rst(rst), .serial_in(serial_in), .detect(detect_mealy_non)
    );

    overlapping_seq_detector_moore moore_over (
        .clk(clk), .rst(rst), .serial_in(serial_in), .detect(detect_moore_over)
    );

    nonoverlapping_seq_detector_moore moore_non (
        .clk(clk), .rst(rst), .serial_in(serial_in), .detect(detect_moore_non)
    );

    // Clock Generation (Period = 10 ns)
    
    always #5 clk = ~clk;

    task send_bit(input in); // Send individual bits
        begin
            @(negedge clk);
            serial_in = in;
                    end
    endtask    
    
  /*  task send_stream(input reg [19:0] stream_in); // Sending Stream of Data
        begin : PISO_Stream
        integer i;
        for(i=19;i>=0; i =i-1)
        begin
                       @(negedge clk);
            serial_in = stream_in [i];

        end
        end
    endtask
*/
    initial begin
    
        clk = 0;
        serial_in = 0;
        rst = 0;
        #20;
        rst = 1;
        
        @(negedge clk);
        
        $monitor("Time=%0d | Serial in=%b  | Mealy_Over=%b | Moore_Over=%b | Mealy_Non=%b | Moore_Non=%b", 
                  $time, serial_in, detect_mealy_over, detect_moore_over, detect_mealy_non, detect_moore_non);
                  
        // 1. Normal Detection Test (110101) by Sending bit by bit
        $display("1. DETECTION TEST \n");
        send_bit(1); send_bit(1); send_bit(0); send_bit(1); send_bit(0); send_bit(1);
        // At this point, Mealy detects it immediately. Moore detects it on the next state.
        
        @(posedge clk); // mealy
        case(detect_mealy_over)
        1: $display("Detection Success , Overlapping detector With mealy PASSED \n");
        0: $display("Detection Failed , Overlapping detector With mealy Failed \n");
        endcase
              
        case(detect_mealy_non)
        1: $display("Detection Success , Non-Overlapping detector With mealy PASSED \n");
        0: $display("Detection Failed , Non-Overlapping detector With mealy Failed \n");
        endcase
        
        @(negedge clk); // delay for Moore
        case(detect_moore_over)
        1: $display("Detection Success , Overlapping detector With Moore PASSED \n ");
        0: $display("Detection Failed , Overlapping detector With Moore Failed \n ");
        endcase

        case(detect_moore_non)
        1: $display("Detection Success , Non-Overlapping detector With Moore PASSED \n");
        0: $display("Detection Failed , Non-Overlapping detector With Moore Failed \n");
        endcase
        ///////////////////////////////////////////////////
        
        // Testing Overalapping Detection
           $display("2. Overlapping DETECTION TEST \n");
        send_bit(1); send_bit(0); send_bit(1); send_bit(0); send_bit(1); // 1 old with 10101   
        // Overlap modules should trigger again. Non-overlap should NOT trigger.
        case(detect_mealy_non)
        1: $display("Detection Success , Non-Overlapping detector With mealy Failed \n");
        0: $display("Detection Failed , Non-Overlapping detector With mealy PASSED \n");
        endcase
        
        
        case(detect_moore_non)
        1: $display("Detection Success , Non-Overlapping detector With Moore Failed \n");
        0: $display("Detection Failed , Non-Overlapping detector With Moore PASSED \n");
        endcase
        
                @(posedge clk); /// Delay to catch mealy output
        case(detect_mealy_over)
        1: $display("Detection Success , Overlapping detector With mealy PASSED \n");
        0: $display("Detection Failed , Overlapping detector With mealy Failed \n");
        endcase
        

                @(negedge clk); // Moore dealy for stability
        case(detect_moore_over)
        1: $display("Detection Success , Overlapping detector With Moore PASSED \n ");
        0: $display("Detection Failed , Overlapping detector With Moore Failed \n");
        endcase

        rst = 0;
        #15;
        rst = 1; 
        #15;
////////////////////////////////////////////////////////////////////////
        $display(" Corner Case Test of S4 to S2");
        send_bit(1); send_bit(1); send_bit(0); send_bit(1);  send_bit(1);// 1101    
          // 11011 expected present state at S4 (100) then go to next state S2 (010)
                  $display("---Present state_mealy_over: %b >> Next State_mealy_over: %b | Present state_mealy_nonover: %b >> Next State_mealy_nonover: %b | Present state_moore_over: %b >> Next State_moore_over: %b  | Present state_moore_nonover: %b >> Next State_moore_nonover: %b----", 
                   mealy_over.present_state, mealy_over.next_state,  mealy_non.present_state, mealy_non.next_state, moore_over.present_state,moore_over.next_state,moore_non.present_state,moore_non.next_state);
                   
          rst = 0;
          #15;
          rst = 1; 
          #15;

        // 5. THE MEALY GLITCH TEST (Asynchronous input change)
        $display("\n Mealy Glitch / Asynchronous Dependence");
        // Send exactly 11010 to reach S5 in Mealy and S5 in Moore
        send_bit(1); send_bit(1); send_bit(0); send_bit(1); send_bit(0);
        $display("---Present state_mealy_over: %b >> Next State_mealy_over: %b | Present state_mealy_nonover: %b >> Next State_mealy_nonover: %b | Present state_moore_over: %b >> Next State_moore_over: %b  | Present state_moore_nonover: %b >> Next State_moore_nonover: %b----", 
                   mealy_over.present_state, mealy_over.next_state,  mealy_non.present_state, mealy_non.next_state, moore_over.present_state,moore_over.next_state,moore_non.present_state,moore_non.next_state);
        @(posedge clk)
        #2;           // Wait a little bit after the edge
        $display("--- Mealy Glitch is High at S5 before clk cycle complete --- ");
        serial_in = 1; // Mealy output will be HIGH immediately here (Glitch)
        $display("---Present state_mealy_over: %b >> Next State_mealy_over: %b | Present state_mealy_nonover: %b >> Next State_mealy_nonover: %b | Present state_moore_over: %b >> Next State_moore_over: %b  | Present state_moore_nonover: %b >> Next State_moore_nonover: %b----", 
                   mealy_over.present_state, mealy_over.next_state,  mealy_non.present_state, mealy_non.next_state, moore_over.present_state,moore_over.next_state,moore_non.present_state,moore_non.next_state);
        #4;       
        serial_in = 0; // Return to 0 before the clock edge hits. Mealy drops back to LOW.
         $display("---Present state_mealy_over: %b >> Next State_mealy_over: %b | Present state_mealy_nonover: %b >> Next State_mealy_nonover: %b | Present state_moore_over: %b >> Next State_moore_over: %b  | Present state_moore_nonover: %b >> Next State_moore_nonover: %b----", 
                   mealy_over.present_state, mealy_over.next_state,  mealy_non.present_state, mealy_non.next_state, moore_over.present_state,moore_over.next_state,moore_non.present_state,moore_non.next_state);
        #4;    // complete clk time 10ns    

        #30;
        $stop;
    end
   
endmodule