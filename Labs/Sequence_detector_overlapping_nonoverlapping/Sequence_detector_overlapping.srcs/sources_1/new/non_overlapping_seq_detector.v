`timescale 1ns / 1ps
 ////////  # MEALY NON-OVERLAPPING SEQUENCE DETECTOR 
 module non_overlapping_seq_detector_mealy(
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
    S5 =3'b101;
     reg [2:0] present_state, next_state;
	 
   /// State Segment 
   always @(posedge clk, negedge rst)
   begin : State_Segment 
   if(!rst)
   present_state<= S0;
   else
   present_state<=next_state;
   end
   
   // Mealy Segment Compinitional
   
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
                    1: begin 
                       next_state=S0;
                       detect = 1;
                    end
                  endcase
    default: next_state=S0;
    endcase
    
                                      end
    
endmodule
