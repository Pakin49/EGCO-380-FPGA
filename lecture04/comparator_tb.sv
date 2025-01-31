`timescale 1ns / 1ps

module magnitude_comparator_4bit_tb;

  // Inputs
  reg [3:0] a;
  reg [3:0] b;

  // Outputs
  wire a_gt_b;
  wire a_lt_b;
  wire a_eq_b;

  // Instantiate the Unit Under Test (UUT)
  magnitude_comparator_4bit uut (
    .a(a),
    .b(b),
    .a_gt_b(a_gt_b),
    .a_lt_b(a_lt_b),
    .a_eq_b(a_eq_b)
  );

  // Test vectors
  initial begin
    // Test case 1: a > b
    a = 4'b1010;  // 10
    b = 4'b0101;  // 5
    #10; // Wait for a short time

    // Test case 2: a < b
    a = 4'b0011;  // 3
    b = 4'b1000;  // 8
    #10;

    // Test case 3: a == b
    a = 4'b0110;  // 6
    b = 4'b0110;  // 6
    #10;

    // Test case 4: a = 0, b = max value
    a = 4'b0000;
    b = 4'b1111;
    #10;

    // Test case 5: a = max value, b = 0
    a = 4'b1111;
    b = 4'b0000;
    #10;

     // Test case 6: a = 0, b = 0
    a = 4'b0000;
    b = 4'b0000;
    #10;

    // Add more test cases as needed...

    $finish; // End the simulation
  end

  // Display the results (optional, but very helpful)
  initial begin
    $monitor("a = %d, b = %d, a_gt_b = %b, a_lt_b = %b, a_eq_b = %b", a, b, a_gt_b, a_lt_b, a_eq_b);
  end

endmodule