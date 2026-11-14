module illusion(
    input BOARDCLK,
    EN,
    input [15:0] DATA,
    output wire SEGMENTS,
    output wire [3:0] ONECOLD
);
    wire [1:0] Q;
    wire [3:0] W;
    wire FASTCLK;

    frequency_divider fd(BOARDCLK, FASTCLK);
    cold_fsm c_fsm(FASTCLK, EN, ONECOLD, Q);

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
