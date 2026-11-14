`timescale 1ns / 1ps

module square_fsm(
    input [3:0] N,
    input GO,
    input RST_N,
    input BOARDCLK,

    output A, B, C, D, E, F, G,
    output [3:0] ONECOLD,
    output DONE
);

    wire [7:0] DATA_X;
    wire [7:0] DATA_Y;
    wire [7:0] DATA_Z;

    wire [7:0] SUM;
    wire COUT;

    wire [3:0] WADDR;
    wire [7:0] DATA_IN;
    wire WEN;

    wire SQUARE_DONE;
    wire HEX_DONE;

    wire [15:0] DISPLAY_DATA;

    // State registers
    reg [3:0] state;
    reg [3:0] next_state;

    // Hexadecimal registers
    reg [3:0] hex_lo;
    reg [3:0] hex_hi;

    // Input and GO registers
    reg [3:0] input_latched;
    reg go_prev;

    wire start_pulse;

    assign start_pulse = GO & ~go_prev;

    // Ripple-carry adder inputs
    wire [7:0] adder_a;
    wire [7:0] adder_b;

    assign adder_a =
        (state == 4'b0101) ? DATA_X :
        (state == 4'b0110) ? DATA_Z :
                             8'd0;

    assign adder_b =
        (state == 4'b0101) ? DATA_Y :
        (state == 4'b0110) ? 8'hFF :
                             8'd0;

    // Register File
    // R0 = Original input
    // R1 = Accumulated square
    // R2 = Counter

    regfile_8x8 registers(
        .WADDR(WADDR[2:0]),
        .WEN(WEN),
        .DATA_IN(DATA_IN),
        .CLK(BOARDCLK),

        .XADDR(3'd1),
        .YADDR(3'd0),
        .ZADDR(4'd2),

        .DATA_X(DATA_X),
        .DATA_Y(DATA_Y),
        .DATA_Z(DATA_Z)
    );

    // Ripple-Carry Adder
    rca add_unit(
        .A(adder_a),
        .B(adder_b),
        .CIN(1'b0),
        .SUM(SUM),
        .COUT(COUT)
    );

    // Register File Write Address
    assign WADDR =
        (state == 4'b0001) ? 4'd0 :
        (state == 4'b0010 || state == 4'b0101) ? 4'd1 :
        (state == 4'b0011 || state == 4'b0110) ? 4'd2 :
                                                  4'd0;

    // Register File Write Enable
    assign WEN =
        (state == 4'b0001) ||
        (state == 4'b0010) ||
        (state == 4'b0011) ||
        (state == 4'b0101) ||
        (state == 4'b0110);

    // Register File Data Input
    assign DATA_IN =
        (state == 4'b0001) ? {4'b0000, input_latched} :
        (state == 4'b0010) ? 8'd0 :
        (state == 4'b0011) ? DATA_Y :
        (state == 4'b0101 || state == 4'b0110) ? SUM :
                                                  8'd0;

    // Completion signals
    assign SQUARE_DONE =
        (state == 4'b0111) ||
        (state == 4'b1000) ||
        (state == 4'b1001) ||
        (state == 4'b1010);

    assign HEX_DONE =
        (state == 4'b1001) ||
        (state == 4'b1010);

    assign DONE = HEX_DONE;

    // Hexadecimal Display Data
    assign DISPLAY_DATA = {
        4'h0,
        4'h0,
        hex_hi,
        hex_lo
    };

    // Seven-Segment Display
    wire [6:0] segments;

    illusion display(
        .BOARDCLK(BOARDCLK),
        .EN(1'b1),
        .DATA(DISPLAY_DATA),
        .SEGMENTS(segments),
        .ONECOLD(ONECOLD)
    );

    assign {A, B, C, D, E, F, G} = segments;

    // FSM Next State Logic
    always @(*) begin

        next_state = state;

        case (state)

            // IDLE
            4'b0000: begin
                if (start_pulse)
                    next_state = 4'b0001;
            end

            // LOAD_N
            4'b0001: begin
                next_state = 4'b0010;
            end

            // CLEAR_ACC
            4'b0010: begin
                next_state = 4'b0011;
            end

            // LOAD_COUNT
            4'b0011: begin
                next_state = 4'b0100;
            end

            // CHECK
            4'b0100: begin
                if (DATA_Z == 8'd0)
                    next_state = 4'b0111;
                else
                    next_state = 4'b0101;
            end

            // ADD_N
            4'b0101: begin
                next_state = 4'b0110;
            end

            // DEC_COUNT
            4'b0110: begin
                next_state = 4'b0100;
            end

            // HEX_LOW
            4'b0111: begin
                next_state = 4'b1000;
            end

            // HEX_HIGH
            4'b1000: begin
                next_state = 4'b1001;
            end

            // FINISHED
            4'b1001: begin
                if (!GO)
                    next_state = 4'b1010;
            end

            // WAIT_GO_LOW
            4'b1010: begin
                if (start_pulse)
                    next_state = 4'b0001;
            end

            default: begin
                next_state = 4'b0000;
            end

        endcase
    end

    // Sequential Logic
    always @(posedge BOARDCLK or negedge RST_N) begin

        if (!RST_N) begin
            state <= 4'b0000;

            input_latched <= 4'd0;

            hex_lo <= 4'd0;
            hex_hi <= 4'd0;

            go_prev <= 1'b0;
        end

        else begin

            state <= next_state;
            go_prev <= GO;

            // Latch user input
            if ((state == 4'b0000 ||
                 state == 4'b1010) && start_pulse) begin

                input_latched <= N;

            end

            // Extract lower hexadecimal digit
            if (state == 4'b0111) begin
                hex_lo <= DATA_X[3:0];
            end

            // Extract upper hexadecimal digit
            if (state == 4'b1000) begin
                hex_hi <= DATA_X[7:4];
            end

        end
    end

endmodule
