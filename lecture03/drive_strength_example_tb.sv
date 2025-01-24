module drive_strength_example_tb;

  reg a, b, c, d;
  wire out;

  drive_strength_example dut (
    .a(a),
    .b(b),
    .c(c),
    .d(d),
    .out(out)
  );

  initial begin
    // Test case 1: out_gate1 wins (high output)
    $display("Test case 1: out_gate1 wins (strong0 > pull1)");
    a = 1; b = 1; c = 0; d = 0; #10;
    
    // Test case 2: out_gate2 wins (low output)
    $display("Test case 2: out_gate2 wins (supply1 > weak0)");
    a = 0; b = 0; c = 1; d = 1; #10;

    $finish;
  end

  initial begin
    $monitor("a=%b, b=%b, c=%b, d=%b, out=%b", a, b, c, d, out);
  end

endmodule