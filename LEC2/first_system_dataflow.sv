module first_system(out1, out2, in1, in2);

    // port definitions
    input in1, in2;
    output out1, out2;

    // dataflow modeling

    assign out1 = (in1 & in2) ^ (in1 | in2);
    assign out2 = ~in2;

endmodule