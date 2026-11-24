module core_fsm(
    input BOARDCLK,
    input RST_N,
    input GO,
    input [3:0] N,

    output [6:0] SEGMENTS,
    output [3:0] ONECOLD,
    output DONE
);

    reg [2:0] S, S_NEXT, WADDR, X, Y, Z;
    reg [3:0] N_REG;
    reg [7:0] DATA_IN;
    reg WEN, SQ_GO, HEX_GO;

    wire SQ_WEN, SQ_DONE, HEX_DONE;
    wire [15:0] DISPLAY_DATA;
    wire [7:0] DATA_X, DATA_Y, DATA_Z, SQ_DATA_IN, SQ_RES;
    wire [3:0] HEX_HIGH, HEX_LOW;
    wire [2:0] SQ_WADDR;

    localparam INIT = 3'd0;
    localparam INIT_SQ = 3'd1;
    localparam AWAIT_SQ = 3'd2;
    localparam INIT_HEX = 3'd3;
    localparam AWAIT_HEX = 3'd4;
    localparam WRITE_HIGH = 3'd5;
    localparam WRITE_LOW = 3'd6;
    localparam COMPLETE = 3'd7;

    // Contrary to their naming scheme, these actually refer to the register addresses of the relevant ports.
    // Changing these also apply to square FSM. Make modifications accordingly.
    localparam SQ_X = 3'd0;
    localparam SQ_Y = 3'd1;
    localparam SQ_Z = 3'd2;

    // The same thing as above, but for hex FSM instead.
    localparam HEX_X = 3'd3;
    localparam HEX_Y = 3'd4;
    localparam HEX_Z = 3'd5;

    regfile_8x8 regfile(
        WADDR,
        WEN,
        DATA_IN,
        BOARDCLK,
        X,
        Y,
        Z,
        DATA_X,
        DATA_Y,
        DATA_Z
    );

    square_fsm square(
        BOARDCLK,
        SQ_GO,
        RST_N,
        N_REG,
        SQ_X,
        SQ_Y,
        SQ_Z,
        DATA_X,
        DATA_Y,
        DATA_Z,
        SQ_WADDR,
        SQ_DATA_IN,
        SQ_RES,
        SQ_WEN,
        SQ_DONE
    );

    hex_fsm hex(
        BOARDCLK,
        HEX_GO,
        RST_N,
        SQ_RES,
        HEX_HIGH,
        HEX_LOW,
        HEX_DONE
    );

    illusion display(
        BOARDCLK,
        DISPLAY_DATA,
        SEGMENTS,
        ONECOLD
    );

    assign DISPLAY_DATA = {
        DATA_X[3:0],
        4'b0000,
        DATA_Y[3:0],
        DATA_Z[3:0]
    };

    assign DONE = S == COMPLETE;

    // Input update logic.
    always @(posedge BOARDCLK, negedge RST_N) begin
        if (!RST_N) begin
            S <= INIT;
            N_REG <= 4'd0;
        end else begin
            S <= S_NEXT;
            if (S == INIT && GO) N_REG <= N;
        end
    end

    // State transition logic.
    always @(*) begin
        S_NEXT = S;
        case (S)
            INIT: if (GO) S_NEXT = INIT_SQ;
            INIT_SQ: S_NEXT = AWAIT_SQ;
            AWAIT_SQ: if (SQ_DONE) S_NEXT = INIT_HEX;
            INIT_HEX: S_NEXT = AWAIT_HEX;
            AWAIT_HEX: if (HEX_DONE) S_NEXT = WRITE_HIGH;
            WRITE_HIGH: S_NEXT = WRITE_LOW;
            WRITE_LOW: S_NEXT = COMPLETE;
            COMPLETE: if (!GO) S_NEXT = INIT;
            default: S_NEXT = INIT;
        endcase
    end

    // FSM controllers.
    always @(*) begin
        // Honestly redundant but who cares...
        SQ_GO = 0;
        HEX_GO = 0;

        case (S)
            INIT_SQ: SQ_GO = 1;
            INIT_HEX: HEX_GO = 1;
            default: begin
                SQ_GO = 0;
                HEX_GO = 0;
            end
        endcase
    end

    // Painful register nonsense.
    always @(*) begin
        WADDR = 3'd0;
        WEN = 0;
        DATA_IN = 8'd0;

        X = SQ_X;
        Y = HEX_X;
        Z = HEX_Y;

        if (S == INIT_SQ || S == AWAIT_SQ) begin
            WADDR = SQ_WADDR;
            WEN = SQ_WEN;
            DATA_IN = SQ_DATA_IN;
        end else begin
            case (S)
                WRITE_HIGH: begin
                    WADDR = HEX_X;
                    WEN = 1;
                    DATA_IN = {4'b0000, HEX_HIGH};
                end
                WRITE_LOW: begin
                    WADDR = HEX_Y;
                    WEN = 1;
                    DATA_IN = {4'b0000, HEX_LOW};
                end
                default: WEN = 0;
            endcase
        end
    end
endmodule
