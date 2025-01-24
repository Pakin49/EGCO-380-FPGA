module debounce_tb;
    // Declare testbench signals
    reg pb_1;
    reg clk;
    wire pb_out;

    // Instantiate the debounce module
    debounce uut (
        .pb_1(pb_1),
        .clk(clk),
        .pb_out(pb_out)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Stimulus
    initial begin
        pb_1 = 1'b0; 
        #200;
        pb_1 = 1'b1; // Press button
      
        #10;
        pb_1 = 1'b0; // bouncing
      	#10;
        pb_1 = 1'b1; // bouncing
        #10;
        pb_1 = 1'b0; // bouncing
        #10;
        pb_1 = 1'b1; // bouncing
        #10
        pb_1 = 1'b1; // hold down button
        
        #200;
        pb_1 = 1'b0; // release button
        #200
      
        $finish;
    end

    // Monitor outputs
    initial begin
        $monitor("Time=%0t: clk=%b, slow_clk=%b, pb_1=%b, pb_out=%b", $time, clk, uut.slow_clk, pb_1, pb_out);
    end

    initial begin
        $dumpfile("debounce.vcd"); // Specify the VCD file name
        $dumpvars(0, debounce_tb); // Dump all signals in this module and below
    end

endmodule