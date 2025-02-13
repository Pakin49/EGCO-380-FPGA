`timescale 1ns/1ps

module tb_top;

  // Declare testbench signals that connect to the top module.
  reg CLK;
  reg PIN_13;  // Used for reset
  wire PIN_9;
  wire PIN_10;
  wire PIN_11;
  wire PIN_12;
  wire PIN_14;
  wire PIN_15;
  wire PIN_16;
  wire PIN_17;
  wire PIN_18;
  wire PIN_19;
  wire PIN_20;

  // Instantiate the top module (DUT)
  top dut (
    .CLK(CLK),
    .PIN_13(PIN_13),
    .PIN_9(PIN_9),
    .PIN_10(PIN_10),
    .PIN_11(PIN_11),
    .PIN_12(PIN_12),
    .PIN_14(PIN_14),
    .PIN_15(PIN_15),
    .PIN_16(PIN_16),
    .PIN_17(PIN_17),
    .PIN_18(PIN_18),
    .PIN_19(PIN_19),
    .PIN_20(PIN_20)
  );

  // Clock generation: create a clock with a period of 10ns.
  initial begin
    CLK = 0;
    forever #5 CLK = ~CLK;
  end

  // Simulation stimulus: apply reset and then run simulation.
  initial begin
    // Initially assert reset
    PIN_13 = 1;
    
    // Wait 15ns and then deassert reset
    #15;
    PIN_13 = 0;
    
    // Run simulation for a sufficient time to see output changes.
    #1000;
    $finish;
  end

  // Optional: Dump waveforms for viewing in a waveform viewer.
  initial begin
    $dumpfile("tb_top.vcd");
    $dumpvars(0, tb_top);
  end

  // Optional: Monitor signals for debugging.
  initial begin
    $monitor("Time=%0t | CLK=%b | PIN_13=%b | PIN_9=%b | PIN_10=%b | PIN_11=%b | PIN_12=%b | PIN_14=%b | PIN_15=%b | PIN_16=%b | PIN_17=%b | PIN_18=%b | PIN_19=%b | PIN_20=%b",
             $time, CLK, PIN_13, PIN_9, PIN_10, PIN_11, PIN_12, PIN_14, PIN_15, PIN_16, PIN_17, PIN_18, PIN_19, PIN_20);
  end

endmodule
