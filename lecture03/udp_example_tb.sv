// Testbench for the UDP
module top_module_tb;
  reg in1;
  reg in2;
  wire out;

  // Instantiate the module under test
  top_module dut (
    .in1(in1),
    .in2(in2),
    .out(out)
  );

  // Clock generation (for demonstration, not strictly needed for this simple example)
  reg clk;
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Period of 10 time units
  end

  // Test sequences
  initial begin
    $monitor("Time=%0t, in1=%b, in2=%b, out=%b", $time, in1, in2, out); // Monitor signals
    in1 = 0; in2 = 0; #10;
    in1 = 0; in2 = 1; #10;
    in1 = 1; in2 = 0; #10;
    in1 = 1; in2 = 1; #10;
    $finish; // End the simulation
  end
endmodule