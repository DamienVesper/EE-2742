module dec3to8(
    input [2:0] WADDR,
    input WEN,
    output wire [7:0] ACT
);

    assign ACT[0] = WEN & (~WADDR[2] & ~WADDR[1] & ~WADDR[0]);
    assign ACT[1] = WEN & (~WADDR[2] & ~WADDR[1] &  WADDR[0]);
    assign ACT[2] = WEN & (~WADDR[2] &  WADDR[1] & ~WADDR[0]);
    assign ACT[3] = WEN & (~WADDR[2] &  WADDR[1] &  WADDR[0]);
    assign ACT[4] = WEN & ( WADDR[2] & ~WADDR[1] & ~WADDR[0]);
    assign ACT[5] = WEN & ( WADDR[2] & ~WADDR[1] &  WADDR[0]);
    assign ACT[6] = WEN & ( WADDR[2] &  WADDR[1] & ~WADDR[0]);
    assign ACT[7] = WEN & ( WADDR[2] &  WADDR[1] &  WADDR[0]);
endmodule
