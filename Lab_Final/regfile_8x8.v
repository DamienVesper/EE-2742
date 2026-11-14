module regfile_8x8(
    input [2:0] WADDR,
    input WEN,
    input [7:0] DATA_IN,
    input CLK,
    input [2:0] XADDR,
    input [2:0] YADDR,
    input [3:0] ZADDR,
    output [3:0] DATA_X,
    output [7:0] DATA_Y,
    output [7:0] DATA_Z
);

    wire [7:0] ACT;
    wire [7:0] RQ0, RQ1, RQ2, RQ3, RQ4, RQ5, RQ6, RQ7;

    dec3to8 dec(WADDR, WEN, ACT);

    reg_8b r0(ACT[0], DATA_IN, CLK, 1, 1, RQ0);
    reg_8b r0(ACT[1], DATA_IN, CLK, 1, 1, RQ1);
    reg_8b r0(ACT[2], DATA_IN, CLK, 1, 1, RQ2);
    reg_8b r0(ACT[3], DATA_IN, CLK, 1, 1, RQ3);
    reg_8b r0(ACT[4], DATA_IN, CLK, 1, 1, RQ4);
    reg_8b r0(ACT[5], DATA_IN, CLK, 1, 1, RQ5);
    reg_8b r0(ACT[6], DATA_IN, CLK, 1, 1, RQ6);
    reg_8b r0(ACT[7], DATA_IN, CLK, 1, 1, RQ7);

    mux8to1_8b mux_x(XRADDR, RQ0, RQ1, RQ2, RQ3, RQ4, RQ5, RQ6, RQ7, DATA_X);
    mux8to1_8b mux_y(YRADDR, RQ0, RQ1, RQ2, RQ3, RQ4, RQ5, RQ6, RQ7, DATA_Y);
    mux8to1_8b mux_z(ZRADDR, RQ0, RQ1, RQ2, RQ3, RQ4, RQ5, RQ6, RQ7, DATA_Z);
endmodule
