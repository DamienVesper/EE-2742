module cold_fsm(
    input CLK,
    output reg [3:0] ONECOLD,
    output reg [1:0] STATE
);

    reg [1:0] NEXT_STATE;

    localparam SR = 2'b11;
    localparam SL = 2'b00;
    localparam SML = 2'b01;
    localparam SMR = 2'b10;

    always @(posedge CLK) begin
        STATE <= NEXT_STATE;        
    end

    always @(*) begin
        case (STATE)
            SR: NEXT_STATE = SL;
            SL: NEXT_STATE = SML;
            SML: NEXT_STATE = SMR;
            SMR: NEXT_STATE = SR;
            default: NEXT_STATE = SL;
        endcase
    end

    always @(*) begin
        case (STATE)
            SR: ONECOLD = 4'b1110;
            SL: ONECOLD = 4'b0111;
            SML: ONECOLD = 4'b1111; // Disabled to separate input and output.
            SMR: ONECOLD = 4'b1101;
            default: ONECOLD = 4'b0111;
        endcase
    end

    initial STATE = SL;
endmodule
