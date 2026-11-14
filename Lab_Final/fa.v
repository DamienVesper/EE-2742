module fa(input A, B, CIN, output wire SUM, COUT);
    assign SUM  = A ^ B ^ CIN;
    assign COUT = (A & B) | (CIN & (A ^ B));
endmodule
