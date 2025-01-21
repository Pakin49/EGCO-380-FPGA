`timescale 1ns / 1ps

module blocking_nonblocking_tb;

  reg x;
  reg clk;
  wire [5:0] y;

  // Instantiate the module under test
  blocking_nonblocking dut (
    .y(y),
    .x(x),
    .clk(clk)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // Period = 10ns
  end

  // Test sequence
  initial begin
    x = 0;
    #10; // Wait for one clock cycle
    x = 1;
    #10; // Hold x = 1 for one clock cycle
    x = 0;
    #20; // Wait for two more clock cycles to observe the output
    $finish;
  end

    // Dump waves for visualization (optional)
    initial begin
        $dumpfile("blocking_nonblocking.vcd");
        $dumpvars(0, blocking_nonblocking_tb);
    end

endmodule