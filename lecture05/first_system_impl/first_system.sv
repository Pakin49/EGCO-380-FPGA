module first_system(led, sw);

input [1:0]sw; // was in1, in2
output [1:0]led; // was out1, out2

wire and_out, or_out;

assign and_out = sw[0] & sw[1];
assign or_out = sw[0] | sw[1];
assign led[0] = and_out ^ or_out;
assign led[1] = ~sw[1];

endmodule 