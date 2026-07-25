`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/13/2026 04:27:18 PM
// Design Name: 
// Module Name: controller
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


module controller(
  input wire  [2:0]opcode,
  input wire  [2:0]phase,  
  input wire       zero,   // accumulator is zero
  output reg       sel,    // select instruction address to memory
  output reg       rd ,    // enable memory output onto data bus
  output reg       ld_ir,  // load instruction register
  output reg       inc_pc, // increment program counter
  output reg       halt,   // halt machine
  output reg       ld_pc,  // load program counter
  output reg       data_e, // enable accumulator output onto data bus
  output reg       ld_ac,  // load accumulator from data bus
  output reg       wr      // write data bus to memory
    );
   localparam  HLT=0, SKZ=1, ADD=2, AND=3, XOR=4, LDA=5, STO=6, JMP=7; 
   wire ALUOP =(opcode==ADD || opcode==AND || opcode==XOR || opcode==LDA );
   localparam 
   INST_ADDR=0, // Phases from 0 to 7
   INST_FETCH=1,
   INST_LOAD =2,
   IDLE=3,
   OP_ADDR =4,
   OP_FETCH =5,
   ALU_OP=6,
   STORE =7;
    always @*
    begin 
    // Default case of all output lines
  sel =0;
  rd =0; 
  ld_ir =0; 
  inc_pc =0;
  halt   =0; 
  ld_pc  =0; 
  data_e =0;
  ld_ac =0; 
  wr =0; 
   
    case(phase)
    INST_ADDR: // Phase 0
     sel =1;
     
    INST_FETCH: // Phase 1
    begin 
    sel =1;
    rd=1;
    end
    
    INST_LOAD: // Phase 2
    begin 
    sel =1;
    rd =1; 
    ld_ir =1; 
    end
    
    IDLE: // Phase 3
    begin 
    sel =1;
    rd =1; 
    ld_ir =1; 
    end
    
    OP_ADDR: // Phase 4
    begin 
    inc_pc =1;
    halt  =(opcode==HLT);
    end
    
    OP_FETCH: // Phase 5
    rd = ALUOP;
    
    ALU_OP: // Phase 6
    begin
    rd = ALUOP;
    inc_pc =( (opcode==SKZ) && zero );
    ld_pc  =(opcode==JMP); 
    data_e =(opcode==STO);
    end 
    
    STORE: // Phase 7
    begin 
    rd    = ALUOP;
    ld_ac = ALUOP; 
    data_e =(opcode==STO);
    ld_pc = (opcode==JMP); 
    wr    = (opcode==STO); 
    end
    
    endcase
    end
endmodule
                