// synthesize in Vivado

module minimization_example(z,x,y)
    input x,y;
    output z;
    assign z = (~x&y) | (x&y);
endmodule