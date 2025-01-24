module multiplier_4x4_shift_add_tb;
  logic [3:0] a_tb;
  logic [3:0] b_tb;
  logic [7:0] product_tb;

  multiplier_4x4_shift_add dut (
    .a(a_tb),
    .b(b_tb),
    .product(product_tb)
  );

  initial begin
    // Test cases
    $monitor("a = %0d, b = %0d, product = %0d", a_tb, b_tb, product_tb);

    a_tb = 4'b0000; b_tb = 4'b0000; #10;
    a_tb = 4'b0001; b_tb = 4'b0001; #10; // 1 * 1 = 1
    a_tb = 4'b0010; b_tb = 4'b0011; #10; // 2 * 3 = 6
    a_tb = 4'b0100; b_tb = 4'b0101; #10; // 4 * 5 = 20
    a_tb = 4'b1000; b_tb = 4'b1001; #10; // 8 * 9 = 72
    a_tb = 4'b1111; b_tb = 4'b1111; #10; // 15 * 15 = 225
    a_tb = 4'b1010; b_tb = 4'b0110; #10; // 10 * 6 = 60

    $finish;
  end

endmodule