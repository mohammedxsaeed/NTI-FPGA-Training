module SIPO_ALU #(parameter WIDTH=20,parameter WIDTH_ALU = 8)( 
    input wire [WIDTH_ALU-1:0] in_a,
    input wire [WIDTH_ALU-1:0] in_b,
    input wire [2:0] opcode,
    input wire Alu_en,
    output reg [WIDTH_ALU-1:0] Alu_out,
    output reg a_is_zero,
    input wire clk,
    input wire rst_n,
    input wire shift_en,
    input wire serial_in,
    output reg [WIDTH-1:0] parallel_out
);

always @(posedge clk , negedge rst_n)
    begin
    if(!rst_n)
    parallel_out <= 0;
    else if(shift_en)
    parallel_out <= {parallel_out<<1,serial_in};
    else 
    parallel_out <= serial_in;
    end
    assign in_a=parallel_out[15:8];
    assign in_b=parallel_out[7:0];
    assign opcode=parallel_out[18:16];
    assign Alu_en=parallel_out[19];
    always @(*) begin
    a_is_zero = (in_a == 0);

        if (!Alu_en) begin
            Alu_out = 0;
        end else begin
            case (opcode)
                3'b000: Alu_out = in_a + in_b;      // ADD
                3'b001: Alu_out = in_a - in_b;      // SUB
                3'b010: Alu_out = in_a & in_b;      // AND
                3'b011: Alu_out = in_a ^ in_b;      // XOR
                3'b100: Alu_out = in_a | in_b;      // OR
                3'b101: Alu_out = in_a;             // in A is output
                default: Alu_out = 0;   
            endcase
        end
    end

endmodule