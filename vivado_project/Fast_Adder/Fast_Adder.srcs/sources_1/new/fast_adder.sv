module fast_adder_4bits (
    input [3:0] A, B, 
    input Cin,
    output [3:0] Sum, Cout
);
    logic [3:0] p, g;
    logic c[3:0];
       
    assign p = A | B;
    assign g = A & B;

    //internal carry to use to calculate sums
    genvar i;
    generate
        for(i=0;i<4;i++)begin
            assign c[i] = g[i] | (p[i] & (i==0 ? Cin: c[i-1]));
        end
    endgenerate
    assign Cout = c[3];

    generate 
        for (i=0;i<4;i=i+1) begin
            FA_no_Cout fa_instant(
                .Cin(i==0? Cin : c[i-1]),
                .A(A[i]),
                .B(B[i]),
                .Sum(Sum[i])
            );
        end
    endgenerate
endmodule

module FA_no_Cout(
    input Cin, A, B,
    output Sum
);
    assign Sum = A ^ B ^ Cin;
endmodule