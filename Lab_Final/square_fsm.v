module square_fsm(
    input CLK,
    input GO,
    input RST_N,
    input [3:0] N,
    input [2:0] X, Y, Z,
    input [7:0] DATA_X, DATA_Y, DATA_Z,

    output reg [2:0] WADDR,
    output reg [7:0] DATA_IN, RES,
    output reg WEN, DONE
);

    reg [2:0] S;

    wire [7:0] ADDER_A, ADDER_B, SUM;
    wire COUT;

    localparam INIT = 3'b000;
    localparam LOAD_N = 3'b001;
    localparam CLEAR = 3'b010;
    localparam LOAD_COUNT = 3'b011;
    localparam CHECK = 3'b100;
    localparam ADD_N = 3'b101;
    localparam DEC_COUNT = 3'b110;
    localparam COMPLETE = 3'b111;

    rca_8b adder(ADDER_A, ADDER_B, 0, SUM, COUT);

    assign ADDER_A = S == ADD_N
        ? DATA_Y
        : S == DEC_COUNT
            ? DATA_Z
            : 8'd0;

    assign ADDER_B = S == ADD_N
        ? DATA_X
        : S == DEC_COUNT
            ? 8'hFF
            : 8'd0;

    always @(*) begin
        WADDR = X;
        WEN = 1'b0;
        DATA_IN = 8'd0;

        case (S)
            LOAD_N: begin
                WADDR = X;
                WEN = 1;
                DATA_IN = {4'b0000, N};
            end
            CLEAR: begin
                WADDR = Y;
                WEN = 1;
                DATA_IN = 8'd0;
            end
            LOAD_COUNT: begin
                WADDR = Z;
                WEN = 1;
                DATA_IN = DATA_Y;
            end
            ADD_N: begin
                WADDR = Y;
                WEN = 1;
                DATA_IN = SUM;
            end
            DEC_COUNT: begin
                WADDR = Z;
                WEN = 1;
                DATA_IN = SUM;
            end
        endcase
    end

    always @(posedge CLK, negedge RST_N) begin
        if (!RST_N) begin
            S <= INIT;
            RES <= 8'd0;
            DONE <= 0;
        end else begin
            case (S)
                INIT: begin
                    DONE <= 0;
                    if (GO) S <= LOAD_N;
                end
                LOAD_N: begin
                    S <= CLEAR;
                end
                CLEAR: begin
                    S <= LOAD_COUNT;
                end
                LOAD_COUNT: begin
                    S <= CHECK;
                end
                CHECK: begin
                    if (DATA_Z == 8'd0) S <= COMPLETE;
                    else S <= ADD_N;
                end
                ADD_N: begin
                    S <= DEC_COUNT;
                end
                DEC_COUNT: begin
                    S <= CHECK;
                end
                COMPLETE: begin
                    RES <= DATA_Y;
                    DONE <= 1;
                    
                    if (!GO) S <= INIT;
                end
                default: begin
                    S <= INIT;
                end
            endcase
        end
    end
endmodule
