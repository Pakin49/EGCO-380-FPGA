// User-Defined Primitive (UDP) for a 2-input XOR gate
primitive my_xor (output out, input a, input b);
  table
    0 0 : 0;
    0 1 : 1;
    1 0 : 1;
    1 1 : 0;
  endtable
endprimitive

// Module using the UDP
module top_module (input wire in1, input wire in2, output wire out);
  my_xor xor_gate (out, in1, in2);
endmodule