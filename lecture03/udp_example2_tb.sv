// Testbench for the UDP
module top_module_tb;
  reg in1;
  reg in2;
  reg in3;
  wire out;

  top_module dut (
    .in1(in1),
    .in2(in2),
    .in3(in3),
    .out(out)
  );

  initial begin
    $monitor("Time=%0t, in1=%b, in2=%b, in3=%b, out=%b", $time, in1, in2, in3, out);

    // Test all specific combinations
    in1 = 0; in2 = 0; in3 = 0; #10;
    in1 = 0; in2 = 0; in3 = 1; #10;
    in1 = 0; in2 = 1; in3 = 0; #10;
    in1 = 0; in2 = 1; in3 = 1; #10;
    in1 = 1; in2 = 0; in3 = 0; #10;
    in1 = 1; in2 = 0; in3 = 1; #10;
    in1 = 1; in2 = 1; in3 = 0; #10;
    in1 = 1; in2 = 1; in3 = 1; #10;

    $finish;
  end
endmodule