`timescale 1ns / 1ps

module counter_tb;

    localparam WIDTH = 5;

    reg clk;
    reg rst;
    reg load;
    reg enab;
    reg  [WIDTH-1:0] cnt_in;
    wire [WIDTH-1:0] cnt_out;

    integer errors = 0;
    integer checks = 0;
    reg [WIDTH-1:0] expected;

    counter_func #(.WIDTH(WIDTH)) DUT (
        .clk(clk), .rst(rst), .load(load), .enab(enab),
        .cnt_in(cnt_in), .cnt_out(cnt_out)
    );

    always #5 clk = ~clk;

    task check(input [255:0] label);
        begin
            checks = checks + 1;
            if (cnt_out !== expected) begin
                errors = errors + 1;
                $display("[%0t] TEST FAILED (%0s): cnt_out=%b expected=%0d",
                          $time, label, cnt_out, expected);
            end
        end
    endtask

    initial begin
        clk = 0; rst = 1; load = 0; enab = 0; cnt_in = 0;
        @(posedge clk); #1; expected = 0; check("sync reset");

        @(negedge clk); rst = 0; load = 1; cnt_in = 4'd11;
        @(posedge clk); #1; expected = 11; check("load 11");

        @(negedge clk); load = 1; cnt_in = 4'd3;
        @(posedge clk); #1; expected = 3; check("load 3");

        @(negedge clk); load = 0; enab = 1;
        @(posedge clk); #1; expected = 4; check("increment after load");

        @(negedge clk);
        @(posedge clk); #1; expected = 5; check("continue counting");

        @(negedge clk); enab = 0;
        @(posedge clk); #1; expected = 5; check("hold");

        @(negedge clk);
        @(posedge clk); #1; expected = 5; check("hold still");

        @(negedge clk); load = 1; cnt_in = {WIDTH{1'b1}};
        @(posedge clk); #1; expected = {WIDTH{1'b1}}; check("load max value");

        @(negedge clk); load = 0; enab = 1;
        @(posedge clk); #1; expected = 0; check("wraparound to 0");

        @(negedge clk);
        @(posedge clk); #1; expected = 1; check("continue after wrap");

        @(negedge clk); load = 1; enab = 1; cnt_in = 4'd6;
        @(posedge clk); #1; expected = 6; check("load priority over enab");

        @(negedge clk); load = 0;
        @(posedge clk); #1; expected = 7; check("count resumes after load");

        @(negedge clk); rst = 1;
        @(posedge clk); #1; expected = 0; check("reset while counting");

        @(negedge clk); rst = 0;
        @(posedge clk); #1; expected = 1; check("resume counting after reset");

        @(negedge clk); enab = 0;
        repeat (30) begin
            @(negedge clk);
            load = $random;
            enab = $random;
            cnt_in = $random;
            @(posedge clk); #1;
            if (load)
                expected = cnt_in;
            else if (enab)
                expected = expected + 1'b1;
            check("random sequence");
        end

        if (errors == 0)
            $display("COUNTER TB PASSED: %0d checks, 0 errors", checks);
        else
            $display("COUNTER TB FAILED: %0d checks, %0d errors", checks, errors);
        $finish;
    end

endmodule