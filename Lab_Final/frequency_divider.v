module frequency_divider(input CLKO, output wire CLKF);
    parameter CLK_COUNT = 20;
    wire CLKS[CLK_COUNT:0];

    assign CLKS[0] = CLKO;
    genvar i;

    for (i = 1; i <= CLK_COUNT; i = i + 1) begin
        TFF tffi(.T(1), .CLK(CLKS[i - 1]), .PRS_N(1), .CLR_N(1), .Q(CLKS[i]));
    end

    assign CLKF = CLKS[CLK_COUNT];
endmodule
