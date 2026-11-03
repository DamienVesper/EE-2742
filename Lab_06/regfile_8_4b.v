module regfile_8_4b(
    input WADDR2,
    WADDR1,
    WADDR0,
    WEN,
    input [3:0] DATA_IN,
    input CLK,
    XRADDR2,
    XRADDR1,
    XRADDR0,
    YRADDR2,
    YRADDR1,
    YRADDR0,
    output [3:0] DATA_X,
    DATA_Y
);

    wire act7, act6, act5, act4, act3, act2, act1, act0;
    wire [3:0] rq7, rq6, rq5, rq4, rq3, rq2, rq1, rq0;

    // First, the decoder takes the writing ports and determines which register
    // will be written to.

    // These will be on the eight "act" wires and are one-hot encoded.
    decoder_3_8 dec (
        WADDR2,
        WADDR1,
        WADDR0,
        WEN,
        act7,
        act6,
        act5,
        act4,
        act3,
        act2,
        act1,
        act0
    );

    // Next, each "act" wire goes to one of the eight registers in the register file.
    // "act" determines if data will go into the register,
    // and the data is in the DATA_IN (The data going IN to the register file).
    reg4b r0(act0, DATA_IN, CLK, 1, 1, rq0);
    reg4b r1(act1, DATA_IN, CLK, 1, 1, rq1);
    reg4b r2(act2, DATA_IN, CLK, 1, 1, rq2);
    reg4b r3(act3, DATA_IN, CLK, 1, 1, rq3);
    reg4b r4(act4, DATA_IN, CLK, 1, 1, rq4);
    reg4b r5(act5, DATA_IN, CLK, 1, 1, rq5);
    reg4b r6(act6, DATA_IN, CLK, 1, 1, rq6);
    reg4b r7(act7, DATA_IN, CLK, 1, 1, rq7);

    // Finally, each read port has to choose
    // one of the registers to use as its output.
    // This decision is based on the input XRADDR and YRADDR which will send the
    // appropriate register to DATA_X and DATA_Y, respectively.

    // DATA_X and DATA_Y contain values that were
    // written to the register file on some earlier clock.
    mux8_4b mux_x(
        XRADDR2,
        XRADDR1,
        XRADDR0,
        rq0,
        rq1,
        rq2,
        rq3,
        rq4,
        rq5,
        rq6,
        rq7,
        DATA_X
    );

    mux8_4b mux_y(
        YRADDR2,
        YRADDR1,
        YRADDR0,
        rq0,
        rq1,
        rq2,
        rq3,
        rq4,
        rq5,
        rq6,
        rq7,
        DATA_Y
    );
endmodule
