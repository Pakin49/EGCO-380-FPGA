`timescale 1ns / 1ps

module first_system_tb;

  // Inputs to the module under test
  reg in1;
  reg in2;

  // Outputs from the module under test
  wire out1;
  wire out2;

  // Instantiate the module under test (UUT)
  first_system uut (
    .out1(out1),
    .out2(out2),
    .in1(in1),
    .in2(in2)
  );

  // Stimulus generation
  initial begin
    // Initialize inputs
    in1 = 0;
    in2 = 0;

    // Test cases
    #10 in1 = 1'b0; in2 = 1'b0;
    #10 in1 = 1'b0; in2 = 1'b1;
    #10 in1 = 1'b1; in2 = 1'b0;
    #10 in1 = 1'b1; in2 = 1'b1;

    // Add more test cases as needed for thorough testing
      #10 in1 = 1'b0; in2 = 1'b1;
      #10 in1 = 1'b1; in2 = 1'b0;
      #10 in1 = 1'b1; in2 = 1'b1;

    #10 $finish; // End the simulation
  end

  // Monitor outputs (optional but highly recommended)
  initial begin
    $monitor("Time = %0t, in1 = %b, in2 = %b, out1 = %b, out2 = %b", $time, in1, in2, out1, out2);
  end

    // Dump waveforms to VCD file
  initial begin
    $dumpfile("first_system.vcd"); // Specify the VCD file name
    $dumpvars(0, first_system_tb); // Dump all signals in this module and below
  end

endmodule