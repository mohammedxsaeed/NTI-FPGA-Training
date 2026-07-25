`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/25/2026 05:45:00 AM
// Design Name: 
// Module Name: TOP_SYSTEM_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Integrated Testbench for TOP_SYSTEM
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module TOP_SYSTEM_tb;
    reg clk;
    reg rst_n;
    reg WR;
    reg [7:0] addr;
    reg [19:0] din;

    wire [7:0] alu_out;
    wire a_is_zero;

    // Test counters
    integer errors = 0;
    integer checks = 0;

    // Instantiate TOP_SYSTEM
    TOP_SYSTEM dut (
        .clk(clk),
        .rst_n(rst_n),
        .WR(WR),
        .addr(addr),
        .din(din),
        .alu_out(alu_out),
        .a_is_zero(a_is_zero)
    );

    // Clock Generation 
    always #5 clk = ~clk;

    // Task to write data to RAM
    task write_to_ram(input [7:0] w_addr, input [19:0] w_data);
        begin
            @(negedge clk);
            WR = 1;
            addr = w_addr;
            din = w_data;
            @(negedge clk);
            WR = 0;
        end
    endtask

    // Task to check ALU outputs (Synchronized with PISO loop)
    task check_alu(input [7:0] exp_alu, input exp_zero, input [255:0] msg);
        begin
             @(negedge dut.shift_enable);
             @(negedge dut.shift_enable);
            
            #2; 
            
            checks = checks + 1;
            if (alu_out !== exp_alu || a_is_zero !== exp_zero) begin
                errors = errors + 1;
                $display("   [FAILED] %0s | alu_out=%d (Exp:%d) | zero=%b (Exp:%b)", 
                         msg, alu_out, exp_alu, a_is_zero, exp_zero);
            end else begin
                $display("   [PASSED] %0s | alu_out=%d", msg, alu_out);
            end
        end
    endtask

    initial begin
        // Initialize Inputs
        clk = 0;
        rst_n = 0; 
        WR = 0;
        addr = 0;
        din = 0;

        // Apply Reset
        #20;
        rst_n = 1;

        // ---------------------------------------------------------
        // Test 1: ADD Operation (opcode: 000)
        // ALU_EN = 1, Opcode = 000, A = 10, B = 5 -> Expected: 15
        // ---------------------------------------------------------
        $display("\n--- Test 1: Write and Process ADD ---");
        write_to_ram(8'h01, 20'h80A05);
        
        @(negedge clk);
        addr = 8'h01; // Hold address for PISO to read
        check_alu(15, 1'b0, "ALU ADD (10 + 5)");

        // ---------------------------------------------------------
        // Test 2: SUB Operation (opcode: 001)
        // ALU_EN = 1, Opcode = 001, A = 20, B = 10 -> Expected: 10
        // ---------------------------------------------------------
        $display("\n--- Test 2: Write and Process SUB ---");
        write_to_ram(8'h02, 20'h9140A);
        
        @(negedge clk);
        addr = 8'h02; 
        check_alu(10, 1'b0, "ALU SUB (20 - 10)");

        // ---------------------------------------------------------
        // Test 3: AND Operation (opcode: 010) & Check a_is_zero flag
        // ALU_EN = 1, Opcode = 010, A = 0, B = 255 -> Expected: 0, a_is_zero: 1
        // ---------------------------------------------------------
        $display("\n--- Test 3: Write and Process AND ---");
        write_to_ram(8'h03, 20'hA00FF);
        
        @(negedge clk);
        addr = 8'h03; 
        check_alu(8'd0, 1'b1, "ALU AND (0 & 255), a_is_zero flag=1");

        // Final Results
        if (errors == 0)
            $display("\n>>> ALL %0d TESTS PASSED <<<", checks);
        else
            $display("\n>>> %0d TESTS FAILED OUT OF %0d <<<", errors, checks);

        $stop;
    end
endmodule