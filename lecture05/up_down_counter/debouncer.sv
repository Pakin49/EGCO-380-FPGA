module debouncer (
  input clk,
  input rst,
  input btn_in,
  output reg btn_out
);

  wire Q1,Q2,Q2_bar,Q0;
  my_dff d0(clk, rst, btn_in, Q0);
  my_dff d1(clk, rst, Q0, Q1);
  my_dff d2(clk, rst, Q1, Q2);
  assign Q2_bar = ~Q2;
  assign btn_out = Q1 & Q2_bar;

endmodule