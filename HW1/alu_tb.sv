`timescale 1ns/1ps
module alu_tb;

    `include "instruction.vh"
    
    reg [3:0] op;
    reg [WORD_SIZE-1:0] expected;
    wire [WORD_SIZE-1:0] out;
    reg [WORD_SIZE-1:0] in1, in2;
    reg [(WORD_SIZE*3)+3:0] test_case [0:7];
    reg alu_enable;
    assign alu_enable = 1;

    reg clk = 1'b0;
    always #5 clk = !clk;

    // Instantiate the ALU module
    alu alu0 (
        .clk(clk),
        .op(op),
        .in1(in1),
        .in2(in2),
        .alu_enable(alu_enable),
        .out(out)
    );
    
    // Load test case values from a file
    initial begin
        $readmemh("test_case.hex", test_case); 
        #100;
        for (integer i = 0; i < 8; i = i + 1) begin
            #10;
            { op, in1, in2, expected } = test_case[i];
            $display("Test Case %0d:%d op = %h, in1 = %h, in2 = %h, expected = %h, out = %h, ok = %b",i,test_case, op, in1, in2, expected, out, (expected == out));
        end
        $stop; // End simulation
    end
endmodule
