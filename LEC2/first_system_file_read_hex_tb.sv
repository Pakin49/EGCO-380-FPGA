`timescale 1ns/1ps

module first_system_file_read_tb;

    reg in1t, in2t;
    wire out1t, out2t;

    first_system uut (
        .out1(out1t),
        .out2(out2t),
        .in1(in1t),
        .in2(in2t)
    );

    reg [1:0] Testset [3:0]; // reg [1:0] means each element in the Testset array is a 2-bit register.
    // Testset [3:0] declares an array named Testset with 4 elements

    /*
    Testset:
    +-----+ +-----+ +-----+ +-----+
    | 1:0 | | 1:0 | | 1:0 | | 1:0 |  <-- Each location is 2 bits wide
    +-----+ +-----+ +-----+ +-----+
    [0]     [1]     [2]     [3]    <-- 4 locations in total
    */ 

    integer count;

    // load testset from file
  initial $readmemh("testset_entries_hex.hex", Testset); // NOTE: do not prefix hex numbers with 0x in the file

    initial begin
        #100;

        for(count = 0; count < 4; count = count + 1) begin
            #50 {in1t, in2t} = Testset[count];
            #50; // Separate delay
        end
    end

    initial begin
        $$display("   in1t   in2t   out1t   out2t");
        $monitor("Time = %0t, in1 = %b, in2 = %b, out1 = %b, out2 = %b", $time, in1t, in2t, out1t, out2t);
    end

    initial begin
        $dumpfile("first_system_file_read_tb.vcd");
        $dumpvars(0, first_system_file_read_tb);
    end
endmodule