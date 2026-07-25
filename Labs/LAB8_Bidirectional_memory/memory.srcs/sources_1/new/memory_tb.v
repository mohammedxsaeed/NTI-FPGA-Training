`timescale 1ns / 1ps

module memory_tb;

    localparam AWIDTH = 4;
    localparam DWIDTH = 8;

    reg clk;
    reg wr, rd;
    reg [AWIDTH-1:0] addr;

    reg  [DWIDTH-1:0] drive_data;
    reg  drive_en; 
    wire [DWIDTH-1:0] data = drive_en ? drive_data : {DWIDTH{1'bz}};

    integer errors = 0;
    integer checks = 0;

    memory #(.AWIDTH(AWIDTH), .DWIDTH(DWIDTH)) DUT (
        .clk(clk), .wr(wr), .rd(rd), .addr(addr), .data(data)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;

    // Write task
    task write_mem(input [AWIDTH-1:0] a, input [DWIDTH-1:0] d);
        begin
            @(negedge clk);
            addr = a; 
            drive_data = d; 
            drive_en = 1; 
            wr = 1; 
            rd = 0;
            
            @(posedge clk); 
            @(negedge clk);
            drive_en = 0; 
            wr = 0;
        end
    endtask

    // Read and check task
    task read_and_check(input [AWIDTH-1:0] a, input [DWIDTH-1:0] expected, input [255:0] label);
        begin
            @(negedge clk);
            addr = a; 
            drive_en = 0; 
            rd = 1; 
            wr = 0;
            
            #2; 
            checks = checks + 1;
            
            if (data !== expected) begin
                errors = errors + 1;
                $display("[%0t] MISMATCH (%0s): addr=%0d | data=%h | expected=%h", $time, label, a, data, expected);
            end
            
            @(negedge clk);
            rd = 0;
        end
    endtask

    integer i;
    reg [DWIDTH-1:0] model [0:(1<<AWIDTH)-1]; 

    initial begin
        // Initialize signals
        wr = 0; rd = 0; addr = 0; drive_en = 0; drive_data = 0;
        repeat (2) @(posedge clk);

        // Check if bus is High-Z when idle
        @(negedge clk);
        #2;
        checks = checks + 1;
        if (data !== {DWIDTH{1'bz}}) begin
            errors = errors + 1;
            $display("[%0t] ERROR: Idle bus should be Z (High-Z). Current data=%h", $time, data);
        end

        // Basic write and read tests
        write_mem(4'd0,  8'hA5);
        write_mem(4'd1,  8'h3C);
        write_mem(4'd15, 8'hFF);

        read_and_check(4'd0,  8'hA5, "Read addr 0");
        read_and_check(4'd1,  8'h3C, "Read addr 1");
        read_and_check(4'd15, 8'hFF, "Read addr 15");

        // Overwrite test
        write_mem(4'd1, 8'h99);
        read_and_check(4'd1, 8'h99, "Read after overwrite");

        // Exhaustive test with random values
        for (i = 0; i < (1<<AWIDTH); i = i + 1) begin
            model[i] = $random;
            write_mem(i[AWIDTH-1:0], model[i]);
        end
        
        for (i = 0; i < (1<<AWIDTH); i = i + 1) begin
            read_and_check(i[AWIDTH-1:0], model[i], "Exhaustive sweep");
        end

        if (errors == 0)
            $display(">>> MEMORY TB PASSED: %0d checks, 0 errors <<<", checks);
        else
            $display(">>> MEMORY TB FAILED: %0d errors out of %0d checks <<<", errors, checks);
        
        $stop;
    end
endmodule