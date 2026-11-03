module cold_fsm(
    input CLK,
    EN,
    output reg [3:0] ONECOLD,
    output reg [1:0] STATE
);

    reg [1:0] NEXT_STATE;

    parameter SR = 2'b11;
    parameter SL = 2'b00;
    parameter SML = 2'b01;
    parameter SMR = 2'b10;

    always @(posedge CLK) begin
        STATE <= NEXT_STATE;        
    end

    always @(*) begin
        case (STATE)
            SR: NEXT_STATE = SL;
            SL: NEXT_STATE = EN ? SL : SML;
            SML: NEXT_STATE = SMR;
            SMR: NEXT_STATE = SR;
        endcase
    end

    always @(*) begin
        case (STATE)
            SR: ONECOLD = 4'b1110;
            SL: ONECOLD = 4'b0111;
            SML: ONECOLD = 4'b1011;
            SMR: ONECOLD = 4'b1101;
            default: ONECOLD = 4'b0111;
        endcase
    end
endmodule
