module cold_fsm(
    input CLK,
    EN,
    output reg [1:0] STATE,
    output reg [3:0] ONECOLD
);

    localparam [1:0] 
        SR = 2'b00,
        SL = 2'b01,
        SML = 2'b10,
        SMR = 2'b11;

    always @(posedge CLK) begin
        case (STATE)
            SR: STATE <= SL;
            SL: STATE <= (~EN & SML) | (EN & SL);
            SML: STATE <= SMR;
            SMR: STATE <= SR;
        endcase
    end

    always @(*) begin
        case (STATE)
            SR: ONECOLD = 4'b1110;
            SL: ONECOLD = 4'b0111;
            SML: ONECOLD = 4'b1011;
            SMR: ONECOLD = 4'b1101;
        endcase
    end
endmodule
