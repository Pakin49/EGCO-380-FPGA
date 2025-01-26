`timescale 1ns/1ps

module fast_adder_4bits_tb;
  logic [3:0]in[0:1];
  logic [3:0] sum;
  logic carry;
  
  fast_adder_4bits uut(
        .A(in[0]),
        .B(in[1]),
        .Cin(0),
        .Sum(sum),
        .Cout(carry)
  );

  initial begin
    integer i,j;
    i = 0; 
    j = 0;
    for (i = 0;i<16;i=i+1)begin
        in[0] <= i;
        for(j=0;j<16;j=j+1)begin
          in[1] <= j; #10;
        end
    end
    $finish;
  end

  initial begin
    $dumpfile("fast_adder.vcd");
    $dumpvars(0,fast_adder_4bits_tb);
  end
endmodule