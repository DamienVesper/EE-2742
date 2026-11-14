module sevens_driver(
    input [3:0] W,
    output reg [6:0] SEGMENTS
);

    always @(*) begin
        case (W)
            0: SEGMENTS = 7'b0000001;
            1: SEGMENTS = 7'b1001111;
            2: SEGMENTS = 7'b0010010;
            3: SEGMENTS = 7'b0000110;
            4: SEGMENTS = 7'b1001100;
            5: SEGMENTS = 7'b0100100;
            6: SEGMENTS = 7'b0100000;
            7: SEGMENTS = 7'b0001111;
            8: SEGMENTS = 7'b0000000;
            9: SEGMENTS = 7'b0000100;
            10: SEGMENTS = 7'b0001000;
            11: SEGMENTS = 7'b1100000;
            12: SEGMENTS = 7'b0110001;
            13: SEGMENTS = 7'b1000010;
            14: SEGMENTS = 7'b0110000;
            15: SEGMENTS = 7'b0111000;

            // david told me to do this
            default: SEGMENTS = 7'b1111111;
        endcase
    end
endmodule
