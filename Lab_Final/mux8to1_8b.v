
module mux8to1_8b(
    input [2:0] S,
    input [7:0] I0,
    input [7:0] I1,
    input [7:0] I2,
    input [7:0] I3,
    input [7:0] I4,
    input [7:0] I5,
    input [7:0] I6,
    input [7:0] I7,
    output reg [7:0] Y
);

    always @(*) begin
        case (S)
            3'b000: Y = I0;
            3'b001: Y = I1;
            3'b010: Y = I2;
            3'b011: Y = I3;
            3'b100: Y = I4;
            3'b101: Y = I5;
            3'b110: Y = I6;
            3'b111: Y = I7;
            default: Y = 8'b00000000;
        endcase
    end
endmodule
