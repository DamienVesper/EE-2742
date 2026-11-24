module illusion(
    input CLK,
    input [15:0] DATA,
    output wire [6:0] SEGMENTS,
    output wire [3:0] ONECOLD
);
    wire [1:0] Q;
    wire [3:0] W;
    wire NEWCLK;

    frequency_divider fd(CLK, NEWCLK);
    cold_fsm c_fsm(NEWCLK, ONECOLD, Q);

    mux_4to1_4b mux_data(
        Q,
        DATA[3:0],
        DATA[7:4],
        DATA[11:8],
        DATA[15:12],
        W
    );

    sevens_driver sevenseg(W, SEGMENTS);
endmodule
