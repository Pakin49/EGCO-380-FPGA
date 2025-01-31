module truth_table_module (
  input a,
  input b,
  input c,
  output reg out // 'reg' because it's assigned inside an always block
);

always_comb begin // Combinational logic: trigger on any input change
  case ({a, b, c}) // Concatenate inputs to form the truth table index
    3'b000: out = 1'b0; // a=0, b=0, c=0  -> out = 0
    3'b001: out = 1'b1; // a=0, b=0, c=1  -> out = 1
    3'b010: out = 1'b1; // a=0, b=1, c=0  -> out = 1
    3'b011: out = 1'b0; // a=0, b=1, c=1  -> out = 0
    3'b100: out = 1'b1; // a=1, b=0, c=0  -> out = 1
    3'b101: out = 1'b0; // a=1, b=0, c=1  -> out = 0
    3'b110: out = 1'b0; // a=1, b=1, c=0  -> out = 0
    3'b111: out = 1'b1; // a=1, b=1, c=1  -> out = 1
    default: out = 1'bx; // Optional: handle unexpected input combinations (X for unknown)
  endcase
end

endmodule