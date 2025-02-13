`timescale 1ns/1ps
module alu_tb;

    `include "instruction.vh"
    // input
    reg [3:0] op;
    reg [WORD_SIZE-1:0] expected;
    reg [WORD_SIZE-1:0] in1, in2;
    reg [(WORD_SIZE*3)+4:0] test_case [0:8];
    reg alu_enable = 1;
  
    // output
    wire [WORD_SIZE-1:0] out;

    //CLK
    reg clk = 1'b1;
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
    
    initial begin
        $readmemh("test_case.hex",test_case);
        #50;
        for (integer i = 0; i < 9; i = i + 1) begin
            #10 {op,in1,in2,expected} = test_case[i];
        end
      	#10;
        $finish; // End simulation
    end
  
    always @(negedge clk)begin
        if(alu_enable)begin
            $monitor("Time:%0t, op = %d, in1 = %d, in2 = %d, expected = %d, out = %d, ok = %d",$time,op, in1, in2, expected, out, (expected == out));
        end
    end
    initial begin
      $dumpfile("ALU.vcd");
      $dumpvars(0,alu_tb);
    end
endmodule
