module first_system(out1, out2, in1, in2);
  output out1,  out2;
  input in1, in2;
  wire not_0_out, or_0_out, xor_0_out, and_0_out;
  assign not_0_out = ~in2;
  assign out2 = not_0_out;
  assign or_0_out = in1 | in2;
  assign xor_0_out = and_0_out ^ or_0_out;
  assign out1 = xor_0_out;
  assign and_0_out = in1 & in2;
endmodule


module Main(out_0, out_1, inp_0, inp_1);
  output out_0,  out_1;
  input inp_0, inp_1;
  wire first_system_0_out_0, first_system_0_out_1;
  first_system first_system_0(first_system_0_out_0, first_system_0_out_1, inp_0, inp_1);
  assign out_1 = first_system_0_out_1;
  assign out_0 = first_system_0_out_0;
endmodule