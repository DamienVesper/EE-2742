module mux_4to1_4b(
    input [1:0] S,
    input [3:0] I3, I2, I1, I0,
    output reg [3:0] Y
);

    always @(*) begin
        case (S)
            2'b11: Y = I3;
            2'b10: Y = I2;
            2'b01: Y = I1;
            2'b00: Y = I0;
            default: Y = 4'b0000;
        endcase
    end
endmodule
