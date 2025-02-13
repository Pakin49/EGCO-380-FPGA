module up_down_counter_4bit (
  input clk,
  input rst,
  input inc_btn,
  input dec_btn,
  output [3:0] count
);

  wire debounced_inc_btn;
  wire debounced_dec_btn;

  debouncer inc_debouncer (
    .clk(clk),
    .rst(rst),
    .btn_in(inc_btn),
    .btn_out(debounced_inc_btn)
  );

  debouncer dec_debouncer (
    .clk(clk),
    .rst(rst),
    .btn_in(dec_btn),
    .btn_out(debounced_dec_btn)
  );


  reg [3:0] count_reg;

  always @(posedge clk) begin
    if (rst) begin
      count_reg <= 4'b0000;
    end else begin
      if (debounced_inc_btn && !debounced_dec_btn) begin
        count_reg <= count_reg + 1;
      end else if (!debounced_inc_btn && debounced_dec_btn) begin
        count_reg <= count_reg - 1;
      end else if (debounced_inc_btn && debounced_dec_btn) begin //Both pressed, maintain the value.
        count_reg <= count_reg;
      end else begin // Neither button pressed, maintain the value.
        count_reg <= count_reg;
      end
    end
  end

  assign count = count_reg;

endmodule