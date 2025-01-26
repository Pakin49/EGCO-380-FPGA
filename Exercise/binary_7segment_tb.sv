`timescale 1ns / 1ps

module Binary_7segment_tb;
  reg [3:0] bin;
  wire a,b,c,d,e,f,g;
  
  Binary_7segment dut(
    .in(bin),
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .e(e),
    .f(f),
    .g(g)
  );
  
  initial begin
    integer i;
    for(i=0;i<=15;i=i+1) begin
      bin = i;
      #10;
    end
    $finish;
  end
  
  initial begin 
    $dumpfile("binary_7segment_decoder.vcd");
    $dumpvars(0,Binary_7segment_tb);
  end
endmodule
