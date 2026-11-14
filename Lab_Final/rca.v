// TODO: Come up with a better name for ripple carry adder?
module rca(
    input [7:0] A,
    B,
    input CIN,
    output [7:0] SUM,
    output COUT
);

    wire [8:0] C;
    assign C[0] = CIN;

    fa FA0(A[0], B[0], C[0], SUM[0], C[1]);
    fa FA1(A[1], B[1], C[1], SUM[1], C[2]);
    fa FA2(A[2], B[2], C[2], SUM[2], C[3]);
    fa FA3(A[3], B[3], C[3], SUM[3], C[4]);
    fa FA4(A[4], B[4], C[4], SUM[4], C[5]);
    fa FA5(A[5], B[5], C[5], SUM[5], C[6]);
    fa FA6(A[6], B[6], C[6], SUM[6], C[7]);
    fa FA7(A[7], B[7], C[7], SUM[7], C[8]);

    assign COUT = C[8];
endmodule
