`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Testbench for: edge_detector (Moore rising-edge detector)
// Checks: tick_moore is asserted exactly one clock cycle after 'level'
//         transitions 0 -> 1, and stays low otherwise (self-checking model).
//////////////////////////////////////////////////////////////////////////////////

module edge_detector_tb;

    reg clk;
    reg rst;
    reg level;
    wire tick_moore;

    integer errors = 0;
    integer checks = 0;

    // Reference (golden) model mirrored in the testbench
    reg [1:0] ref_state;
    reg       ref_tick;
    localparam ZERO=2'b00, EDG=2'b01, ONE=2'b10;

    // DUT instantiation
    edge_detector DUT (
        .clk(clk),
        .rst(rst),
        .level(level),
        .tick_moore(tick_moore)
    );

    // 100 MHz clock
    initial clk = 0;
    always #5 clk = ~clk;

    // Golden reference model: same Moore FSM computed independently
    always @(posedge clk) begin
        if (!rst)
            ref_state <= ZERO;
        else begin
            case (ref_state)
                ZERO: ref_state <= level ? EDG  : ZERO;
                EDG : ref_state <= level ? ONE  : ZERO;
                ONE : ref_state <= level ? ONE  : ZERO;
                default: ref_state <= ZERO;
            endcase
        end
    end
    always @(*) ref_tick = (ref_state == EDG);

    task check_tick;
        begin
            checks = checks + 1;
            if (tick_moore !== ref_tick) begin
                errors = errors + 1;
                $display("[%0t] MISMATCH: level=%b tick_moore=%b expected=%b (state=%b)",
                          $time, level, tick_moore, ref_tick, ref_state);
            end
        end
    endtask

    // Check on every clock edge (after outputs settle)
    always @(posedge clk) begin
        #1 check_tick;
    end

    initial begin
        $dumpfile("edge_detector_tb.vcd");
        $dumpvars(0, edge_detector_tb);

        // Async-style reset pulse (design samples rst synchronously)
        rst = 0; level = 0;
        repeat (3) @(posedge clk);
        @(negedge clk); rst = 1;

        // Single clean rising edge, held high, then falls
        @(negedge clk); level = 1;
        repeat (4) @(posedge clk);
        @(negedge clk); level = 0;
        repeat (3) @(posedge clk);

        // Two back-to-back pulses
        @(negedge clk); level = 1;
        @(posedge clk);
        @(negedge clk); level = 0;
        @(posedge clk);
        @(negedge clk); level = 1;
        @(posedge clk);
        @(negedge clk); level = 0;
        repeat (2) @(posedge clk);

        // Very short glitch-like pulse (1 clk wide)
        @(negedge clk); level = 1;
        @(negedge clk); level = 0;
        repeat (3) @(posedge clk);

        // Mid-simulation reset while level is high
        @(negedge clk); level = 1;
        @(posedge clk);
        @(negedge clk); rst = 0;
        @(posedge clk);
        @(negedge clk); rst = 1;
        repeat (3) @(posedge clk);

        // Random stimulus burst
        repeat (40) begin
            @(negedge clk);
            level = $random;
            @(posedge clk);
        end

        repeat (3) @(posedge clk);

        $display("---------------------------------------------------");
        if (errors == 0)
            $display("EDGE_DETECTOR TB PASSED: %0d checks, 0 errors", checks);
        else
            $display("EDGE_DETECTOR TB FAILED: %0d checks, %0d errors", checks, errors);
        $display("---------------------------------------------------");
        $finish;
    end

endmodule
