
module fa(input A, B, CIN, output wire SUM, COUT);
    assign {COUT, SUM} = A + B + CIN;
endmodule
