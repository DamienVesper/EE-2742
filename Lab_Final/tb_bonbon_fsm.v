`timescale 1ns / 1ps

module tb_bonbon_fsm();

    reg BOARDCLK;
    reg RST_N;
    reg GO;
    reg [3:0] N;

    wire [6:0] SEGMENTS;
    wire [3:0] ONECOLD;
    wire DONE;

    reg [7:0] EXPECTED;
    integer i;
    integer ERRORS;

    bonbon_fsm uut(
        BOARDCLK,
        RST_N,
        GO,
        N,
        SEGMENTS,
        ONECOLD,
        DONE
    );

    always #5 BOARDCLK = ~BOARDCLK;

    function [7:0] expected_square;
        input [3:0] VALUE;
        begin
            case (VALUE)
                4'd0: expected_square = 8'h00;
                4'd1: expected_square = 8'h01;
                4'd2: expected_square = 8'h04;
                4'd3: expected_square = 8'h09;
                4'd4: expected_square = 8'h10;
                4'd5: expected_square = 8'h19;
                4'd6: expected_square = 8'h24;
                4'd7: expected_square = 8'h31;
                4'd8: expected_square = 8'h40;
                4'd9: expected_square = 8'h51;
                4'd10: expected_square = 8'h64;
                4'd11: expected_square = 8'h79;
                4'd12: expected_square = 8'h90;
                4'd13: expected_square = 8'hA9;
                4'd14: expected_square = 8'hC4;
                4'd15: expected_square = 8'hE1;
                default: expected_square = 8'hXX;
            endcase
        end
    endfunction

    initial begin
        BOARDCLK = 0;
        RST_N = 0;
        GO = 0;
        N = 0;
        ERRORS = 0;

        #20;
        RST_N = 1;

        for (i = 0; i < 16; i = i + 1) begin

            @(negedge BOARDCLK);
            N = i;
            GO = 1;

            @(negedge BOARDCLK);
            GO = 0;

            wait(DONE == 1'b1);
            #10;

            EXPECTED = expected_square(i);

            if (uut.regfile.DATA_X[3:0] !== i ||
                uut.regfile.DATA_Y[3:0] !== EXPECTED[7:4] ||
                uut.regfile.DATA_Z[3:0] !== EXPECTED[3:0]) begin

                $display(
                    "FAIL: N=%0d | Expected=%h | Actual=%h%h",
                    i, EXPECTED,
                    uut.DATA_Y[3:0],
                    uut.DATA_Z[3:0]
                );

                ERRORS = ERRORS + 1;
            end else begin
                $display("PASS: N=%0d | N^2=%0d | HEX=%h", i, i * i, EXPECTED);
            end

            wait(DONE == 1'b0);

        end

        if (ERRORS == 0)
            $display("ALL 16 TESTS PASSED");
        else
            $display("%0d TESTS FAILED", ERRORS);

        #20;
        $finish;
    end

    initial begin
        #1000000;
        $display("TIMEOUT");
        $finish;
    end
endmodule
