`timescale 1ns / 1ps

module truth_table_module_tb;

  // Inputs
  reg a;
  reg b;
  reg c;

  // Outputs
  wire out;

  // Instantiate the Unit Under Test (UUT)
  truth_table_module uut (
    .a(a),
    .b(b),
    .c(c),
    .out(out)
  );

  // Test vectors
  initial begin
    // Test case 1: 000
    a = 0; b = 0; c = 0; #10;  // #10 is a delay of 10 time units

    // Test case 2: 001
    a = 0; b = 0; c = 1; #10;

    // Test case 3: 010
    a = 0; b = 1; c = 0; #10;

    // Test case 4: 011
    a = 0; b = 1; c = 1; #10;

    // Test case 5: 100
    a = 1; b = 0; c = 0; #10;

    // Test case 6: 101
    a = 1; b = 0; c = 1; #10;

    // Test case 7: 110
    a = 1; b = 1; c = 0; #10;

    // Test case 8: 111
    a = 1; b = 1; c = 1; #10;

    $finish; // End the simulation
  end


  // Optional: Add a display task to print the results
  initial begin
    $monitor("Time=%0t, a=%b, b=%b, c=%b, out=%b", $time, a, b, c, out);
  end

endmodule