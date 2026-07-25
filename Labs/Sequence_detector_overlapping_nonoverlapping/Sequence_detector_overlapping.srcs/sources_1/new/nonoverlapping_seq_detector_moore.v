`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Mohammed Saeed Mohammed Ahmed

// Create Date: 07/22/2026 02:06:03 AM
// Design Name: 
// Module Name: nonoverlapping_seq_detector_moore
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

 ////////  # MOORE NON-OVERLAPPING SEQUENCE DETECTOR 
module nonoverlapping_seq_detector_moore(
    input wire clk,
    input wire rst,
    input wire serial_in,
    output reg detect
    );
    localparam 
    S0 =3'b000,
    S1 =3'b001,
    S2 =3'b010,
    S3 =3'b011,
    S4 =3'b100,
    S5 =3'b101,
    S6 =3'b110;
     reg [2:0] present_state, next_state;
	 
   /// State Segment 
   always @(posedge clk, negedge rst)
   begin : State_Segment 
   if(!rst)
   present_state<= S0;
   else
   present_state<=next_state;
   end
   
   // MOORE Segment Compinitional
   
    always @(*)
     begin : Logic_segment
         detect = 0;
         next_state = present_state;
      case(present_state)
      
         S0:
                 case(serial_in)
                   0: next_state=S0;
                   1: next_state=S1;
                  endcase   
         S1:
                 case(serial_in)
                     0: next_state=S0;
                     1: next_state=S2;
                  endcase
         S2:
                 case(serial_in)
                     0: next_state=S3;
                     1: next_state=S2;
                  endcase
         S3:
                 case(serial_in)
                    0: next_state=S0;
                    1: next_state=S4;
                  endcase
         S4:
                 case(serial_in)
                    0: next_state=S5;
                    1: next_state=S2;
                  endcase
         S5:
                 case(serial_in)
                    0: next_state=S0;
                    1: next_state=S6;

                  endcase
		 S6:    begin
					detect = 1;
                 case(serial_in)
                    0: next_state=S0;
                    1: next_state=S1;
                  endcase
				  
						end
				  
    default: next_state=S0;
    endcase
    
                                      end
    
endmodule