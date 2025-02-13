`timescale 1ns/1ps
    module test();
    reg [3:0] op;
    reg [15:0] expected;
    reg [15:0] A,B;
    reg [47+4:0] data [0:8];

    integer i;
    initial $readmemh("test_case.hex",data);
    initial begin
        #50;
        for (i = 0;i<10;i=i+1) begin
            #20 {op,A,B,expected} = data[i];
            $monitor("Time: %0t op: %d A: %d B: %d Expected : %d",$time,op,A,B,expected);
        end
        $finish;
    end
endmodule