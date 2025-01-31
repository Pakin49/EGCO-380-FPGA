module full_adder_4bit_carry_lookahead (
  input [3:0] a,
  input [3:0] b,
  input cin,
  output [3:0] sum,
  output cout
);

  // Generate propagate and generate signals for each bit
  wire [3:0] p, g;
  assign p = a ^ b; // Cpi (carry propagate for bit i)
  assign g = a & b; // Ggi (carry generate for bit i)

  // Calculate carry signals using carry lookahead logic
  wire c1, c2, c3;
  assign c1 = g[0] | (p[0] & cin);
  assign c2 = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
  assign c3 = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);
  assign cout = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & cin);

  // Calculate sum for each bit using the carry signals
  assign sum[0] = a[0] ^ b[0] ^ cin;
  assign sum[1] = a[1] ^ b[1] ^ c1;
  assign sum[2] = a[2] ^ b[2] ^ c2;
  assign sum[3] = a[3] ^ b[3] ^ c3;

endmodule