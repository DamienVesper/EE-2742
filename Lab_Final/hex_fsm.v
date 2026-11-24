module hex_fsm(
    input CLK,
    input GO,
    input RST_N,
    input [7:0] DATA,
    output reg [3:0] HEX_HIGH,
    output reg [3:0] HEX_LOW,
    output reg DONE
);

    reg [2:0] S;
    reg [7:0] MEMORY;

    localparam INIT = 3'b000;
    localparam LOAD = 3'b001;
    localparam HIGH = 3'b010;
    localparam LOW = 3'b011;
    localparam END = 3'b100;

    always @(posedge CLK or negedge RST_N) begin
        if (!RST_N) begin
            S <= INIT;
            MEMORY <= 8'd0;

            HEX_HIGH <= 4'd0;
            HEX_LOW <= 4'd0;

            DONE <= 0;
        end else begin
            case (S)
                INIT: begin
                    DONE <= 0;
                    if (GO) S <= LOAD;
                end
                LOAD: begin
                    MEMORY <= DATA;
                    S <= HIGH;
                end
                HIGH: begin
                    HEX_HIGH <= MEMORY[7:4];
                    S <= LOW;
                end
                LOW: begin
                    HEX_LOW <= MEMORY[3:0];
                    S <= END;
                end
                END: begin
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
