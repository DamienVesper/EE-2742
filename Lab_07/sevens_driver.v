module sevens_driver(
    input W3,
    input W2,
    input W1,
    input W0,
    output wire A,
    output wire B,
    output wire C,
    output wire D,
    output wire E,
    output wire F,
    output wire G
);

    // Remember that a logic 1 at the seven-segment display turns the light off
    // so, to turn the light on, you provide a logic 0.
    wire [3:0] fourbit_input;
    reg [6:0] sevenbit_output;

    // Notice that fourbit_input is 4-bits and each bit is assigned
    // using the following concatenation operation to the four bits of W.
    assign fourbit_input = {W3, W2, W1, W0};

    // The same is also done of the 7-bit reg sevenbit_output, which takes
    // the 7-bits of the reg and connects them to the seven outputs A thru G.
    assign {A, B, C, D, E, F, G} = sevenbit_output;

    always @(*) begin
        // Here, we have the case statement, which looks at the 4-bit input as a value
        // then runs the code that matches with that value.
        case (fourbit_input)
            // For instance, if W3 through W0 are 0000 (which is zero),
            // then we set the sevenbit_output to 7'b0000001;
            // Note that the rightmost bit corresponds to G because if you look back up
            // at the last assign statement, G is on the rightmost side of the list.
            0: sevenbit_output = 7'b0000001;

            // Here, note that the 0s correspond to B and C.
            1: sevenbit_output = 7'b1001111;

            // Put the rest of the numbers here all the way to 15 (hex F)
            2:  sevenbit_output = 7'b0010010;
            3:  sevenbit_output = 7'b0000110;
            4:  sevenbit_output = 7'b1001100;
            5:  sevenbit_output = 7'b0100100;
            6:  sevenbit_output = 7'b0100000;
            7:  sevenbit_output = 7'b0001111;
            8:  sevenbit_output = 7'b0000000;
            9:  sevenbit_output = 7'b0000100;
            10: sevenbit_output = 7'b0001000;
            11: sevenbit_output = 7'b1100000;
            12: sevenbit_output = 7'b0110001;
            13: sevenbit_output = 7'b1000010;
            14: sevenbit_output = 7'b0110000;
            15: sevenbit_output = 7'b0111000;
        endcase
    end
endmodule
