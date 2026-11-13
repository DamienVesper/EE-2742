module reg_1b(
    input L,
    N,
    CLK,
    PRS_N,
    CLR_N,
    output reg Q
);

    always @(posedge CLK, negedge PRS_N, negedge CLR_N) begin
        if (PRS_N == 0) begin
            Q <= 1;
        end else if (CLR_N == 0) begin
            Q <= 0;
        end else if (L) begin
            Q <= N;
        end else begin
            Q <= Q;
        end
    end
endmodule
