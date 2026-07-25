`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/19/2026 10:40:29 PM
// Design Name: 
// Module Name: debouncing_circuit
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


module debouncing_circuit(
    input wire clk,
    input wire rst,
    input wire sw,
    output reg db
    );
    
    reg m_tick; 
    reg [9:0]count;  // after 10000ns = 10us enable m_tick
    reg [2:0] present_state , next_state;
    
    localparam   // 8 States for debouncing Circuit
    one=3'b000,
    wait0_1=3'b001,
    wait0_2=3'b010,
    wait0_3=3'b011,
    wait1_1=3'b100,
    wait1_2=3'b101,
    wait1_3=3'b110,
    zero   =3'b111;
    
    always @(posedge clk, negedge rst) // Counter Segment
    begin: counter
    if (!rst) begin
            count <= 0;
            m_tick <= 0;
            end
    else if(count >= 999)
    begin
    m_tick <= 1;
    count <= 0;
    end
    else 
    begin
    m_tick <= 0;
    count <= count + 1; 
    end
    end
    
    always @(posedge clk , negedge rst)
    begin: state_segment
    if(!rst)
    begin 
    present_state <= zero;
    end
    else 
    present_state <= next_state;
    end
    
    // Moore Segment Compinitional
    always @(*)
    begin : moore_segment
    db=0;
    next_state = present_state;
    
    case(present_state)
    one: // 000
	begin 
	db = 1;
    case(sw)
    1: next_state = one;
    0: next_state = wait0_1;
    endcase
	end
    wait0_1: // 001
    begin
    db = 1;
	
    case(sw)
    1: next_state=one;
	
    0:
	begin
	
	if(!m_tick)
	
		next_state=wait0_1;
	
	else
		next_state=wait0_2;	
	end
	
		endcase
				end
    
    wait0_2:  // 010
    begin
    db = 1;
	
    case(sw)
    1: next_state=one;
	
    0:
	begin
	
	if(!m_tick)
	
		next_state=wait0_2;
	
	else
		next_state=wait0_3;	
	end
	
		endcase
				end   
    wait0_3:  // 011
	  begin
    db = 1;
	
    case(sw)
    1: next_state=one;
	
    0:
	begin
	
	if(!m_tick)
	
		next_state=wait0_3;
	
	else
		next_state=zero;	
	end
	
		endcase
				end
  
    
    zero:     // 111
	begin 
	db = 0;
    case(sw)
    0: next_state = zero;
    1: next_state = wait1_1;
    endcase
	end
	
	wait1_1:  // 110
	begin
    db = 0;
	
    case(sw)
    0: next_state=zero;
	
    1:
	begin
	
	if(!m_tick)
	
		next_state=wait1_1;
	
	else
		next_state=wait1_2;	
	end
	
		endcase
				end
	wait1_2:  // 101
	begin
    db = 0;
	
    case(sw)
    0: next_state=zero;
	
    1:
	begin
	
	if(!m_tick)
	
		next_state=wait1_2;
	
	else
		next_state=wait1_3;	
	end
	
		endcase
				end
	wait1_3:  // 100
	 begin
    db = 0;
	
    case(sw)
    0: next_state=zero;
	
    1:
	begin
	
	if(!m_tick)
	
		next_state=wait1_3;
	
	else
		next_state=one;	
	end
	
		endcase
				end
	
    default: next_state=zero;
    endcase

    end

    
    
endmodule
