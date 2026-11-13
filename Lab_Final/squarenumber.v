module squarenumber(
        input [3:0] N,
        input GO,
        input RST_N,
        input BOARDCLK,

        output A, B, C, D, E, F, G,
        output [3:0] ONECOLD,
        output DONE
    );

    wire [7:0] DATA_X;
    wire [7:0] DATA_Y;
    wire [7:0] DATA_Z;

    wire [7:0] SUM;
    wire COUT;

    wire [3:0] WADDR;
    wire [7:0] DATA_IN;
    wire WEN;

    wire SQUARE_DONE;
    wire HEX_DONE;

    wire [15:0] DISPLAY_DATA;
endmodule
