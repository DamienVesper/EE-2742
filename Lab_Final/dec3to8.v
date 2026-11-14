module dec3to8(
    input [2:0] WADDR,
    input WEN,
    output wire [7:0] ACT
);

    assign ACT = WEN
        ? (8'b00000001 << WADDR)
        : 8'b00000000;
endmodule
