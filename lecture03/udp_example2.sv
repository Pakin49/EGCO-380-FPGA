// User-Defined Primitive (UDP) with 3 inputs and don't cares
primitive my_function (output out, input a, input b, input c);
  table
    // Specific combinations
    0 0 ? : 0;
    0 1 0 : 1;
    0 1 1 : 0;
    1 0 0 : 1;
    1 0 1 : 0;
    1 1 ? : 1;
  endtable
endprimitive

// Module using the UDP
module top_module (input wire in1, input wire in2, input wire in3, output wire out);
  my_function my_func_inst (out, in1, in2, in3);
endmodule