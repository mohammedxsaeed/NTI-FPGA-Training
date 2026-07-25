`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/25/2026 04:15:20 AM
// Design Name: 
// Module Name: control_path_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Integrated Testbench for Control Unit and ALU Control
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module control_path_tb;
    
    reg clk;
    
    // Inputs to Control Path
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg funct7_5;
    
    // Outputs from Control Unit
    wire RegWrite;
    wire MemWrite;
    wire MemRead;
    wire MemtoReg;
    wire ALUSrc;
    wire Branch;
    wire Jump;
    wire [1:0] ALUOp;
    
    // Output from ALU Control
    wire [3:0] alu_ctrl;

    // Test counters
    integer errors = 0;
    integer checks = 0;

    // Instantiate Control Unit
    Control_unit dut_cu (
        .opcode(opcode),
        .RegWrite(RegWrite),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUSrc(ALUSrc),
        .Branch(Branch),
        .Jump(Jump),
        .ALUOp(ALUOp)
    );

    // Instantiate ALU Control
    ALU_control dut_alu_ctrl (
        .ALUOp(ALUOp), // Connected directly from Control Unit
        .funct3(funct3),
        .funct7_5(funct7_5),
        .alu_ctrl(alu_ctrl)
    );

    // Clock Generation 
    always #5 clk = ~clk;

    // Task to drive instruction fields
    task derive_inputs(input [6:0] in_op, input [2:0] in_f3, input in_f7);
        begin
            @(negedge clk)
            opcode   = in_op;
            funct3   = in_f3;
            funct7_5 = in_f7;
        end
    endtask

    // Task to check all control signals
    task check_outputs(
        input exp_RegWrite, input exp_MemWrite, input exp_MemRead,
        input exp_MemtoReg, input exp_ALUSrc, input exp_Branch, input exp_Jump,
        input [1:0] exp_ALUOp, input [3:0] exp_alu_ctrl, input [255:0] msg);
        begin
            checks = checks + 1;
            if (RegWrite !== exp_RegWrite || MemWrite !== exp_MemWrite || 
                MemRead !== exp_MemRead || MemtoReg !== exp_MemtoReg || 
                ALUSrc !== exp_ALUSrc || Branch !== exp_Branch || 
                Jump !== exp_Jump || ALUOp !== exp_ALUOp || alu_ctrl !== exp_alu_ctrl) 
            begin
                errors = errors + 1;
                $display("   [FAILED] %0s", msg);
                $display("      Expected: RW=%b MW=%b MR=%b MtR=%b ASrc=%b Br=%b Jmp=%b ALUOp=%b ALU_Ctrl=%b",
                         exp_RegWrite, exp_MemWrite, exp_MemRead, exp_MemtoReg, exp_ALUSrc, exp_Branch, exp_Jump, exp_ALUOp, exp_alu_ctrl);
                $display("      Got     : RW=%b MW=%b MR=%b MtR=%b ASrc=%b Br=%b Jmp=%b ALUOp=%b ALU_Ctrl=%b",
                         RegWrite, MemWrite, MemRead, MemtoReg, ALUSrc, Branch, Jump, ALUOp, alu_ctrl);
            end else begin
                $display("   [PASSED] %0s", msg);
            end
        end
    endtask

    initial begin
        clk      = 0;
        opcode   = 7'b0000000;
        funct3   = 3'b000;
        funct7_5 = 0;
        
        #20;

        $display("\n--- Test 1: R-Type (ADD) ---");
        // opcode = 0110011, funct3 = 000, funct7_5 = 0
        derive_inputs(7'b0110011, 3'b000, 1'b0);
        #2;
        // Exp: RW=1, MW=0, MR=0, MtR=0, ASrc=0, Br=0, Jmp=0, ALUOp=10, alu_ctrl=0000 (ADD)
        check_outputs(1, 0, 0, 0, 0, 0, 0, 2'b10, 4'b0000, "R-Type ADD Control Signals");

        $display("\n--- Test 2: R-Type (SUB) ---");
        // opcode = 0110011, funct3 = 000, funct7_5 = 1
        derive_inputs(7'b0110011, 3'b000, 1'b1);
        #2;
        // Exp: RW=1, MW=0, MR=0, MtR=0, ASrc=0, Br=0, Jmp=0, ALUOp=10, alu_ctrl=0001 (SUB)
        check_outputs(1, 0, 0, 0, 0, 0, 0, 2'b10, 4'b0001, "R-Type SUB Control Signals");

        $display("\n--- Test 3: I-Type (ADDI) ---");
        // opcode = 0010011, funct3 = 000, funct7_5 = 0
        derive_inputs(7'b0010011, 3'b000, 1'b0);
        #2;
        // Exp: RW=1, MW=0, MR=0, MtR=0, ASrc=1, Br=0, Jmp=0, ALUOp=00, alu_ctrl=0000 (ADD)
        check_outputs(1, 0, 0, 0, 1, 0, 0, 2'b00, 4'b0000, "I-Type ADDI Control Signals");

        $display("\n--- Test 4: Load (LW) ---");
        // opcode = 0000011, funct3 = 010 (LW), funct7_5 = 0
        derive_inputs(7'b0000011, 3'b010, 1'b0);
        #2;
        // Exp: RW=1, MW=0, MR=1, MtR=1, ASrc=1, Br=0, Jmp=0, ALUOp=00, alu_ctrl=0000 (ADD)
        check_outputs(1, 0, 1, 1, 1, 0, 0, 2'b00, 4'b0000, "Load (LW) Control Signals");

        $display("\n--- Test 5: Store (SW) ---");
        // opcode = 0100011, funct3 = 010 (SW), funct7_5 = 0
        derive_inputs(7'b0100011, 3'b010, 1'b0);
        #2;
        // Exp: RW=0, MW=1, MR=0, MtR=0, ASrc=1, Br=0, Jmp=0, ALUOp=00, alu_ctrl=0000 (ADD)
        check_outputs(0, 1, 0, 0, 1, 0, 0, 2'b00, 4'b0000, "Store (SW) Control Signals");

        $display("\n--- Test 6: Branch (BEQ) ---");
        // opcode = 1100011, funct3 = 000 (BEQ), funct7_5 = 0
        derive_inputs(7'b1100011, 3'b000, 1'b0);
        #2;
        // Exp: RW=0, MW=0, MR=0, MtR=0, ASrc=0, Br=1, Jmp=0, ALUOp=01, alu_ctrl=0001 (SUB)
        check_outputs(0, 0, 0, 0, 0, 1, 0, 2'b01, 4'b0001, "Branch (BEQ) Control Signals");

        $display("\n--- Test 7: LUI ---");
        // opcode = 0110111, funct3 = X, funct7_5 = X
        derive_inputs(7'b0110111, 3'b111, 1'b1);
        #2;
        // Exp: RW=1, MW=0, MR=0, MtR=0, ASrc=1, Br=0, Jmp=0, ALUOp=11, alu_ctrl=1111 (PASS_b)
        check_outputs(1, 0, 0, 0, 1, 0, 0, 2'b11, 4'b1111, "LUI Control Signals");

        $display("\n--- Test 8: JAL ---");
        // opcode = 1101111, funct3 = X, funct7_5 = X
        derive_inputs(7'b1101111, 3'b000, 1'b0);
        #2;
        // Exp: RW=1, MW=0, MR=0, MtR=0, ASrc=1, Br=0, Jmp=1, ALUOp=00, alu_ctrl=0000 (ADD)
        check_outputs(1, 0, 0, 0, 1, 0, 1, 2'b00, 4'b0000, "JAL Control Signals");

        if (errors == 0)
            $display(">>> ALL %0d TESTS PASSED <<<", checks);
        else
            $display(">>> %0d TESTS FAILED OUT OF %0d <<<", errors, checks);
        
        $finish;
    end
endmodule