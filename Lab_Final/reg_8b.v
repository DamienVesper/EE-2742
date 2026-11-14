module reg_8b(
    input L,
    input [7:0] N,
    input CLK,
    PRS_N,
    CLR_N,
    output wire [7:0] Q
);

    reg_1b R0(L, N[0], CLK, PRS_N, CLR_N, Q[0]);
    reg_1b R1(L, N[1], CLK, PRS_N, CLR_N, Q[1]);
    reg_1b R2(L, N[2], CLK, PRS_N, CLR_N, Q[2]);
    reg_1b R3(L, N[3], CLK, PRS_N, CLR_N, Q[3]);
    reg_1b R4(L, N[4], CLK, PRS_N, CLR_N, Q[4]);
    reg_1b R5(L, N[5], CLK, PRS_N, CLR_N, Q[5]);
    reg_1b R6(L, N[6], CLK, PRS_N, CLR_N, Q[6]);
    reg_1b R7(L, N[7], CLK, PRS_N, CLR_N, Q[7]);
endmodule
