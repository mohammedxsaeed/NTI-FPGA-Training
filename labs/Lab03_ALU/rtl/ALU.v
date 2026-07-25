`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2026 10:48:21 PM
// Design Name: 
// Module Name: ALU
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


 module ALU #(parameter WIDTH = 8) (
    input wire [WIDTH-1:0] in_a,
    input wire [WIDTH-1:0] in_b,
    input wire [2:0] opcode,
    input wire Alu_en,
    output reg [WIDTH-1:0] Alu_out,
    output reg a_is_zero
);
    
    always @(*) begin
    a_is_zero = (in_a == 0);

        if (!Alu_en) begin
            Alu_out = 0;
        end else begin
            case (opcode)
                3'b000: Alu_out = in_a ;     
                3'b001: Alu_out = in_a ;      
                3'b010: Alu_out = in_a + in_b;     
                3'b011: Alu_out = in_a & in_b;      
                3'b100: Alu_out = in_a ^ in_b;      
                3'b101: Alu_out = in_b;     
                3'b110: Alu_out = in_a;             
                3'b111: Alu_out = in_a;             
                default: Alu_out = 0;   
            endcase
        end
    end

endmodule