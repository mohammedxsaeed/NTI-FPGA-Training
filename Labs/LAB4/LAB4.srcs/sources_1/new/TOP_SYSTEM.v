`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2026 01:23:06 AM
// Design Name: 
// Module Name: TOP_SYSTEM
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

module TOP_SYSTEM(
    input wire clk,
    input wire rst_n,
    
    input wire WR,
    input wire [7:0] addr,
    input wire [19:0] din,

    output wire [7:0] alu_out,
    output wire a_is_zero
);
    wire [19:0] RAM_OUT;
    wire valid;  
    wire RD_from_RAM;        
    
    wire serial_data_out;             
    wire shift_enable;            
    wire [19:0] Parallel_out; 
    
    
    // RAM Instantiation
    
    RAM #( .ADDR_WIDTH(8), .DATA_WIDTH(20) ) 
         RAM_1 (
        .clk(clk),
        .rst_n(rst_n),
        .WR(WR),
        .addr(addr),
        .data_in(din),
        .RD(RD_from_RAM),  
        .data_out(RAM_OUT),    // Output to PISO
        .valid(valid)                   
               );

    //  PISO Instantiation
    
    PISO #(.WIDTH(20) )
     piso_reg (
        .clk(clk),
        .Rst_n(rst_n),
        .parallel_in(RAM_OUT),       // Input from RAM
        .EN_RAM(RD_from_RAM),         
        .serial_out(serial_data_out),       // Output to SIPO
        .valid(shift_enable)            // Output to SIPO shift_en
    );

    // SIPO Instantiation
    
    SIPO #(
        .WIDTH(20)
    ) sipo_reg (
        .clk(clk),
        .rst_n(rst_n),
        .shift_en(shift_enable),        
        .serial_in(serial_data_out),        
        .parallel_out(Parallel_out) // Output to ALU
    );
    //  ALU Instantiation
    ALU #(
        .WIDTH(8)
    ) ALU_Unit (
        .in_a(Parallel_out[15:8]),     
        .in_b(Parallel_out[7:0]),       
        .opcode(Parallel_out[18:16]),  
        .Alu_en(Parallel_out[19]),      
        .Alu_out(alu_out),                  
        .a_is_zero(a_is_zero)         
    );
endmodule


