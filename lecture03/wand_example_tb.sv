module wand_example_tb;

  reg a, b;
  wire out;

  wand_example dut (
    .a(a),
    .b(b),
    .out(out)
  );

  initial begin
    $display("Test case 1: 1 AND 1");
    a = 1; b = 1; #10;
    
    $display("Test case 2: 1 AND 0");
    a = 1; b = 0; #10;
    
    $display("Test case 3: 0 AND 0");
    a = 0; b = 0; #10;

    $finish;
  end

  initial begin
    $monitor("a=%b, b=%b, out=%b", a, b, out);
  end

endmodule