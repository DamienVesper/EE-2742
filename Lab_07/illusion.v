module illusion(
    input EN,
    input [15:0] DATA,
    input BOARDCLK,
    output wire A, B, C, D, E, F, G,
    output wire [3:0] ONECOLD
);
    // State variables for the Active Digit
    wire Q1, Q0;

    // Inputs to the sevens_driver at the end.
    wire W3, W2, W1, W0;

    // New clock to be used in all subsequent modulles.
    wire FASTCLK;

    // First, generate a clock fast enough that you can't see the digits moving,
    // But slow enough that you can see each digit individually (~1 kHz).
    frequency_divider fd(BOARDCLK, FASTCLK);

    // Next, we need to keep state of which digit is active.
    // Cold_fsm generates one cold wire for the active display.
    cold_fsm c_fsm(
        FASTCLK,
        EN,
        {Q1, Q0},
        ONECOLD
    );

    // The values of Q1 and Q0 can be used to determine which
    // 4b of DATA will be sent to the sevens_driver.
    // We can use a 4-1 mux for this. It needs to be consistent with
    // The state of the FSM.
    mux_4b_4_1 data_mux (
        DATA[15:12],
        DATA[11:8],
        DATA[7:4],
        DATA[3:0],
        {Q1, Q0},
        {W3, W2, W1, W0}
    );

    // Finally, the sevens driver which displays the active digit.
    sevens_driver sevenseg(
        W3,
        W2,
        W1,
        W0,
        A,
        B,
        C,
        D,
        E,
        F,
        G
    );
endmodule
