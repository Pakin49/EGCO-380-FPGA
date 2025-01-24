module drive_strength_example(
  input a, b, c, d,
  output out
);

  wire out_gate1; 
  wire out_gate2; 

  and (out_gate1, a, b);
  and (out_gate2, c, d);

  // Connect both gate outputs to the same wire
  assign (weak0, pull1) out = out_gate1;
  assign (strong0, supply1) out = out_gate2;

endmodule