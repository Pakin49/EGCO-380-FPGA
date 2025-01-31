`timescale 1ns/1ps
module alu_tb;

    `include "instruction.vh"
    // input
    reg [3:0] op;
    reg [WORD_SIZE-1:0] expected;
    reg [WORD_SIZE-1:0] in1, in2;
    reg [(WORD_SIZE*3)+4:0] test_case [0:8];
    reg alu_enable;
    // output
    wire [WORD_SIZE-1:0] out;

    //CLK
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
        #50;
        for (integer i = 0; i < 9; i = i + 1) begin
            #10 {op,in1,in2,expected} = test_case[i];
            alu_enable = 1;
            $display("Time:%0t,op = %d, in1 = %d, in2 = %d, expected = %d, out = %d, ok = %d",$time,op, in1, in2, expected, out, (expected == out));
            #10 alu_enable = 0;
        end
        $finish; // End simulation
    end

    initial begin
        $dumpfiles("ALU.vcd");
        $dumpvars(0,alu0);
    end
endmodule
